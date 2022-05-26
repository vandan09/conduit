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

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

ConstantColors constantColors = ConstantColors();
String selectDrawer = 'home';

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: constantColors.whiteColor,
      child: ListView(
        padding: EdgeInsets.all(0),

        // padding: EdgeInsets.symmetric(vertical: 30),
        children: [
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
          Container(
            decoration: BoxDecoration(
                color: selectDrawer == 'home'
                    ? constantColors.greenColor
                    : constantColors.whiteColor,
                border: Border.all(color: constantColors.greenColor),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectDrawer = 'home';
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectDrawer = 'New Article';
              });
            },
            child: ListTile(
              leading: Icon(
                Icons.edit_note_sharp,
                color: Colors.grey,
                size: 30,
              ),
              title: Text(
                'New Article',
                style: TextStyle(
                    color: selectDrawer == 'New Article'
                        ? Colors.black
                        : Colors.grey,
                    fontSize: 17),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewArticlePage()));
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              title: const Text(
                'Setting',
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(
                Icons.face,
                color: Colors.grey,
                size: 30,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.grey, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
