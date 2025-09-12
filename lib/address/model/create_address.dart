import 'dart:convert';

CreateAddress createAddressFromJson(String str) =>
    CreateAddress.fromJson(json.decode(str));

String createAddressToJson(CreateAddress data) => json.encode(data.toJson());

class CreateAddress {
  final double lat;
  final double lan;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;

  CreateAddress({
    required this.lat,
    required this.lan,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
  });

  factory CreateAddress.fromJson(Map<String, dynamic> json) => CreateAddress(
    lat: json["lat"]?.toDouble(),
    lan: json["lan"]?.toDouble(),
    isDefault: json["isDefault"],
    address: json["address"],
    phone: json["phone"],
    addressType: json["addressType"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lan": lan,
    "isDefault": isDefault,
    "address": address,
    "phone": phone,
    "addressType": addressType,
  };
}


//An opportunity  to build an entire app
// or even a whole technology stack from scratch
// for a small, up-and-coming , scrappy startup