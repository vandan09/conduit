import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Screens/Drawer/drawer.dart';
import 'package:first_app/Screens/HomePage/home.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/new_article_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({super.key});

  @override
  State<NewArticlePage> createState() => _NewArticlePageState();
}

class _NewArticlePageState extends State<NewArticlePage> {
  ConstantColors constantColors = ConstantColors();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? CustomeValidaor(String? value) {
    String? _msg;

    if (value!.isEmpty) {
      _msg = "Required";
    }
    return _msg;
  }

  String? token;
  SharedPreferences? prefs;

  retrieveStringValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs!.getString("token");
    });
    print('token value $token');
  }

  String? name;
  retrieveUsernameValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs!.getString("username");
    });

    print('user name $name');
  }

  void doPulishArticle(String title, String about, String desc, tag) async {
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
      retrieveStringValue();

      var userBody = <String, dynamic>{
        "article": {
          "title": title,
          "description": about,
          "body": desc,
          "tagList": tag
        }
      };

      try {
        http.Response response = await http.post(Uri.parse(Strings.article_url),
            body: json.encode(userBody),
            // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
            headers: <String, String>{
              "Accept": "application/json",
              "content-type": "application/json",
              'Authorization': "Token ${token!}",
            });
        if (response.statusCode == 200) {
          print('Article published');
          CreateArticle.fromJson(jsonDecode(response.body));
          retrieveStringValue();
          retrieveUsernameValue();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => HomeScreen(token!, name!))));
          Flushbar(
            title: 'Article Publish',
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: SizedBox(
          child: Text(
            'New Article',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              //title
              Container(
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: TextFormField(
                    onTap: (() {
                      retrieveStringValue();
                    }),
                    // onTap: FocusScope.of(context).unfocus,
                    autofocus: false,
                    controller: titleController,
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Article Title'),
                  )),
              SizedBox(
                height: 20,
              ),
              //about
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    // onTap: FocusScope.of(context).unfocus,
                    autofocus: false,
                    // controller: _controller,
                    controller: aboutController,

                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "What's this article about?"),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    // onTap: FocusScope.of(context).unfocus,
                    keyboardType: TextInputType.multiline,
                    // controller: _controller,
                    controller: descController,

                    maxLines: null,
                    minLines: 5,
                    validator: CustomeValidaor,

                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write your article '),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextFormField(
                  // onTap: FocusScope.of(context).unfocus,
                  validator: CustomeValidaor,
                  // controller: _controller,
                  controller: tagController,

                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter tags'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: GestureDetector(
                    onTap: () {
                      doPulishArticle(
                          titleController.text,
                          aboutController.text,
                          descController.text,
                          tagController.text);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                    },
                    child: CustomRaisedButton(
                      buttonText: 'Publish Article',
                    )),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
