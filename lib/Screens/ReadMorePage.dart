import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReadMorePage extends StatefulWidget {
  const ReadMorePage({super.key});

  @override
  State<ReadMorePage> createState() => _ReadMorePageState();
}

class _ReadMorePageState extends State<ReadMorePage> {
  ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.greenColor),
        backgroundColor: constantColors.whiteColor,
        title: SizedBox(
          child: Text(
            'Article',
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
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff333333),
            // child: Padding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Create a new implementation',
                    style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.03),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/demo-avatar.png'),
                  ),
                  title: Text(
                    'Gerome',
                    style: TextStyle(color: constantColors.whiteColor),
                  ),
                  subtitle: Text(
                    'November 24,2001',
                    style: TextStyle(
                        color: constantColors.greyColor,
                        fontSize: MediaQuery.of(context).size.height * 0.017),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: MediaQuery.of(context).size.height * 0.065,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white38),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white38,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Follow Gerome",
                              style: TextStyle(color: Colors.white38),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, right: 20, left: 20, bottom: 20),
            child: Container(
              child: Text(
                'Share your knowledge and enpower the community by creating a new implementation',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: constantColors.greyColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(5),
              ),
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: constantColors.whiteColor,
                      child: TextField(
                        onTap: FocusScope.of(context).unfocus,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Write a comment'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Container(
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey.shade300),
                          color: constantColors.greenColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: 170,
                        child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                "Post Comment",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
