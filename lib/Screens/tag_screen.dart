import 'package:first_app/Screens/ReadMorePage.dart';
import 'package:first_app/Screens/client_profile.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Widget/buttomAppBar.dart';

class TagScreen extends StatefulWidget {
  final String tagName;
  // const TagScreen(String s, {super.key});
  TagScreen(this.tagName);

  @override
  State<TagScreen> createState() => _TagScreenState(this.tagName);
}

class _TagScreenState extends State<TagScreen> {
  final String tagName;
  // const TagScreen(String s, {super.key});
  _TagScreenState(this.tagName);
  ConstantColors constantColors = ConstantColors();
  final check = List.generate(10, (index) => index * 2);

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

  Widget listView() {
    return Column(children: [
      ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
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
                              border:
                                  Border.all(color: constantColors.greenColor),
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
                                color: constantColors.greyColor, fontSize: 14),
                          )),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReadMorePage()));
                              },
                              child: Text(
                                'Read more...',
                                style: TextStyle(
                                    color: Colors.grey.shade400, fontSize: 13),
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.greenColor),
        backgroundColor: constantColors.whiteColor,
        title: SizedBox(
          child: Text(
            '#$tagName',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.greenColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            listView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
