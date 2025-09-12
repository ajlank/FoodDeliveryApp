import 'dart:convert';

List<AddressModel> addressListFromJson(String str) => List<AddressModel>.from(
  json.decode(str).map((x) => AddressModel.fromJson(x)),
);

AddressModel addressDefaultFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

class AddressModel {
  final int id;
  final double lat;
  final double lan;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;
  final int userId;

  AddressModel({
    required this.id,
    required this.lat,
    required this.lan,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
    required this.userId,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"],
    lat: json["lat"]?.toDouble(),
    lan: json["lan"]?.toDouble(),
    isDefault: json["isDefault"],
    address: json["address"],
    phone: json["phone"],
    addressType: json["addressType"],
    userId: json["userId"],
  );
}
