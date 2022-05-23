import 'dart:convert';

import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/article_model.dart';
import 'package:first_app/model/user_model.dart';
import 'package:http/http.dart' as http;

class API_Manager {
  Future<Welcome> getArtciles() async {
    var client = http.Client();
    var articleModel = null;
    try {
      var response = await client.get(Uri.parse(Strings.article_url));
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

  Future<Welcome> getArtcilesByAthor() async {
    var client = http.Client();
    var articleModel = null;
    try {
      var response = await client.get(Uri.parse(Strings.artical_byAthour));
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

  Future<RegisterWelcome> RegisterData() async {
    var client = http.Client();
    var RegisterModel = null;
    try {
      var response = await client.post(Uri.parse(Strings.register_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);

        RegisterModel = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      return RegisterModel;
    }
    return RegisterModel;
  }
}
