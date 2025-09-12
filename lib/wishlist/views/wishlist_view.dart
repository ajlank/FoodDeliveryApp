import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/views/auth/sign_up_view.dart';
import 'package:foodapp/wishlist/hooks/fetch/fetch_wishlist.dart';
import 'package:get_storage/get_storage.dart';

class WishlistView extends HookWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchWishList();
    final isLoading = result.isLoading;
    final isError = result.error;

    if (isLoading) {
      return CircularProgressIndicator();
    }
    final wishList = result.foods;
    final accessToken = GetStorage().read('accessToken');
    if (accessToken == null) {
      return SignUpView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: List.generate(wishList.length, (i) {
          final item = wishList[i];

          return _wishlistItem(
            image: item.images[0],
            title: item.title,
            subtitle: item.description,
            price: item.price.toString(),
          );
        }),
      ),
    );
  }

  Widget _wishlistItem({
    required String image,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // later remove from wishlist
              },
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
