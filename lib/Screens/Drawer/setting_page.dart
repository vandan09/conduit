import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.greenColor),
        backgroundColor: constantColors.whiteColor,
        title: SizedBox(
          child: Text(
            'Setting',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.greenColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: TextField(
                onTap: FocusScope.of(context).unfocus,
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
              child: TextField(
                onTap: FocusScope.of(context).unfocus,
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
              child: TextField(
                onTap: FocusScope.of(context).unfocus,
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
              child: TextField(
                onTap: FocusScope.of(context).unfocus,
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
              child: TextField(
                obscureText: true,
                onTap: FocusScope.of(context).unfocus,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'New Password'),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: GestureDetector(
                onTap: () {},
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) => LogInPage(),
                      ));
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
        ],
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
