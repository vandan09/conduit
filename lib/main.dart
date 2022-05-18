import 'package:first_app/Screens/Drawer/home.dart';
import 'package:first_app/Screens/SplashScreen.dart';
import 'package:first_app/Screens/Registration/logIn.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          // primaryColor: constantColors.whiteColor,
          fontFamily: 'TitilliumWeb',
        ),
        home: SplashScreen());
  }
}
