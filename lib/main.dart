import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:foodapp/api/firebase_api.dart';
import 'package:foodapp/bottomNavViews/home_view.dart';
import 'package:foodapp/bottomNavViews/widgets/offer/offer_view.dart';
import 'package:foodapp/bottomNavViews/widgets/profile/profile_view.dart';
import 'package:foodapp/bottomNavViews/widgets/foodpannelwidget/widgetviews/foodWidget/menu_details.dart';
import 'package:foodapp/cart/views/cart_views.dart';
import 'package:foodapp/location/screen/map_screen.dart';
import 'package:foodapp/order/views/order_tracking_view.dart';
import 'package:foodapp/order/views/order_view.dart';
import 'package:foodapp/stripe_payment/constsval/consts.dart';
import 'package:foodapp/uiController/getXController/home_view_controller.dart';
import 'package:foodapp/utils/routes.dart';
import 'package:foodapp/views/auth/login_view.dart';
import 'package:foodapp/views/auth/sign_up_view.dart';
import 'package:foodapp/wishlist/views/wishlist_view.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=stripePublishableKey;
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await FirebaseApi().initNotifications();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'Food Delivery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomeView();
      },  
    ),
       GoRoute(
      path: loginRoute,
      builder: (BuildContext context, GoRouterState state) {
        return LoginView();
      },  
    ),
     GoRoute(
      path: signUpRoute,
      builder: (BuildContext context, GoRouterState state) {
        return SignUpView();
      },  
    ),
      GoRoute(
      path: menuDetailsRoute,
      builder: (BuildContext context, GoRouterState state) {
        return MenuDetails();
      },  
    ),
    GoRoute(
      path: cartRoute,
      builder: (BuildContext context, GoRouterState state) {
        return CartViews();
      },  
    ),
    GoRoute(
      path: orderTrackRoute,
      builder: (BuildContext context, GoRouterState state) {
        return OrderTrackingView();
      },  
    ),
    GoRoute(
      path: searchRoute,
      builder: (BuildContext context, GoRouterState state) {
        return SearchBar();
      },  
    ),
       GoRoute(
      path: mapScreenRoute,
      builder: (BuildContext context, GoRouterState state) {
        return MapScreen();
      },  
    ),
  ],
);

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  final List<Widget> navViews = const [
    HomeView(),
    OrderView(),
    OfferView(),
    WishlistView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    HomeViewController controller = Get.put(HomeViewController());
    return Obx(() {

      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 234, 233),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.blueGrey,
          selectedItemColor: Colors.amber,
          currentIndex: controller.getCurrentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_mini), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined),
              label: 'Offer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_3_outlined),
              label: 'Profile',
            ),
          ],
          onTap: (v) {
            controller.setCurrentIndex = v;
          },
        ),
        body: navViews[controller.getCurrentIndex],
      );
    });
  }
}
