import 'package:awn/core/utils/responsive.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            Appbar(title: l.favorites),
            Expanded(
              child: Consumer<FavoritesProvider>(
                builder: (context, provider, _) {
                  final favorites = provider.favorites;

                  if (favorites.isEmpty) {
                    return Center(child: Text(l.noFavorites));
                  }

                  return ResponsiveCenter(
                    maxWidth: 720,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.wp(5), vertical: context.hp(2)),
                      itemCount: favorites.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: context.hp(1.5)),
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
      ),
    );
  }
}
