// import 'package:first_app/Screens/Drawer/setting_page.dart';
import 'package:first_app/Screens/others/setting_page.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
// import 'package:first_app/Screens/Drawer/setting_page.dart'';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/main.dart';
import 'package:first_app/model/user_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  ConstantColors constantColors = ConstantColors();
  // Future<Album>? _futureAlbum;
  Future<RegisterWelcome>? _registerWelcome;

  Widget yourFeed() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'No articles are here... yet.',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // _registerWelcome = API_Manager().getUserDetails();

    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: SizedBox(
          child: Text(
            'Profile',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          FutureBuilder<RegisterWelcome>(
            future: _registerWelcome,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.face,
                        size: MediaQuery.of(context).size.height * 0.09,
                        color: Colors.grey.shade700,
                      ),
                      Text(
                        // snapshot.data!.user.username,
                        "Vandan",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            color: constantColors.greyColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SettingPage(),
                                  ));
                            },
                            child: Container(
                              width: 200,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.settings,
                                    color: Colors.grey.shade500,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Edit Profile Settings',
                                    style:
                                        TextStyle(color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          TabBar(
              labelColor: constantColors.greenColor,
              unselectedLabelColor: constantColors.greyColor,
              indicatorColor: Colors.green,
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  child: Text(
                    'Your Feed',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Global Feed',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
          Container(
            height: MediaQuery.of(context).size.height * 1.2,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(controller: _tabController, children: <Widget>[
              yourFeed(),
              yourFeed(),
            ]),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
