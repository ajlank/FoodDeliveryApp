import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
      json.decode(str).map((x) => CategoryModel.fromJson(x)),
    );

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  final String title;
  final String imageUrl;

  CategoryModel({required this.title, required this.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(title: json["title"], imageUrl: json["imageUrl"]);

  Map<String, dynamic> toJson() => {"title": title, "imageUrl": imageUrl};
}
