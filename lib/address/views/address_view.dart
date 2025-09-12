import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foodapp/address/controller/address_controller.dart';
import 'package:foodapp/address/hooks/fetch/fetch_default_address.dart';
import 'package:foodapp/utils/change_address_bottom_sheet.dart';
import 'package:get/get.dart';

class AddressView extends HookWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchDefaultAddress();
    final isLoading = result.isLoading;
    final error = result.error;
    final ct = Get.put(AddressController());

    if (isLoading) {
      return CircularProgressIndicator();
    }
    final address = result.address?.address ?? 'No address found';
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Delivery Location'),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_off_outlined),
                    SizedBox(width: 3),
                    Text(
                      ct.address.value != null
                          ? ct.address.value!.address.toString()
                          : address,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextButton(
                onPressed: () async {
                  await changeAddressBottomSheet(context);
                },
                child: const Text('Change Location'),
              ),
            ),
          ],
        ),
      );
    });
  }
}
