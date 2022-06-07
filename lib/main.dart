import 'package:first_app/Screens/Registration/splash%20_screen.dart';

import 'package:first_app/constants/Constantcolors.dart';

import 'package:first_app/provider/theme.dart';
import 'package:first_app/services/google_singin.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xff26872f)));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConstantColors constantColors = ConstantColors();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Future<User?> getUserData() => UserPreferences().getUser();
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInPRovider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // themeMode: themeprovider.themeMode,
          // darkTheme: Mytheme.darkTheme,
          // theme: themeprovider.isDarkMode
          //     ? ThemeData.dark()
          //     : ThemeData.light(),

          // appBarTheme: AppBarTheme(
          // color: Color(0xff26872f),
          // backgroundColor: Color(0xff26872f)
          //   systemOverlayStyle: SystemUiOverlayStyle.light,
          // ),
          // primaryColor: constantColors.whiteColor,
          //   fontFamily: 'TitilliumWeb',
          // ),
          home: SplashScreen()),
    );
  }
}
