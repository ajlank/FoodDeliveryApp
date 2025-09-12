import 'dart:convert';

CartCountModel cartCountFromJson(String str) =>
    CartCountModel.fromJson(json.decode(str));

String cartCountToJson(CartCountModel data) => json.encode(data.toJson());

class CartCountModel {
  final int cartCount;

  CartCountModel({required this.cartCount});

  factory CartCountModel.fromJson(Map<String, dynamic> json) =>
      CartCountModel(cartCount: json["cart_count"] ?? 0);

  Map<String, dynamic> toJson() => {"cart_count": cartCount};
}
