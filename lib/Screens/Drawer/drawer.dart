import 'package:first_app/Screens/others/new_article.dart';
import 'package:first_app/Screens/HomePage/home.dart';
// import 'package:first_app/Screens/Drawer/new_article.dart';
// import 'package:first_app/Screens/Drawer/profile.dart';
// import 'package:first_app/Screens/Drawer/setting_page.dart';
// import 'package:first_app/Screens/others/new_article.dart';
import 'package:first_app/Screens/others/profile.dart';
import 'package:first_app/Screens/others/setting_page.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

ConstantColors constantColors = ConstantColors();
String selectDrawer = 'home';
SharedPreferences? prefs;

String? name;
retrieveUsernameValue() async {
  prefs = await SharedPreferences.getInstance();
  name = prefs!.getString("username");
  print('user name $name');
}

String? token;

retrieveStringValue() async {
  prefs = await SharedPreferences.getInstance();

  token = prefs!.getString("token");

  print('token value $token');
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: constantColors.whiteColor,
      child: ListView(
        padding: EdgeInsets.all(0),

        // padding: EdgeInsets.symmetric(vertical: 30),
        children: [
          //header
          SizedBox(
            height: 90,
            child: DrawerHeader(
                // padding: EdgeInsets.all(0),
                child: Container(
                    child: Text(
              'conduit',
              style: TextStyle(
                  color: constantColors.greenColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ))),
          ),
          //home
          Container(
            decoration: BoxDecoration(
                color: selectDrawer == 'home'
                    ? constantColors.greenColor
                    : constantColors.whiteColor,
                border: Border.all(
                  color: selectDrawer == 'home'
                      ? constantColors.greenColor
                      : constantColors.whiteColor,
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: selectDrawer == 'home'
                    ? constantColors.whiteColor
                    : Colors.grey.shade400,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                    color: selectDrawer == 'home'
                        ? constantColors.whiteColor
                        : Colors.grey.shade400,
                    fontSize: 17),
              ),
              onTap: () {
                setState(() {
                  selectDrawer = 'home';
                });
                retrieveStringValue();
                retrieveUsernameValue();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(token, name)));
              },
            ),
          ),
          //article
          Container(
            decoration: BoxDecoration(
                color: selectDrawer == 'article'
                    ? constantColors.greenColor
                    : constantColors.whiteColor,
                border: Border.all(
                  color: selectDrawer == 'article'
                      ? constantColors.greenColor
                      : constantColors.whiteColor,
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: ListTile(
              leading: Icon(
                Icons.edit_note_sharp,
                color: selectDrawer == 'article'
                    ? constantColors.whiteColor
                    : Colors.grey.shade400,
                size: 30,
              ),
              title: Text(
                'New Article',
                style: TextStyle(
                    color: selectDrawer == 'article'
                        ? constantColors.whiteColor
                        : Colors.grey.shade400,
                    fontSize: 17),
              ),
              onTap: () {
                setState(() {
                  selectDrawer = 'article';
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewArticlePage()));
              },
            ),
          ),
          //setting
          Container(
            decoration: BoxDecoration(
                color: selectDrawer == 'setting'
                    ? constantColors.greenColor
                    : constantColors.whiteColor,
                border: Border.all(
                  color: selectDrawer == 'setting'
                      ? constantColors.greenColor
                      : constantColors.whiteColor,
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: selectDrawer == 'setting'
                    ? constantColors.whiteColor
                    : Colors.grey.shade400,
              ),
              title: Text(
                'Setting',
                style: TextStyle(
                    color: selectDrawer == 'setting'
                        ? constantColors.whiteColor
                        : Colors.grey.shade400,
                    fontSize: 17),
              ),
              onTap: () {
                setState(() {
                  selectDrawer = 'setting';
                });

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
            ),
          ),
          //profile
          Container(
            decoration: BoxDecoration(
                color: selectDrawer == 'profile'
                    ? constantColors.greenColor
                    : constantColors.whiteColor,
                border: Border.all(
                  color: selectDrawer == 'profile'
                      ? constantColors.greenColor
                      : constantColors.whiteColor,
                ),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: ListTile(
              leading: Icon(
                Icons.face,
                color: selectDrawer == 'profile'
                    ? constantColors.whiteColor
                    : Colors.grey.shade400,
                size: 30,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: selectDrawer == 'profile'
                        ? constantColors.whiteColor
                        : Colors.grey.shade400,
                    fontSize: 17),
              ),
              onTap: () async {
                setState(() {
                  selectDrawer = 'profile';
                });
                retrieveUsernameValue();

                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage(name)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
