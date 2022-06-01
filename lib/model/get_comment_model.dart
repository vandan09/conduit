// To parse this JSON data, do
//
//     final GetCommentModel = welcomeFromJson(jsonString);

import 'dart:convert';

GetCommentModel welcomeFromJson(String str) =>
    GetCommentModel.fromJson(json.decode(str));

String welcomeToJson(GetCommentModel data) => json.encode(data.toJson());

class GetCommentModel {
  GetCommentModel({
    required this.comments,
  });

  List<Comment> comments;

  factory GetCommentModel.fromJson(Map<String, dynamic> json) =>
      GetCommentModel(
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.body,
    required this.author,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String body;
  Author author;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        body: json["body"],
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "body": body,
        "author": author.toJson(),
      };
}

class Author {
  Author({
    required this.username,
    this.bio,
    required this.image,
    required this.following,
  });

  String username;
  dynamic bio;
  String image;
  bool following;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        username: json["username"],
        bio: json["bio"],
        image: json["image"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "bio": bio,
        "image": image,
        "following": following,
      };
}
