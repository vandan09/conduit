import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Screens/Drawer/settingPage.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/main.dart';
import 'package:first_app/model/user_model.dart';
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

  Widget yourFeed() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'No articles are here... yet.',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  // FutureBuilder<Album> buildFutureBuilder() {
  //   return FutureBuilder<Album>(
  //       future: _futureAlbum,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return Text(snapshot.data!.name);
  //         } else {
  //           return Text('${snapshot.error}');
  //         }
  //       });
  // }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.greenColor),
        backgroundColor: constantColors.whiteColor,
        title: SizedBox(
          child: Text(
            'Profile',
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
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 30,
                // ),
                Icon(
                  Icons.face,
                  size: MediaQuery.of(context).size.height * 0.09,
                  color: Colors.grey.shade700,
                ),
                // SizedBox(
                //   height: 10,
                // ),

                Text(
                  'Vandan',
                  // '$buildFutureBuilder()',
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
                            new MaterialPageRoute(
                              builder: (context) => SettingPage(),
                            ));
                      },
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade500),
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
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
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
