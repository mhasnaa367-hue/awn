import 'package:awn/core/widget/document_card.dart';
import 'package:flutter/material.dart';

class FavoriteItem {
  final String title;
  final String date;
  final DocumentType type;

  FavoriteItem({
    required this.title,
    required this.date,
    required this.type,
  });
}

class FavoritesProvider extends ChangeNotifier {
  final List<FavoriteItem> _favorites = [];

  List<FavoriteItem> get favorites => _favorites;

  void addFavorite(FavoriteItem item) {
    _favorites.add(item);
    notifyListeners();
  }

  void removeFavorite(String title) {
    _favorites.removeWhere((item) => item.title == title);
    notifyListeners();
  }

  bool isFavorite(String title) {
    return _favorites.any((item) => item.title == title);
  }
}