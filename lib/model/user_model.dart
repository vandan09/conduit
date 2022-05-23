// To parse this JSON data, do
//
//     final RegisterWelcome = welcomeFromJson(jsonString);

import 'dart:convert';

RegisterWelcome welcomeFromJson(String str) =>
    RegisterWelcome.fromJson(json.decode(str));

String welcomeToJson(RegisterWelcome data) => json.encode(data.toJson());

class RegisterWelcome {
  RegisterWelcome({
    required this.user,
  });

  User user;

  factory RegisterWelcome.fromJson(Map<String, dynamic> json) =>
      RegisterWelcome(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.email,
    required this.username,
    this.bio,
    this.image,
    required this.token,
  });

  String email;
  String username;
  dynamic bio;
  dynamic image;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        username: json["username"],
        bio: json["bio"],
        image: json["image"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "bio": bio,
        "image": image,
        "token": token,
      };
}
