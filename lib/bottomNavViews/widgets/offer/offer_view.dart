import 'package:flutter/material.dart';
import 'package:foodapp/views/auth/sign_up_view.dart';
import 'package:get_storage/get_storage.dart';

class OfferView extends StatelessWidget {
  const OfferView({super.key});

  @override
  Widget build(BuildContext context) {
    final accessToken = GetStorage().read('accessToken');

    if (accessToken == null) {
      return const SignUpView();
    }

    final offers = [
      {
        "image":
            "https://img.freepik.com/free-photo/tasty-burger-isolated-white-background-fresh-hamburger-fastfood-with-beef-cheese_90220-1192.jpg",
        "title": "Burger Bonanza",
        "discount": "30% OFF",
        "description": "Delicious beef burgers with cheese and fries combo."
      },
      {
        "image":
            "https://img.freepik.com/premium-photo/close-up-pizza-with-pepperoni-mozzarella-white-background_207126-14273.jpg",
        "title": "Pizza Feast",
        "discount": "25% OFF",
        "description": "Cheesy pepperoni pizza with free cold drinks."
      },
      {
        "image":
            "https://img.freepik.com/free-photo/asian-food-wooden-table_1150-18614.jpg",
        "title": "Asian Special",
        "discount": "40% OFF",
        "description": "Authentic Asian noodles and spicy rice bowls."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exclusive Offers"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    offer["image"]!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            offer["title"]!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              offer["discount"]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        offer["description"]!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            // handle offer click
                          },
                          child: const Text("Order Now"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
