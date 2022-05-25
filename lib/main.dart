import 'package:first_app/Screens/Drawer/home.dart';
import 'package:first_app/Screens/Registration/splash%20_screen.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/model/user_model.dart';
import 'package:first_app/provider/auth_provider.dart';
import 'package:first_app/provider/theme.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/utils/shared_prefences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        final themeprovider =
            Provider.of<ThemeProvider>(context, listen: false);

        return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeprovider.themeMode,
            darkTheme: Mytheme.darkTheme,
            theme:
                themeprovider.isDarkMode ? ThemeData.dark() : ThemeData.light(),

            // appBarTheme: AppBarTheme(
            // color: Color(0xff26872f),
            // backgroundColor: Color(0xff26872f)
            //   systemOverlayStyle: SystemUiOverlayStyle.light,
            // ),
            // primaryColor: constantColors.whiteColor,
            //   fontFamily: 'TitilliumWeb',
            // ),
            home: SplashScreen());
      },
    );
  }
}
