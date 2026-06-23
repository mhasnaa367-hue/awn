import 'package:awn/core/API/document_setup.dart';
import 'package:awn/core/API/domain/entities/document.dart';
import 'package:awn/core/API/domain/repositories/document_repository.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/utils/responsive.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/app_snack_bar.dart';
import 'package:awn/core/widget/document_card.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final DocumentRepository _documents = createDocumentRepository();

  List<Document> _docs = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page = await _documents.listDocuments(page: 1, limit: 50);
      if (!mounted) return;
      setState(() {
        _docs = page.documents;
        _loading = false;
      });
    } on ServerException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.errModel.errorMessage;
        _loading = false;
      });
    }
  }

  Future<void> _delete(Document doc) async {
    final l = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l.delete),
        content: Text(l.deleteDocumentConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await _documents.deleteDocument(doc.id);
      if (!mounted) return;
      setState(() => _docs.removeWhere((d) => d.id == doc.id));
      AppSnackBar.show(context, l.documentDeleted, isSuccess: true);
    } on ServerException catch (e) {
      if (!mounted) return;
      AppSnackBar.show(context, e.errModel.errorMessage, isSuccess: false);
    }
  }

  DocumentType _typeFor(String fileType) {
    final t = fileType.toLowerCase();
    if (t == 'pdf') return DocumentType.pdf;
    if (t == 'jpg' || t == 'jpeg' || t == 'png' || t == 'image') {
      return DocumentType.image;
    }
    return DocumentType.file;
  }

  String _subtitleFor(Document doc) {
    if (doc.createdAt.length >= 10) return doc.createdAt.substring(0, 10);
    return doc.status;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Appbar(title: l.history),
            Expanded(child: _buildBody(l)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(AppLocalizations l) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
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
                _error!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontSize: context.sp(15),
                ),
              ),
              SizedBox(height: context.hp(3)),
              GradientButton(width: context.wp(50), text: l.retry, onTap: _load),
            ],
          ),
        ),
      );
    }

    if (_docs.isEmpty) {
      return RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          children: [
            SizedBox(height: context.hp(30)),
            Center(
              child: Text(
                l.noDocuments,
                style: GoogleFonts.inter(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  fontSize: context.sp(16),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ResponsiveCenter(
        maxWidth: 720,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: context.wp(5), vertical: context.hp(2)),
          itemCount: _docs.length,
          separatorBuilder: (_, __) => SizedBox(height: context.hp(1.5)),
          itemBuilder: (context, index) {
            final doc = _docs[index];
            return DocumentCard(
              title: doc.originalName,
              date: _subtitleFor(doc),
              type: _typeFor(doc.fileType),
              onTap: () => Navigator.pushNamed(
                context,
                RoutesManager.result,
                arguments: doc.id,
              ),
              onDelete: () => _delete(doc),
            );
          },
        ),
      ),
    );
  }
}
