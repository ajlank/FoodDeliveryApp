import 'package:flutter/material.dart';
import 'package:foodapp/views/auth/sign_up_view.dart';
import 'package:get_storage/get_storage.dart';

class OfferView extends StatelessWidget {
  const OfferView({super.key});

  @override
  Widget build(BuildContext context) {
    final accessToken = GetStorage().read('accessToken');
    if (accessToken == null) {
      return SignUpView();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: double.infinity,

        child: Column(
          children: List.generate(200, (index) {
            return Text('offer');
          }),
        ),
      ),
    );
  }
}
