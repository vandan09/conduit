import 'package:first_app/Screens/Drawer/profile.dart';
import 'package:first_app/Screens/Drawer/new_article.dart';
import 'package:first_app/Screens/ReadMorePage.dart';
import 'package:first_app/Screens/client_profile.dart';
// import 'package:first_app/Screens/client_profile.dart'';
import 'package:first_app/Screens/tag_screen.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Screens/Drawer/setting_page.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ConstantColors constantColors = ConstantColors();
  String selected = "Global Feed";

  String selectDrawer = 'home';

  final check = List.generate(10, (index) => index * 2);
  final tagName = ['welcome', 'implementation', 'introduction', 'codeBaseShow'];

  int? selectedIndex;
  _setIndex(int index) {
    setState(() {
      check[index] = 1;
    });
  }

  _unSet(int index) {
    setState(() {
      check[index] = 0;
    });
  }

  bool _checkColor(int index) {
    if (check[index] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Widget yourFeed() {
    return Container(
      padding: EdgeInsets.all(20),
      // margin: EdgeInsets.only(right: 10, top: 20),
      child: Text(
        'No articles are here... yet.',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget customerListView() {
    return Column(
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                child: Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      ListTile(
                        trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              _setIndex(index);
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              _unSet(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: _checkColor(index)
                                    ? constantColors.greenColor
                                    : constantColors.whiteColor,
                                // _checkColor(index);
                                border: Border.all(
                                    color: constantColors.greenColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            // alignment: AlignmentDirectional.center,
                            // alignment: Alignment.topRight,
                            height: 35,
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: _checkColor(index)
                                      ? constantColors.whiteColor
                                      : constantColors.greenColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '20',
                                  style: TextStyle(
                                      color: _checkColor(index)
                                          ? constantColors.whiteColor
                                          : constantColors.greenColor,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/demo-avatar.png'),
                        ),
                        title: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientProfilePapge()),
                            );
                          },
                          child: Text(
                            'Gerome',
                            style: TextStyle(color: constantColors.greenColor),
                          ),
                        ),
                        subtitle: Text(
                          'November 24,2001',
                          style: TextStyle(
                              color: constantColors.greyColor, fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                child: Text(
                              'Create new implementation',
                              style: TextStyle(
                                  color: constantColors.darkColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                            GestureDetector(
                                child: Text(
                              'Join the community by creating a new implementation',
                              style: TextStyle(
                                  color: constantColors.greyColor,
                                  fontSize: 14),
                            )),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReadMorePage()));
                                },
                                child: Text(
                                  'Read more...',
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                      ),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    'implementations',
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 13),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ])),
              );
            })),
        // SizedBox(
        //   height: 100,
        //   width: 100,
        //   child: ListView.builder(
        //     itemBuilder: (context, index) {
        //       return Row();
        //       // return Container(
        //       // width: MediaQuery.of(context).size.width,
        //       // child: Row(
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
          child: Container(
            padding: EdgeInsets.only(top: 5),
            alignment: Alignment.center,
            child: Text(
              "Popular Tags",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            // padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: tagName.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      runSpacing: 10,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TagScreen(
                                          '${tagName[index]}',
                                        )));
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(tagName[index]),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

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
        title: Text(
          'conduit',
          style: TextStyle(
              color: constantColors.greenColor, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
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
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(color: Colors.black, fontSize: 17),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewArticlePage()));
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
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          //top container
          Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'conduit',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: constantColors.whiteColor),
              ),
              Text(
                'A place to share your knowledge.',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: constantColors.whiteColor),
              ),
            ]),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: constantColors.greenColor,
          ),

          SizedBox(
            height: 20,
          ),
          //middle

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
              customerListView(),
            ]),
          ),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           yourFeed();
          //           setState(() {
          //             selected = 'Your Feed';
          //           });
          //         },
          //         child: Text(
          //           'Your Feed',
          //           style: TextStyle(
          //               color: selected == 'Global Feed'
          //                   ? constantColors.greyColor
          //                   : constantColors.greenColor,
          //               fontSize: 16),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             selected = 'Global Feed';
          //           });
          //         },
          //         child: Text(
          //           'Global Feed',
          //           style: TextStyle(
          //               color: selected == 'Global Feed'
          //                   ? constantColors.greenColor
          //                   : constantColors.greyColor,
          //               fontSize: 16),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Divider(
          //     color: constantColors.darkColor,
          //     height: 1,
          //   ),
          // ),

          // Container(
          //   child: selected == 'Your Feed' ? yourFeed() : listView(),
          // ),
        ],
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
