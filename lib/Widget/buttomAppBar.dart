import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarState();
}

class _BottomAppBarState extends State<BottomAppBarPage> {
  ConstantColors constantColors = ConstantColors();
  final Uri _url = Uri.parse(
      'https://github.com/gothinkster/angularjs-realworld-example-app');

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [constantColors.blueGreyColor, constantColors.greyColor],
      )),
      // color: constantColors.blueGreyColor,
      child: GestureDetector(
        onTap: _launchUrl,
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 110),
          height: 50,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/images/Github.png',
              height: 25,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Fork on Github',
              style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ]),
        ),
      ),
    );
  }
}
