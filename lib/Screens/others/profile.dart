// import 'package:first_app/Screens/Drawer/setting_page.dart';
import 'dart:io';

import 'package:first_app/Screens/Drawer/drawer.dart';
import 'package:first_app/Screens/others/setting_page.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
// import 'package:first_app/Screens/Drawer/setting_page.dart'';
import 'package:first_app/constants/Constantcolors.dart';

import 'package:first_app/model/user_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  String? name;
  ProfilePage(this.name);
  @override
  State<ProfilePage> createState() => _ProfilePageState(this.name);
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  String? name;
  _ProfilePageState(this.name);

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
  File? image;
  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return null;
      // final imageTemporary = File(image.path);
      final imageParment = await saveImageParmently(image.path);

      setState(() {
        this.image = imageParment;
      });
    } on PlatformException catch (e) {
      print('platform exception in image picker $e');
    }
  }

  Future<File> saveImageParmently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  void initState() {
    super.initState();
    // _registerWelcome = API_Manager().getUserDetails();
    // _registerWelcome = API_Manager().getcurrentUser();
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
      drawer: DrawerWidget(),
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
                  color: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //image
                      Stack(
                        children: [
                          ClipOval(
                            child: image != null
                                ? Image.file(
                                    image!,
                                    height: 128,
                                    width: 128,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/NoProfile.png',
                                    height: 128,
                                    width: 128,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          //edit button
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Center(
                                            child: Text(
                                          'Select Image source',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                        actionsPadding: EdgeInsets.all(8),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          MaterialButton(
                                              color: constantColors.greenColor,
                                              child: Text(
                                                "Gallery",
                                                style: TextStyle(
                                                    color: constantColors
                                                        .whiteColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                pickImage(ImageSource.gallery);
                                                Navigator.pop(context);
                                              }),
                                          MaterialButton(
                                              color: constantColors.greenColor,
                                              child: Text(
                                                "Camera",
                                                style: TextStyle(
                                                    color: constantColors
                                                        .whiteColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                pickImage(ImageSource.camera);
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: buildEditIcon()),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //name
                      GestureDetector(
                        onTap: () {
                          retrieveUsernameValue();
                        },
                        child: Text(
                          // snapshot.data!.user.username,
                          '${name}',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              color: constantColors.greyColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      //seeting
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

Widget buildEditIcon() {
  return ClipOval(
    child: Container(
      padding: EdgeInsets.all(3),
      color: constantColors.whiteColor,
      child: ClipOval(
        child: Container(
          padding: EdgeInsets.all(8),
          color: constantColors.greenColor,
          child: Icon(
            Icons.edit,
            color: constantColors.whiteColor,
          ),
        ),
      ),
    ),
  );
}
