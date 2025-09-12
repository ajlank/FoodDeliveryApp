import 'dart:convert';

import 'package:foodapp/cart/model/cart_model.dart';

CreateOrderModel createOrderFromJson(String str) =>
    CreateOrderModel.fromJson(json.decode(str));

String createOrderToJson(CreateOrderModel data) => json.encode(data.toJson());

class CreateOrderModel {
  
  final double totalAmount;
  final List<CartItem> order_product;
  final String address;

  CreateOrderModel({
    required this.totalAmount,
    required this.order_product,
    required this.address,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) => CreateOrderModel(
    totalAmount: (json["totalAmount"]?.toDouble()) ?? 0.0,
    order_product: json["order_product"] == null
        ? []
        : List<CartItem>.from(
            (json["order_product"] as List).map((x) => CartItem.fromJson(x)),
          ),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "totalAmount": totalAmount,
    "order_product": List<dynamic>.from(order_product.map((x) => x.toJson())),
    "address": address,
  };
}

class CartItem {
  final String name;
  final String size;
  final int id;
  final double price;
  final int cartQuantity;

  CartItem({
    required this.name,
    required this.size,
    required this.id,
    required this.price,
    required this.cartQuantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    name: json["name"],
    size: json["size"],
    id: int.parse(json["id"].toString()),
    price: double.parse(json["price"].toString()),
    cartQuantity: int.parse(json["cartQuantity"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "id": id,
    "price": price,
    "cartQuantity": cartQuantity,
  };
}
