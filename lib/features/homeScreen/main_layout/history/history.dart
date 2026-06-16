import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/document_card.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          Appbar(title: l.history),
          const SizedBox(height: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DocumentCard(
                      title: "Cloud Monitoring Summary",
                      date: "Last viewed: Oct 15, 2025",
                      type: DocumentType.camera,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DocumentCard(
                      title: "DevOps Overview",
                      date: "Last viewed: Oct 9, 2025",
                      type: DocumentType.file,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DocumentCard(
                      title: "Incident Response Guide",
                      date: "Last viewed: Sep 20, 2025",
                      type: DocumentType.image,
                      showFavoriteButton: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}