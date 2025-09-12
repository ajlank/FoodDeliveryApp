import 'dart:convert';

List<SuggestionsModel> suggestionsModelFromJson(String str) =>
    List<SuggestionsModel>.from(
      json.decode(str).map((x) => SuggestionsModel.fromJson(x)),
    );

String suggestionsModelToJson(List<SuggestionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SuggestionsModel {
  final int id;
  final String title;
  final List<String> imageUrl;

  SuggestionsModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory SuggestionsModel.fromJson(Map<String, dynamic> json) =>
      SuggestionsModel(
        id: json["id"],
        title: json["title"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
  };
}
