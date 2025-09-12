import 'dart:convert';

List<FoodListModel> foodModelFromJson(String str) => List<FoodListModel>.from(
  json.decode(str).map((x) => FoodListModel.fromJson(x)),
);

String foodModelToJson(List<FoodListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodListModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final bool isFeatured;
  final String foodTypes;
  final double ratings;
  final int calories;
  final int time;
  final int category;
  final int brand;
  final List<String> sizes;
  final List<String> images;
  final DateTime createdAt;

  FoodListModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.isFeatured,
    required this.foodTypes,
    required this.ratings,
    required this.calories,
    required this.time,
    required this.category,
    required this.brand,
    required this.sizes,
    required this.images,
    required this.createdAt,
  });

  factory FoodListModel.fromJson(Map<String, dynamic> json) => FoodListModel(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    isFeatured: json["is_featured"],
    foodTypes: json["foodTypes"],
    ratings: json["ratings"]?.toDouble(),
    calories: json["calories"],
    time: json["time"],
    category: json["category"],
    brand: json["brand"],
    sizes: List<String>.from(json["sizes"].map((x) => x)),
    images: List<String>.from(json["images"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
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
    "createdAt": createdAt.toIso8601String(),
  };
}
