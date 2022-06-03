import 'package:first_app/Screens/Registration/splash%20_screen.dart';

import 'package:first_app/constants/Constantcolors.dart';

import 'package:first_app/provider/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() {
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
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        var themeprovider = Provider.of<ThemeProvider>(context, listen: false);

        return OverlaySupport(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeprovider.themeMode,
              darkTheme: Mytheme.darkTheme,
              theme: themeprovider.isDarkMode
                  ? ThemeData.dark()
                  : ThemeData.light(),

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
      },
    );
  }
}
