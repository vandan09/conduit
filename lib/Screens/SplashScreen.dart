import 'dart:async';

import 'package:first_app/Screens/Registration/logIn.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConstantColors constantColors = ConstantColors();
  @override
  void initState() {
    // TODO: implement initState
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LogInPage()))),
    );
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
