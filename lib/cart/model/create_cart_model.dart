import 'dart:convert';

CreateCartModel createCartFromJson(String str) =>
    CreateCartModel.fromJson(json.decode(str));

String createCartToJson(CreateCartModel data) => json.encode(data.toJson());

class CreateCartModel {
  final int product;
  final int quantity;
  final String size;

  CreateCartModel({
    required this.product,
    required this.quantity,
    required this.size,
  });

  factory CreateCartModel.fromJson(Map<String, dynamic> json) =>
      CreateCartModel(
        product: json["product"],
        quantity: json["quantity"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
    "product": product,
    "quantity": quantity,
    "size": size,
  };
}
