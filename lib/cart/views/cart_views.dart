
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/address/hooks/fetch/fetch_default_address.dart';
import 'package:foodapp/address/views/address_view.dart';
import 'package:foodapp/cart/controller/cart_controller.dart';
import 'package:foodapp/cart/hooks/fetch/fetch_cart.dart';
import 'package:foodapp/cart/views/cart_counter.dart';
import 'package:foodapp/stripe_payment/services/payment_services.dart';
import 'package:foodapp/stripe_payment/services/stripe_service.dart';
import 'package:get/get.dart';

class CartViews extends HookWidget {
  const CartViews({super.key});

  @override
  Widget build(BuildContext context) {
    
    final result = fetchCart();
    final isLoading = result.isLoading;
    final error = result.error;
    final refetch = result.refetch;
    
    final resultad=fetchDefaultAddress();
    final isLoading_g=resultad.isLoading;

    CartController ct = Get.put(CartController());
    
    if (isLoading && isLoading_g) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final cart = result.cart;
    final address=resultad.address!.address;
    final addressId=resultad.address!.id;
    final total = cart.fold<double>(
      0.0,
      (sum, item) => sum + (item.quantity * item.product.price),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDFDFC),
        elevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black87),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          AddressView(),
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(cart.length, (i) {
                final cartItem = cart[i];

                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          cartItem.product.images[0],
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.product.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Price: \$ ${cartItem.product.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return (ct.selectedCart != null &&
                                ct.selectedCart == cartItem.id)
                            ? CartCounter(
                                cartItem: cartItem,
                                onUpdate: () {
                                  ct.updateCart(cartItem.id, refetch);
                                },
                                onDelete: () {
                                  ct.deleteCart(cartItem.id, refetch);
                                },
                              )
                            : GestureDetector(
                                onTap: () {
                                  ct.setSelectedCounter(
                                    cartItem.id,
                                    cartItem.quantity,
                                  );
                                },
                                child: Text('*${cartItem.quantity}'),
                              );
                      }),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: (){
                
              //  StripeService.instance.makePayment(total);
               PaymentServices.instance.makePayment(total,context,cart,addressId);
           
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
              label: const Text(
                "Checkout",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
