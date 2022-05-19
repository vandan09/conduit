import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClientProfilePapge extends StatefulWidget {
  const ClientProfilePapge({super.key});

  @override
  State<ClientProfilePapge> createState() => _ClientProfilePapgeState();
}

class _ClientProfilePapgeState extends State<ClientProfilePapge>
    with TickerProviderStateMixin {
  ConstantColors constantColors = ConstantColors();
  String selected = "Favorited Article";

  Widget yourFeed() {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.46, top: 20),
      child: Text(
        'No articles are here... yet.',
        style: TextStyle(fontSize: 15),
      ),
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
        title: SizedBox(
          child: Text(
            'Gerome',
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
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/demo-avatar.png'),
                  radius: 35,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 170,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Follow Gerome',
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
