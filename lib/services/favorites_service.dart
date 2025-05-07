import 'package:flutter/foundation.dart';

class FavoritesService with ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  bool isFavorite(Map<String, dynamic> product) {
    return _favorites.any((item) => item['id'] == product['id']);
  }

  void toggleFavorite(Map<String, dynamic> product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((item) => item['id'] == product['id']);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
