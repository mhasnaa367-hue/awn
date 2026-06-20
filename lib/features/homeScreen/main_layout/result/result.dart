import 'package:awn/core/resources/assets_manager.dart';
import 'package:awn/core/resources/colors_manager.dart';
import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/gradient_button.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/widget/document_card.dart';
import '../../../../core/widget/favorites_provider.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Appbar(
              title: l.result,
              actions: Consumer<FavoritesProvider>(
                builder: (context, provider, _) {
                  final isFav = provider.isFavorite("Result");
                  return GestureDetector(
                    onTap: () {
                      final item = FavoriteItem(
                        title: "Result",
                        date: "",
                        type: DocumentType.file,
                      );
                      if (isFav) {
                        provider.removeFavorite(item.title);
                      } else {
                        provider.addFavorite(item);
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
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      l.mainTopic,
                      style: GoogleFonts.inter(
                        color: colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Incident Response Guide",
                      style: GoogleFonts.inter(
                        color: colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Divider(
                      color: colorScheme.outline.withOpacity(0.3),
                      thickness: 1,
                      endIndent: 20,
                      indent: 20,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      l.summary,
                      style: GoogleFonts.inter(
                        color: colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Comprehensive monitoring and incident management Cloud deployments allow teams to connect their tools from end to end, making it easier to monitor all parts of the pipeline "
                          "Comprehensive monitoring is another key capability for organizations practicing DevOps because it allows them to address issues and incidents faster.",
                      style: GoogleFonts.inter(
                        color: colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: colorScheme.outline.withOpacity(0.3),
                      thickness: 1,
                      endIndent: 20,
                      indent: 20,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      l.watchVideos,
                      style: GoogleFonts.inter(
                        color: colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Image.asset(AssetsManager.video, width: 150),
                        const SizedBox(width: 14),
                        Text(
                          "Introduction to DevOps\nMonitoring, why it matters",
                          style: GoogleFonts.inter(
                            color: colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Image.asset(AssetsManager.video, width: 150),
                        const SizedBox(width: 14),
                        Text(
                          "Incident Management in\n Cloud Environments\n explained",
                          style: GoogleFonts.inter(
                            color: colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Image.asset(AssetsManager.video, width: 150),
                        const SizedBox(width: 14),
                        Text(
                          "How to connect monitoring\ntools across your DevOps\npipeline",
                          style: GoogleFonts.inter(
                            color: colorScheme.onSurface.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}