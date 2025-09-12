import 'dart:convert';

AuthTokenModel authTokenFromJson(String str) =>
    AuthTokenModel.fromJson(json.decode(str));

String authTokenToJson(AuthTokenModel data) => json.encode(data.toJson());

class AuthTokenModel {
  final String authToken;

  AuthTokenModel({required this.authToken});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      AuthTokenModel(authToken: json["auth_token"]);

  Map<String, dynamic> toJson() => {"auth_token": authToken};
}
