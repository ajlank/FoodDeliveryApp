import 'package:flutter/material.dart';
import 'package:foodapp/auth/controller/auth_controller.dart';
import 'package:foodapp/auth/model/login_model.dart';
import 'package:foodapp/utils/routes.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Logo
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://www.nicepng.com/png/detail/131-1314271_food-icon-food-court-icon-png.png',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Welcome to Food Junction',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Username field
                  TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'Username',
                      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password field
                  TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final username = _username.text;
                        final password = _password.text;
                        LoginModel user = LoginModel(
                          username: username,
                          password: password,
                        );
                        String data = loginModelToJson(user);
                        authController.loginFunc(data, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Register
                  TextButton(
                    onPressed: () {
                     context.go(signUpRoute);
                    },
                    child: const Text(
                      'Not registered yet? Register here',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
