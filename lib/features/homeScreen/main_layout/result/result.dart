import 'dart:async';

import 'package:awn/core/API/document_setup.dart';
import 'package:awn/core/API/domain/entities/document.dart';
import 'package:awn/core/API/domain/entities/topic.dart';
import 'package:awn/core/API/domain/entities/video.dart';
import 'package:awn/core/API/domain/repositories/document_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/widget/document_card.dart';
import '../../../../core/widget/favorites_provider.dart';

class Result extends StatefulWidget {
  const Result({super.key, this.documentId});

  // The id of the document to display. If null, nothing is loaded (the screen
  // simply shows an empty state).
  final String? documentId;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final DocumentRepository _documents = createDocumentRepository();

  Document? _doc;
  bool _loading = true;
  String? _error;
  Timer? _pollTimer;
  final Set<int> _refreshingTopics = {};

  @override
  void initState() {
    super.initState();
    if (widget.documentId == null) {
      _loading = false;
    } else {
      _load();
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final doc = await _documents.getDocument(widget.documentId!);
      if (!mounted) return;
      setState(() {
        _doc = doc;
        _loading = false;
      });
      // Keep polling while the AI is still working.
      if (doc.isProcessing) _startPolling();
    } on ServerException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.errModel.errorMessage;
        _loading = false;
      });
    }
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      try {
        final status = await _documents.getStatus(widget.documentId!);
        if (!mounted) return;
        if (!status.isProcessing) {
          _pollTimer?.cancel();
          await _load(); // reload the full document now that it's ready/failed
        }
      } on ServerException catch (_) {
        // Transient error while polling — keep trying on the next tick.
      }
    });
  }

  Future<void> _refreshVideos(int topicIndex) async {
    setState(() => _refreshingTopics.add(topicIndex));
    try {
      final videos =
          await _documents.refreshTopicVideos(widget.documentId!, topicIndex);
      if (!mounted) return;
      final topics = List<Topic>.from(_doc!.topics);
      final old = topics[topicIndex];
      topics[topicIndex] =
          Topic(title: old.title, summary: old.summary, videos: videos);
      setState(() {
        _doc = _copyWithTopics(topics);
      });
    } on ServerException catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    } finally {
      if (mounted) setState(() => _refreshingTopics.remove(topicIndex));
    }
  }

  Document _copyWithTopics(List<Topic> topics) {
    final d = _doc!;
    return Document(
      id: d.id,
      originalName: d.originalName,
      fileType: d.fileType,
      fileSize: d.fileSize,
      status: d.status,
      errorMessage: d.errorMessage,
      summary: d.summary,
      topics: topics,
      createdAt: d.createdAt,
      updatedAt: d.updatedAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Appbar(
              title: l.result,
              actions: _doc == null ? null : _favoriteButton(colorScheme),
            ),
            Expanded(child: _buildBody(context, l, colorScheme)),
          ],
        ),
      ),
    );
  }

  Widget _favoriteButton(ColorScheme colorScheme) {
    final title = _doc?.originalName.isNotEmpty == true
        ? _doc!.originalName
        : "Result";
    return Consumer<FavoritesProvider>(
      builder: (context, provider, _) {
        final isFav = provider.isFavorite(title);
        return GestureDetector(
          onTap: () {
            if (isFav) {
              provider.removeFavorite(title);
            } else {
              provider.addFavorite(FavoriteItem(
                title: title,
                date: "",
                type: DocumentType.file,
              ));
            }
          },
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isFav
                  ? ColorsManager.green
                  : colorScheme.onSurface.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite, color: Colors.white, size: 16),
          ),
        );
      },
    );
  }

  Widget _buildBody(
      BuildContext context, AppLocalizations l, ColorScheme colorScheme) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.documentId == null) {
      return _centered(l.noSummary, colorScheme);
    }

    if (_error != null) {
      return _retryState(l, colorScheme, _error!);
    }

    final doc = _doc;
    if (doc == null) {
      return _retryState(l, colorScheme, l.loadFailed);
    }

    if (doc.isProcessing) {
      return _processingState(l, colorScheme);
    }

    if (doc.isFailed) {
      // A failed document is permanent on the server — reloading it just shows
      // the same error. The real "retry" is to upload the file again, so send
      // the user back to Home.
      return _retryState(
        l,
        colorScheme,
        doc.errorMessage ?? l.failedTitle,
        title: l.failedTitle,
        actionLabel: l.uploadFile,
        onAction: () => Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesManager.homeScreen,
          (route) => false,
        ),
      );
    }

    return _doneState(context, l, colorScheme, doc);
  }

  Widget _centered(String text, ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: colorScheme.onSurface.withOpacity(0.6),
            fontSize: context.sp(16),
          ),
        ),
      ),
    );
  }

  Widget _processingState(AppLocalizations l, ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: context.hp(3)),
            Text(
              l.processingTitle,
              style: GoogleFonts.inter(
                color: colorScheme.onSurface,
                fontSize: context.sp(18),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: context.hp(1)),
            Text(
              l.processingDesc,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontSize: context.sp(14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _retryState(AppLocalizations l, ColorScheme colorScheme, String message,
      {String? title, String? actionLabel, VoidCallback? onAction}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.wp(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                color: ColorsManager.red, size: context.r(56)),
            SizedBox(height: context.hp(2)),
            Text(
              title ?? l.loadFailed,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: colorScheme.onSurface,
                fontSize: context.sp(18),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: context.hp(1)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontSize: context.sp(14),
              ),
            ),
            SizedBox(height: context.hp(3)),
            GradientButton(
              width: context.wp(55),
              text: actionLabel ?? l.retry,
              onTap: onAction ?? _load,
            ),
          ],
        ),
      ),
    );
  }

  Widget _doneState(BuildContext context, AppLocalizations l,
      ColorScheme colorScheme, Document doc) {
    final divider = Divider(
      color: colorScheme.outline.withOpacity(0.3),
      thickness: 1,
      indent: context.wp(2),
      endIndent: context.wp(2),
    );

    return RefreshIndicator(
      onRefresh: _load,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ResponsiveCenter(
          maxWidth: 720,
          padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.hp(2)),
              _sectionTitle(l.mainTopic, colorScheme),
              SizedBox(height: context.hp(2)),
              Text(
                doc.originalName,
                style: GoogleFonts.inter(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontSize: context.sp(16),
                ),
              ),
              SizedBox(height: context.hp(3)),
              divider,
              SizedBox(height: context.hp(3)),
              if (doc.summary.isNotEmpty) ...[
                _sectionTitle(l.summary, colorScheme),
                SizedBox(height: context.hp(1.6)),
                Text(
                  doc.summary,
                  style: GoogleFonts.inter(
                    color: colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                    fontSize: context.sp(16),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: context.hp(2)),
                divider,
                SizedBox(height: context.hp(3)),
              ],
              // Each topic with its summary + videos.
              for (int i = 0; i < doc.topics.length; i++)
                _topicBlock(context, l, colorScheme, doc.topics[i], i),
              SizedBox(height: context.hp(4)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topicBlock(BuildContext context, AppLocalizations l,
      ColorScheme colorScheme, Topic topic, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _sectionTitle(topic.title, colorScheme)),
            _refreshingTopics.contains(index)
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    tooltip: l.refreshVideos,
                    onPressed: () => _refreshVideos(index),
                    icon: Icon(Icons.refresh, color: ColorsManager.green),
                  ),
          ],
        ),
        if (topic.summary.isNotEmpty) ...[
          SizedBox(height: context.hp(1)),
          Text(
            topic.summary,
            style: GoogleFonts.inter(
              color: colorScheme.onSurface.withOpacity(0.6),
              fontSize: context.sp(15),
              height: 1.5,
            ),
          ),
        ],
        SizedBox(height: context.hp(2)),
        Text(
          l.watchVideos,
          style: GoogleFonts.inter(
            color: colorScheme.onSurface,
            fontSize: context.sp(16),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: context.hp(1.5)),
        if (topic.videos.isEmpty)
          Text(
            l.noVideos,
            style: GoogleFonts.inter(
              color: colorScheme.onSurface.withOpacity(0.5),
              fontSize: context.sp(14),
            ),
          )
        else
          ...topic.videos.map((v) => _videoRow(context, colorScheme, v)),
        SizedBox(height: context.hp(3)),
      ],
    );
  }

  Widget _videoRow(BuildContext context, ColorScheme colorScheme, Video video) {
    final thumbWidth = context.wp(38).clamp(120.0, 200.0);
    return Padding(
      padding: EdgeInsets.only(bottom: context.hp(2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: thumbWidth,
              height: thumbWidth * 0.56,
              child: video.thumbnail.isNotEmpty
                  ? Image.network(
                      video.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Image.asset(AssetsManager.video, fit: BoxFit.cover),
                    )
                  : Image.asset(AssetsManager.video, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: context.wp(3.5)),
          Expanded(
            child: Text(
              video.title,
              style: GoogleFonts.inter(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: context.sp(14),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text, ColorScheme colorScheme) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: colorScheme.onSurface,
        fontSize: context.sp(20),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
