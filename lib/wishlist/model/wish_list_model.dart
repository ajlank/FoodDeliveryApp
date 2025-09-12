import 'dart:convert';

List<WishListModel> wishListModelFromJson(String str) =>
    List<WishListModel>.from(
      json.decode(str).map((x) => WishListModel.fromJson(x)),
    );

String wishListModelToJson(List<WishListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishListModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String? foodTypes;
  final double? ratings;
  final int? calories;
  final int? time;
  final int? category;
  final int? brand;
  final List<String> sizes;
  final List<String> images;
  final DateTime? createdAt;

  WishListModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    this.foodTypes,
    this.ratings,
    this.calories,
    this.time,
    this.category,
    this.brand,
    required this.sizes,
    required this.images,
    this.createdAt,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    id: json["id"] ?? 0,
    title: json["title"] ?? "",
    price: (json["price"] ?? 0).toDouble(),
    description: json["description"] ?? "",
    isFeatured: json["is_featured"] ?? false,
    foodTypes: json["foodTypes"],
    ratings: json["ratings"]?.toDouble(),
    calories: json["calories"],
    time: json["time"],
    category: json["category"],
    brand: json["brand"],
    sizes: json["sizes"] != null
        ? List<String>.from(json["sizes"].map((x) => x))
        : [],
    images: json["images"] != null
        ? List<String>.from(json["images"].map((x) => x))
        : [],
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "is_featured": isFeatured,
    "foodTypes": foodTypes,
    "ratings": ratings,
    "calories": calories,
    "time": time,
    "category": category,
    "brand": brand,
    "sizes": List<dynamic>.from(sizes.map((x) => x)),
    "images": List<dynamic>.from(images.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
  };
}
