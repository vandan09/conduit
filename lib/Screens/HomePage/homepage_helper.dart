import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_app/Screens/Drawer/drawer.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/delete_fav.dart';
import 'package:first_app/model/liked_article_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageHelper extends StatelessWidget {
  SharedPreferences? prefs;

  // String? name;
  // retrieveUsernameValue() async {
  //   prefs = await SharedPreferences.getInstance();

  //   name = prefs!.getString("username");

  //   print('user name $name');
  // }

  // String? token;

  // retrieveStringValue() async {
  //   prefs = await SharedPreferences.getInstance();

  //   token = prefs!.getString("token");

  //   print('token value $token');
  // }

  ConstantColors constantColors = ConstantColors();
  final List<String> imgList = [
    'assets/images/a.jpg',
    'assets/images/c2.jpg',
    'assets/images/c3.jpg',
    'assets/images/c4.jpg',
    'assets/images/c5.jpg'
  ];

  TabController? _tabController;

  Widget carouselWidget(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 1,
          aspectRatio: 16 / 9,
          autoPlay: true,
          autoPlayAnimationDuration: Duration(seconds: 1)),
      items: imgList.map((item) => Image.asset(item, width: 1500)).toList(),
    );
  }

  doLikedArticle(
      String token, String name, String slug, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: constantColors.transperant,
            actions: [
              Center(
                  child: CircularProgressIndicator(
                color: constantColors.greenColor,
              ))
            ],
          );
        });

    print('valid');
    // retrieveStringValue();

    String finalUrl =
        "${Strings.favorited_url1}/$slug/${Strings.favorited_url2}";
    try {
      http.Response response = await http.post(Uri.parse(finalUrl),
          // body: json.encode(userBody),
          // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': "Token ${token}",
          });
      if (response.statusCode == 200) {
        print('slug value at hime $slug');
        print('username value at hime $name');

        print('Article liked');
        LikedArticlle.fromJson(jsonDecode(response.body));
        Navigator.pop(context);

        Flushbar(
          title: 'Article liked',
          message: ' ',
          duration: Duration(seconds: 3),
        ).show(context);
      } else {
        String str1 = jsonDecode(response.body).toString();
        String str2 = str1.replaceAll(new RegExp(r"\p{P}", unicode: true), "");
        // String error = str2.substring(7);
        Navigator.pop(context);

        Flushbar(
          title: 'Invalid',
          message: '${str2}',
          duration: Duration(seconds: 3),
        ).show(context);
      }
    } catch (e) {
      Navigator.pop(context);

      print(e);
    }
  }

  doDissLikedArticle(
      String token, String name, String slug, BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: constantColors.transperant,
            actions: [
              Center(
                  child: CircularProgressIndicator(
                color: constantColors.greenColor,
              ))
            ],
          );
        });

    print('valid');
    // retrieveStringValue();

    String deleteUrl =
        "${Strings.deleteFav_url1}/$slug/${Strings.deleteFav_url2}";
    try {
      http.Response response = await http.delete(Uri.parse(deleteUrl),
          // body: json.encode(userBody),
          // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': "Token ${token}",
          });
      if (response.statusCode == 200) {
        // print('Article Disliked');
        DeleteFav.fromJson(jsonDecode(response.body));
        Navigator.pop(context);

        Flushbar(
          title: 'Article Disliked',
          message: ' ',
          duration: Duration(seconds: 3),
        ).show(context);
      } else {
        String str1 = jsonDecode(response.body).toString();
        String str2 = str1.replaceAll(new RegExp(r"\p{P}", unicode: true), "");
        // String error = str2.substring(7);
        Navigator.pop(context);

        Flushbar(
          title: 'Invalid',
          message: '${str2}',
          duration: Duration(seconds: 3),
        ).show(context);
      }
    } catch (e) {
      Navigator.pop(context);

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
