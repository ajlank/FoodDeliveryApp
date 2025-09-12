import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String email;
  final String username;
  final int id;

  UserModel({required this.email, required this.username, required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    username: json["username"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "username": username,
    "id": id,
  };
}
