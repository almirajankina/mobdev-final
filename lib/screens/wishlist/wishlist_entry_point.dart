import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/favorites_service.dart';
import 'wishlist_screen.dart';
import 'wishlist_empty_screen.dart';

class WishlistEntryPoint extends StatelessWidget {
  const WishlistEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesService>(context).favorites;

    if (favorites.isEmpty) {
      return const WishlistEmptyScreen();
    } else {
      return const WishlistScreen();
    }
  }
}
