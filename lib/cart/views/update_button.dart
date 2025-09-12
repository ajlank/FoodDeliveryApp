import 'package:flutter/material.dart';
import 'package:foodapp/cart/controller/cart_controller.dart';
import 'package:get/get.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, this.onUpdate});

  final void Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    CartController ct = Get.put(CartController());

    return GestureDetector(
      onTap: onUpdate,
      onLongPress: () {
        ct.clearSelected();
      },
      child: Container(
        width: 65,
        height: 18,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 172, 142, 142),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Update',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
