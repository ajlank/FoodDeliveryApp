import 'package:flutter/material.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/widgetviews/foodWidget/food_card.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/widgetviews/foodWidget/food_pannel.dart';
import 'package:foodapp/bottomNavViews/widgets/homeTopPannel/home_top_widget.dart';
import 'package:foodapp/bottomNavViews/widgets/offer/offer_pannel.dart';
import 'package:foodapp/common/reusable_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        // width: double.infinity,
        child: Column(
          children: [
            HomeTopWidget(),
            SizedBox(height: 10),
            ReusableHeader(leftText: "Today's Offer!", rightText: 'See All'),
            SizedBox(height: 6),
            OfferPannel(),
            SizedBox(height: 15),
            FoodPannel(),
            SizedBox(height: 15),
            ReusableHeader(leftText: 'Fastest Near You', rightText: 'See All'),
            SizedBox(height: 15),
            FoodCard(),
          ],
        ),
      ),
    );
  }
}
