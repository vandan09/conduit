import 'dart:convert';

Deletecomment welcomeFromJson(String str) =>
    Deletecomment.fromJson(json.decode(str));

String welcomeToJson(Deletecomment data) => json.encode(data.toJson());

class Deletecomment {
  Deletecomment();

  factory Deletecomment.fromJson(Map<String, dynamic> json) => Deletecomment();

  Map<String, dynamic> toJson() => {};
}
