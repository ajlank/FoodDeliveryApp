import 'package:flutter/material.dart';
import 'package:foodapp/auth/controller/auth_controller.dart';
import 'package:foodapp/auth/model/register_model.dart';
import 'package:foodapp/utils/routes.dart';
import 'package:get/get.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Register'),
            SizedBox(height: 15),
            TextField(
              controller: _userName,
              decoration: InputDecoration(hintText: 'Enter your username'),
            ),
            TextField(
              controller: _email,
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            SizedBox(height: 12),
            TextButton(
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
              child: const Text('Sign Up'),
            ),
            SizedBox(height: 4),
            TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Already registered? login here'),
            ),
          ],
        ),
      ),
    );
  }
}
