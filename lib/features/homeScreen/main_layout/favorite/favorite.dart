import 'package:awn/core/widget/Appbar.dart';
import 'package:awn/core/widget/document_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awn/core/resources/colors_manager.dart';

import '../../../../core/widget/favorites_provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Appbar(title: "Favorites"),
          Expanded(
            child: Consumer<FavoritesProvider>(
              builder: (context, provider, _) {
                final favorites = provider.favorites;

                if (favorites.isEmpty) {
                  return const Center(
                    child: Text('No favorites yet'),
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