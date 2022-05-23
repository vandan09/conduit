import 'package:first_app/Screens/Drawer/home.dart';
import 'package:first_app/Screens/Registration/splash%20_screen.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/model/user_model.dart';
import 'package:first_app/provider/auth_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/utils/shared_prefences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xff26872f)));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    // Future<User?> getUserData() => UserPreferences().getUser();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            // color: Color(0xff26872f),
            // backgroundColor: Color(0xff26872f)
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          // primaryColor: constantColors.whiteColor,
          fontFamily: 'TitilliumWeb',
        ),
        home: SplashScreen());
  }
}
