import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_app/Screens/Drawer/drawer.dart';
import 'package:first_app/Screens/HomePage/home.dart';
import 'package:first_app/Screens/others/liked_articles.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/comment_model.dart';
import 'package:first_app/model/delete_article_model.dart';
import 'package:first_app/model/delete_fav.dart';
import 'package:first_app/model/liked_article_model.dart';
import 'package:first_app/model/update_article_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageHelper extends StatelessWidget {
  SharedPreferences? prefs;

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

  deleteArticle(
      String token, String slug, BuildContext context, String name) async {
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

    String deleteArticleUrl = "${Strings.deleterArticle_url}$slug";
    try {
      http.Response response = await http.delete(Uri.parse(deleteArticleUrl),
          // body: json.encode(userBody),
          // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': "Token ${token}",
          });
      if (response.statusCode == 200) {
        // print('Article Disliked');
        DeleteArticle.fromJson(jsonDecode(response.body));
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen(token, name)));

        Flushbar(
          title: 'Article Deleted',
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

  updateArticle(
    String slug,
    String name,
    String token,
    GlobalKey<FormState> _formkey,
    BuildContext context,
    String desc,
  ) async {
    if (_formkey.currentState!.validate()) {
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
      _formkey.currentState!.save();

      print('valid');
      // retrieveStringValue();

      var userBody = <String, dynamic>{
        "article": {"body": desc}
      };
      String updateArticle = "${Strings.updateArticle_url}/$slug";
      try {
        http.Response response = await http.put(Uri.parse(updateArticle),
            body: json.encode(userBody),
            // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
            headers: <String, String>{
              "Accept": "application/json",
              "content-type": "application/json",
              'Authorization': "Token ${token}",
            });
        if (response.statusCode == 200) {
          print('Article updated');
          UpdateArticle.fromJson(jsonDecode(response.body));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => HomeScreen(token, name))));
          Flushbar(
            title: 'Article updated',
            message: ' ',
            duration: Duration(seconds: 3),
          ).show(context);
        } else {
          String str1 = jsonDecode(response.body).toString();
          String str2 =
              str1.replaceAll(new RegExp(r"\p{P}", unicode: true), "");
          // String error = str2.substring(7);
          Navigator.pop(context);

          Flushbar(
            title: 'Invalid form',
            message: '${str2}',
            duration: Duration(seconds: 3),
          ).show(context);
        }
      } catch (e) {
        Navigator.pop(context);

        print(e);
      }
    } else {
      Flushbar(
        title: 'Invalid form',
        message: 'Please complete the form properly',
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  deleteComment(String token, String slug, BuildContext context, String name,
      int id) async {
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

    String commentUrl =
        "${Strings.comment_url1}/$slug/${Strings.comment_url2}/$id";
    try {
      http.Response response = await http.delete(Uri.parse(commentUrl),
          // body: json.encode(userBody),
          // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': "Token ${token}",
          });
      if (response.statusCode == 200) {
        // print('Article Disliked');
        DeleteArticle.fromJson(jsonDecode(response.body));
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen(token, name)));

        Flushbar(
          title: 'Comment Deleted',
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

  void doPulishComment(
      GlobalKey<FormState> _formkey,
      BuildContext context,
      String comment,
      String slug,
      String token,
      TextEditingController commentController,
      String name) async {
    if (_formkey.currentState!.validate()) {
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
      _formkey.currentState!.save();

      print('valid');
      print(slug);
      // retrieveStringValue();

      var userBody = <String, dynamic>{
        "comment": {"body": comment}
      };
      String commentUrl =
          "${Strings.comment_url1}/$slug/${Strings.comment_url2}";
      try {
        http.Response response = await http.post(Uri.parse(commentUrl),
            body: json.encode(userBody),
            // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
            headers: <String, String>{
              "Accept": "application/json",
              "content-type": "application/json",
              'Authorization': "Token ${token}",
            });
        if (response.statusCode == 200) {
          print('Article published');
          CommentModel.fromJson(jsonDecode(response.body));
          commentController.clear();
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomeScreen(token, name)));

          Flushbar(
            title: 'Comment Publish',
            message: ' ',
            duration: Duration(seconds: 3),
          ).show(context);
        } else {
          String str1 = jsonDecode(response.body).toString();
          String str2 =
              str1.replaceAll(new RegExp(r"\p{P}", unicode: true), "");
          // String error = str2.substring(7);
          Navigator.pop(context);

          Flushbar(
            title: 'Invalid form',
            message: '${str2}',
            duration: Duration(seconds: 3),
          ).show(context);
        }
      } catch (e) {
        Navigator.pop(context);

        print(e);
      }
    } else {
      Flushbar(
        title: 'Invalid form',
        message: 'Please complete the form properly',
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
