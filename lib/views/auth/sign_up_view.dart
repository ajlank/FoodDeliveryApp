import 'package:flutter/material.dart';
import 'package:foodapp/auth/controller/auth_controller.dart';
import 'package:foodapp/auth/model/register_model.dart';
import 'package:foodapp/utils/routes.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late final TextEditingController _userName;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _userName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
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
                    child: Image.asset(
                      'assets/logo.png', // Add your app logo here
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create your Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Username field
                  TextField(
                    controller: _userName,
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
                  // Email field
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.email),
                      hintText: 'Email',
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
                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final userName = _userName.text;
                        final email = _email.text;
                        final password = _password.text;

                        RegisterModel user = RegisterModel(
                          username: userName,
                          email: email,
                          password: password,
                        );
                        String data = registerModelToJson(user);
                        authController.registerFunc(data);
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
                        'Sign Up',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Already have account
                  TextButton(
                    onPressed: () {
                     context.go(loginRoute);
                    },
                    child: const Text(
                      'Already registered? Login here',
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
