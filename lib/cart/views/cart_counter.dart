import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/cart/controller/cart_controller.dart';
import 'package:foodapp/cart/model/cart_model.dart';
import 'package:foodapp/cart/views/update_button.dart';
import 'package:get/get.dart';

class CartCounter extends HookWidget {
  const CartCounter({
    super.key,
    required this.cartItem,
    required this.onUpdate,
    required this.onDelete,
  });
  final CartModel cartItem;

  final void Function()? onUpdate;
  final void Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    CartController ct = Get.put(CartController());

    return Obx(() {
      return Row(
        children: [
          IconButton(
            onPressed: () => ct.decrement(),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text(
            ct.qty.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: () => ct.increment(),
            icon: const Icon(Icons.add_circle_outline),
          ),
          UpdateButton(onUpdate: onUpdate),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          ),
        ],
      );
    });
  }
}
