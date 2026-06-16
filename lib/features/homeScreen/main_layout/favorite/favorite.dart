import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/document_card.dart';
import 'package:awn/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widget/favorites_provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          Appbar(title: l.favorites),
          Expanded(
            child: Consumer<FavoritesProvider>(
              builder: (context, provider, _) {
                final favorites = provider.favorites;

                if (favorites.isEmpty) {
                  return Center(
                    child: Text(l.noFavorites),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: ListView.separated(
                    itemCount: favorites.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = favorites[index];
                      return DocumentCard(
                        title: item.title,
                        date: item.date,
                        type: item.type,
                        showFavoriteButton: true,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}