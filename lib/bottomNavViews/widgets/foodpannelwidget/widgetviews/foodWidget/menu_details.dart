import 'package:flutter/material.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/widgetviews/foodWidget/suggestions_pannel.dart';
import 'package:foodapp/cart/controller/cart_controller.dart';
import 'package:foodapp/cart/model/create_cart_model.dart';
import 'package:foodapp/common/reusable_header.dart';
import 'package:foodapp/homeproductList/controller/menu_item_controller.dart';
import 'package:get/get.dart';

class MenuDetails extends StatelessWidget {
  const MenuDetails({super.key});

  @override
  Widget build(BuildContext context) {
    MenuItemController menuItemController = Get.put(MenuItemController());
   
       if (menuItemController.selectedFood == null) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  final food = menuItemController.selectedFood!;
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: CartBottomSheet(
          id:food.id,
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color.fromARGB(255, 236, 236, 234),
              expandedHeight: 320,
              collapsedHeight: 65,
              floating: true,
              leading: IconButton(
                onPressed: () {
                  menuItemController.clearFood();
                  Navigator.of(context).pop();
                },
                icon: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              actions: [
                Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 242, 241, 241),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(child: const Text('Menu Details')),
                ),
                SizedBox(width: 90),
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Icon(Icons.heart_broken_outlined),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(25),
                  child: Image.network(
                    fit: BoxFit.cover,
                   food.images[0],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      // height: 500,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                food.title,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                food.sizes.length,
                                  (i) {
                                    var size =
                                        food.sizes[i];
                                    bool isSelected =
                                        menuItemController.size == size;

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 6.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () =>
                                            menuItemController.setSize(size),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.amber
                                                : Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.amber.shade700
                                                  : Colors.grey.shade400,
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            size,
                                            style: TextStyle(
                                              fontSize: 12, // 👈 smaller text
                                              fontWeight: FontWeight.w600,
                                              color: isSelected
                                                  ? Colors.black
                                                  : Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 11,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Ratings'),
                              SizedBox(height: 7),
                              Row(
                                children: [
                                  Icon(Icons.star_border_outlined),
                                  SizedBox(width: 4),
                                  Text(
                                    food.ratings
                                        .toStringAsFixed(1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Calories'),
                              SizedBox(height: 7),
                              Row(
                                children: [
                                  Icon(Icons.heart_broken_outlined),
                                  SizedBox(width: 4),
                                  Text(
                                   food.calories
                                        .toString(),
                                  ),
                                  Text('kcal'),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Times'),
                              SizedBox(height: 7),
                              Row(
                                children: [
                                  Icon(Icons.stop_circle_outlined),
                                  SizedBox(width: 4),
                                  Text(
                                    food.time
                                        .toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 11,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 2,
                            height:
                                food
                                    .description
                                    .length
                                    .toDouble() /
                                2,
                            color: Colors.black,
                          ),

                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              food.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReusableHeader(
                      leftText: 'Suggestions For',
                      rightText: 'View all',
                    ),
                    SuggestionsPannel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    MenuItemController ct = Get.put(MenuItemController());
    CartController c = Get.put(CartController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "2 items",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                "Price: \$12.00",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

          ElevatedButton.icon(
            onPressed: () {
              var data = CreateCartModel(
                product: id,
                quantity: 1,
                size: ct.size,
              );
              String cartData = createCartToJson(data);
              c.add(cartData, context, MenuItemController());
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Item added to cart")));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text(
              "Add to Cart",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
