import 'dart:convert';

DeleteArticle welcomeFromJson(String str) =>
    DeleteArticle.fromJson(json.decode(str));

String welcomeToJson(DeleteArticle data) => json.encode(data.toJson());

class DeleteArticle {
  DeleteArticle();

  factory DeleteArticle.fromJson(Map<String, dynamic> json) => DeleteArticle();

  Map<String, dynamic> toJson() => {};
}
