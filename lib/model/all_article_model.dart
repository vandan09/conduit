// To parse this JSON data, do
//
//     final AllArticlle = welcomeFromJson(jsonString);

import 'dart:convert';

AllArticlle welcomeFromJson(String str) =>
    AllArticlle.fromJson(json.decode(str));

String welcomeToJson(AllArticlle data) => json.encode(data.toJson());

class AllArticlle {
  AllArticlle({
    required this.articles,
    required this.articlesCount,
  });

  List<Article> articles;
  int articlesCount;

  factory AllArticlle.fromJson(Map<String, dynamic> json) => AllArticlle(
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
        articlesCount: json["articlesCount"],
      );

  Map<String, dynamic> toJson() => {
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "articlesCount": articlesCount,
      };
}

class Article {
  Article({
    required this.slug,
    required this.title,
    required this.description,
    required this.body,
    required this.tagList,
    required this.createdAt,
    required this.updatedAt,
    required this.favorited,
    required this.favoritesCount,
    required this.author,
  });

  String slug;
  String title;
  String description;
  String body;
  List<String> tagList;
  DateTime createdAt;
  DateTime updatedAt;
  bool favorited;
  int favoritesCount;
  Author author;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        slug: json["slug"],
        title: json["title"],
        description: json["description"],
        body: json["body"],
        tagList: List<String>.from(json["tagList"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        favorited: json["favorited"],
        favoritesCount: json["favoritesCount"],
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "title": title,
        "description": description,
        "body": body,
        "tagList": List<dynamic>.from(tagList.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "favorited": favorited,
        "favoritesCount": favoritesCount,
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
