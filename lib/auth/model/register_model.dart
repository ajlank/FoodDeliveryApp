import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final String email;
  final String username;
  final String password;

  RegisterModel({
    required this.email,
    required this.username,
    required this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    email: json["email"],
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "username": username,
    "password": password,
  };
}
