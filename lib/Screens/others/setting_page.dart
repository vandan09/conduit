import 'dart:convert';
import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Screens/Drawer/drawer.dart';
// import 'package:first_app/Screens/Drawer/Home.dart';
import 'package:first_app/Screens/HomePage/home.dart';
// import 'package:first_app/Screens/Drawer/Home.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';

import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/user_model.dart';
import 'package:first_app/services/shared_prefences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  PrefServices _prefServices = PrefServices();

  ConstantColors constantColors = ConstantColors();
  final TextEditingController _controller = TextEditingController();
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
  String? emailValue;

  retrieveStringValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs!.getString("token");
    });
    print('token value $token');
  }

  retrieveemailValue() async {
    prefs = await SharedPreferences.getInstance();
    emailValue = prefs!.getString("email");
    print('user email $emailValue');
  }

  String? name;
  retrieveUsernameValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs!.getString("username");
    });
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
      retrieveStringValue();
      retrieveemailValue();
      _formkey.currentState!.save();

      print('valid');

      var userBody = <String, dynamic>{
        "user": {"email": emailValue}
      };

      try {
        http.Response response = await http.put(Uri.parse(Strings.setting_url),
            body: json.encode(userBody),
            // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
            headers: <String, String>{
              "Accept": "application/json",
              "content-type": "application/json",
              'Authorization': "Token ${token!}",
            });
        if (response.statusCode == 200) {
          print('Article published');
          RegisterWelcome.fromJson(jsonDecode(response.body));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => HomeScreen(token, name))));
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
            'Setting',
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
              Container(
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: TextFormField(
                    onTap: () {
                      retrieveemailValue();
                      retrieveStringValue();
                    },
                    autofocus: false,
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'URL of profile picture'),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Bio"),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    obscureText: true,
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'New Password'),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(token, name)));
                        print('Entered');
                        Flushbar(
                          title: 'Setting updated',
                          message: ' ',
                          duration: Duration(seconds: 2),
                        ).show(context);
                      } else {
                        Flushbar(
                          title: 'Invalid form',
                          message: 'Please complete the form properly',
                          duration: Duration(seconds: 2),
                        ).show(context);
                      }
                    },
                    child: CustomRaisedButton(
                      buttonText: 'Update Settings',
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: constantColors.greyColor,
                ),
              ),
              //logout
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: GestureDetector(
                      onTap: () {
                        _prefServices.removeCache("email").whenComplete(() {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInPage()),
                              (Route<dynamic> route) => false);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: constantColors.redColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Or click here to logout',
                          style: TextStyle(color: constantColors.redColor),
                        ),
                      )),
                ),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
