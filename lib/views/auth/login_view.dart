import 'package:flutter/material.dart';
import 'package:foodapp/auth/controller/auth_controller.dart';
import 'package:foodapp/auth/model/login_model.dart';
import 'package:foodapp/utils/routes.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login'),
            SizedBox(height: 15),
            TextField(
              controller: _username,
              decoration: InputDecoration(hintText: 'Enter your username'),
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                final username = _username.text;
                final password = _password.text;
                LoginModel user = LoginModel(
                  username: username,
                  password: password,
                );
                String data = loginModelToJson(user);
                print('Meow');
                print(data);
                authController.loginFunc(data, context);
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(homeRoute, (_) => false);
              },
              child: const Text('Sign In'),
            ),
            SizedBox(height: 4),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(signUpRoute, (route) => false);
              },
              child: const Text('Not registered yet? register here'),
            ),
          ],
        ),
      ),
    );
  }
}

//Tomas
//tomas@gmail.com
//1234abcRw@#qqq
