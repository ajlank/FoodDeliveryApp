import 'package:flutter/material.dart';
import 'package:foodapp/auth/controller/auth_controller.dart';
import 'package:foodapp/auth/model/user_model.dart';
import 'package:foodapp/bottomNavViews/widgets/profile/profile_list_tile.dart';
import 'package:foodapp/views/auth/sign_up_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final accessToken = GetStorage().read('accessToken');
    if (accessToken == null) {
      return SignUpView();
    }
    AuthController authController = Get.put(AuthController());
    UserModel? user = authController.userData();
    return Scaffold(
      body:  ListView(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35.0,
                      backgroundImage: NetworkImage(
                        'https://tse2.mm.bing.net/th/id/OIP.BVqRl5JkZkoe4SuUU2ENggHaHa?pid=Api&P=0&h=220',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(user!.email),
                    SizedBox(height: 10),
                    Text(
                      user.username,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              ProfileListTile(title: 'My orders', leading: Icons.checklist),
              ProfileListTile(
                title: 'Shipping Address',
                onTap: () {
                  // context.push('/address');
                },
                leading: Icons.location_pin,
              ),
              ProfileListTile(title: 'Privacy Policy', leading: Icons.policy),
              ProfileListTile(title: 'Help', leading: Icons.help),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                    authController.logout(context);
                    },
                    child: const Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }
}
// Container(
//           color: Colors.white12,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 200,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 35.0,
//                       backgroundImage: NetworkImage(
//                         '',
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(user!.email),
//                     SizedBox(height: 10),
//                     Text(
//                       user.username,
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),