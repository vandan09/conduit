import 'dart:async';

import 'package:first_app/Screens/HomePage/home.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/services/shared_prefences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? name;
  retrieveUsernameValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs!.getString("username");
    });
    print('user name $name');
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

  ConstantColors constantColors = ConstantColors();
  final PrefServices _prefServices = PrefServices();
  @override
  void initState() {
    retrieveStringValue();
    retrieveUsernameValue();
    _prefServices.readCache("email").then((value) {
      if (value != null) {
        Timer(
            Duration(seconds: 2),
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => HomeScreen(token, name))),
                ));
      } else {
        Timer(
          Duration(seconds: 2),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => LogInPage()))),
        );
      }
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: constantColors.greenColor,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'conduit',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 55,
                  color: constantColors.whiteColor),
            ),
            Text(
              'A place to share your knowledge.',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                  color: constantColors.whiteColor),
            ),
          ]),
        ),
      ),
    );
  }
}
