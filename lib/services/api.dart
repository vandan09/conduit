import 'dart:convert';

import 'package:first_app/Screens/Drawer/drawer.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/all_article_model.dart';
import 'package:first_app/model/article_model.dart';
import 'package:first_app/model/get_comment_model.dart';
import 'package:first_app/model/get_liked_modul.dart';
import 'package:first_app/model/user_model.dart';

import 'package:http/http.dart' as http;

class API_Manager {
  Future<GetLikedArticlle> getLikedArticles(
      String token, String username) async {
    var client = http.Client();
    String finalUrl = Strings.likedArticle_url + username;
    // print(finalUrl);
    // print('username is $username');
    // print('token is $token');

    // print('url is $finalUrl');

    var articleModel = null;
    try {
      var response = await client.get(
        Uri.parse(finalUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': "Token ${token}",
        },
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);

        articleModel = GetLikedArticlle.fromJson(jsonMap);
      }
    } on Exception {
      return articleModel;
    }
    return articleModel;
  }

  Future<AllArticlle> getAllArtciles(String token) async {
    var client = http.Client();
    var articleModel = null;
    try {
      var response = await client.get(
        Uri.parse(Strings.article_url),
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': "Token ${token}",
        },
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);

        articleModel = AllArticlle.fromJson(jsonMap);
      }
    } on Exception {
      return articleModel;
    }
    return articleModel;
  }

  Future<Welcome> getArtciles() async {
    var client = http.Client();
    var articleModel = null;
    try {
      var response = await client.get(
        Uri.parse(Strings.article_url),
        // headers: <String, String>{
        //   "Accept": "application/json",
        //   "content-type": "application/json",
        //   'Authorization': "Token ${token}",
        // },
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);

        articleModel = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      return articleModel;
    }
    return articleModel;
  }

  Future<GetCommentModel> getComments(String token, String slug) async {
    var client = http.Client();
    var articleModel = null;
    String commentUrl = "${Strings.comment_url1}/$slug/${Strings.comment_url2}";
    try {
      var response = await client.get(
        Uri.parse(commentUrl),
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': "Token ${token}",
        },
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);

        articleModel = GetCommentModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return articleModel;
    }
    return articleModel;
  }
}
