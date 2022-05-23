// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);

// import 'dart:convert';

// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

// class Welcome {
//   Welcome({
//     required this.status,
//     required this.totalResults,
//     required this.articles,
//   });

//   String status;
//   int totalResults;
//   List<Article> articles;

//   factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
//         status: json["status"],
//         totalResults: json["totalResults"],
//         articles: List<Article>.from(
//             json["articles"].map((x) => Article.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "totalResults": totalResults,
//         "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
//       };
// }

// class Article {
//   Article({
//     required this.source,
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });

//   Source source;
//   String author;
//   String title;
//   String description;
//   String url;
//   String urlToImage;
//   DateTime publishedAt;
//   String content;

//   factory Article.fromJson(Map<String, dynamic> json) => Article(
//         source: Source.fromJson(json["source"]),
//         author: json["author"] == null ? null : json["author"],
//         title: json["title"],
//         description: json["description"],
//         url: json["url"],
//         urlToImage: json["urlToImage"],
//         publishedAt: DateTime.parse(json["publishedAt"]),
//         content: json["content"],
//       );

//   Map<String, dynamic> toJson() => {
//         "source": source.toJson(),
//         "author": author == null ? null : author,
//         "title": title,
//         "description": description,
//         "url": url,
//         "urlToImage": urlToImage,
//         "publishedAt": publishedAt.toIso8601String(),
//         "content": content,
//       };
// }

// class Source {
//   Source({
//     required this.id,
//     required this.name,
//   });

//   String id;
//   String name;

//   factory Source.fromJson(Map<String, dynamic> json) => Source(
//         id: json["id"] == null ? null : json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "name": name,
//       };
// }
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.articles,
    required this.articlesCount,
  });

  List<Article> articles;
  int articlesCount;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
