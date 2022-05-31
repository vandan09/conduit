// import 'package:first_app/Screens/Drawer/setting_page.dart';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/Screens/Drawer/drawer.dart';
import 'package:first_app/Screens/HomePage/homepage_helper.dart';
import 'package:first_app/Screens/others/client_profile.dart';
import 'package:first_app/Screens/others/readmore_page.dart';
import 'package:first_app/Screens/others/setting_page.dart';
import 'package:first_app/Screens/others/tag_screen.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
// import 'package:first_app/Screens/Drawer/setting_page.dart'';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/model/all_article_model.dart';
import 'package:first_app/model/get_liked_modul.dart';

import 'package:first_app/model/user_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:readmore/readmore.dart';

class ProfilePage extends StatefulWidget {
  String? name;
  String? token;

  ProfilePage(this.name, this.token);
  @override
  State<ProfilePage> createState() => _ProfilePageState(this.name, this.token);
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  String? name;
  String? token;

  _ProfilePageState(this.name, this.token);
  final tagName = [
    'AllArticlle',
    'implementations',
    'introduction',
    'codebaseShow'
  ];

  ConstantColors constantColors = ConstantColors();
  // Future<GetLikedArticlle>? _AllarticleModel;
  Future<AllArticlle>? _articleModel;
  Future<GetLikedArticlle>? _articlelikedeModel;

  // Future<Album>? _futureAlbum;
  Future<RegisterWelcome>? _registerWelcome;
  Widget MyArticles(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<AllArticlle>(
            future: _articleModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles.length,
                    itemBuilder: ((context, index) {
                      var article = snapshot.data!.articles[index];
                      String authorName = article.author.username;
                      List tag = article.tagList;
                      if (authorName == name) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 15, right: 15),
                          child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // CachedNetworkImage(),
                                    ListTile(
                                      // like button
                                      trailing: GestureDetector(
                                        onTap: () {
                                          if (article.favorited == false) {
                                            HomePageHelper().doLikedArticle(
                                                token!,
                                                article.author.username,
                                                article.slug,
                                                context);
                                          }
                                        },
                                        onLongPress: () {
                                          if (article.favorited == true) {
                                            HomePageHelper().doDissLikedArticle(
                                                token!,
                                                article.author.username,
                                                article.slug,
                                                context);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: article.favorited == true
                                                  ? constantColors.greenColor
                                                  : constantColors.whiteColor,
                                              // _checkColor(index);
                                              border: Border.all(
                                                  color: constantColors
                                                      .greenColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          // alignment: AlignmentDirectional.center,
                                          // alignment: Alignment.topRight,
                                          height: 35,
                                          width: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: article.favorited == true
                                                    ? constantColors.whiteColor
                                                    : constantColors.greenColor,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                '${article.favoritesCount}',
                                                style: TextStyle(
                                                    color: article.favorited ==
                                                            true
                                                        ? constantColors
                                                            .whiteColor
                                                        : constantColors
                                                            .greenColor,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      //author image
                                      leading: CachedNetworkImage(
                                        width: 50,
                                        height: 50,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 5,
                                            color: constantColors.greenColor,
                                            value: progress.progress,
                                          ),
                                        ),
                                        imageUrl: article.author.image,
                                      ),

                                      //author name

                                      title: GestureDetector(
                                        onTap: () {
                                          if (name == article.author.username) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(
                                                          authorName, token)),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientProfilePapge(
                                                          authorName,
                                                          article
                                                              .author.image)),
                                            );
                                          }
                                        },
                                        child: Text(
                                          authorName,
                                          style: TextStyle(
                                              color: constantColors.greenColor),
                                        ),
                                      ),
                                      //date
                                      subtitle: Text(
                                        '${article.createdAt.month}/${article.createdAt.day}/${article.createdAt.year}',
                                        style: TextStyle(
                                            color: constantColors.greyColor,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //title
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ReadMorePage(
                                                                article.title,
                                                                authorName,
                                                                article
                                                                    .description,
                                                                article
                                                                    .createdAt,
                                                                article.author
                                                                    .image)));
                                              },
                                              child: Text(
                                                article.title,
                                                style: TextStyle(
                                                    color: constantColors
                                                        .darkColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                          //descripton
                                          GestureDetector(
                                              child: ReadMoreText(
                                            trimLines: 2,
                                            colorClickableText:
                                                constantColors.greenColor,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'Read more',
                                            trimExpandedText: ' Show less',
                                            article.description,
                                            style: TextStyle(
                                                color: constantColors.greyColor,
                                                fontSize: 14),
                                          )),

                                          SizedBox(
                                            height: 10,
                                          ),
                                          //articles tags

                                          Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.all(3),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: tag.length,
                                              itemBuilder: ((context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TagScreen(
                                                                        '${tag[index]}',
                                                                        token!)));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: Container(
                                                            width: 130,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade400,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                            child: Center(
                                                                child: Text(
                                                              tag[index],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  fontSize: 13),
                                                            ))),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
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
                      } else {
                        return Container(
                          height: 0,
                          width: 0,
                        );
                      }
                    }));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: CircularProgressIndicator(
                          color: constantColors.greenColor)),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget FavArticles() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<GetLikedArticlle>(
            future: _articlelikedeModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articlesCount,
                    itemBuilder: ((context, index) {
                      var article = snapshot.data!.articles[index];
                      String authorName = article.author.username;
                      List tag = article.tagList;
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15, right: 15),
                        child: Card(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CachedNetworkImage(),
                                  ListTile(
                                    // like button
                                    trailing: GestureDetector(
                                      onTap: () {
                                        if (article.favorited == false) {
                                          HomePageHelper().doLikedArticle(
                                              token!,
                                              article.author.username,
                                              article.slug,
                                              context);
                                        }
                                      },
                                      onLongPress: () {
                                        if (article.favorited == true) {
                                          HomePageHelper().doDissLikedArticle(
                                              token!,
                                              article.author.username,
                                              article.slug,
                                              context);
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: article.favorited == true
                                                ? constantColors.greenColor
                                                : constantColors.whiteColor,
                                            // _checkColor(index);
                                            border: Border.all(
                                                color:
                                                    constantColors.greenColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        // alignment: AlignmentDirectional.center,
                                        // alignment: Alignment.topRight,
                                        height: 35,
                                        width: 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: article.favorited == true
                                                  ? constantColors.whiteColor
                                                  : constantColors.greenColor,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              '${article.favoritesCount}',
                                              style: TextStyle(
                                                  color:
                                                      article.favorited == true
                                                          ? constantColors
                                                              .whiteColor
                                                          : constantColors
                                                              .greenColor,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    //author image
                                    leading: CachedNetworkImage(
                                      width: 50,
                                      height: 50,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 80.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 5,
                                          color: constantColors.greenColor,
                                          value: progress.progress,
                                        ),
                                      ),
                                      imageUrl: article.author.image,
                                    ),

                                    //author name

                                    title: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ClientProfilePapge(authorName,
                                                      article.author.image)),
                                        );
                                      },
                                      child: Text(
                                        authorName,
                                        style: TextStyle(
                                            color: constantColors.greenColor),
                                      ),
                                    ),
                                    //date
                                    subtitle: Text(
                                      '${article.createdAt.month}/${article.createdAt.day}/${article.createdAt.year}',
                                      style: TextStyle(
                                          color: constantColors.greyColor,
                                          fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //title
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReadMorePage(
                                                              article.title,
                                                              authorName,
                                                              article
                                                                  .description,
                                                              article.createdAt,
                                                              article.author
                                                                  .image)));
                                            },
                                            child: Text(
                                              article.title,
                                              style: TextStyle(
                                                  color:
                                                      constantColors.darkColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            )),
                                        //descripton
                                        GestureDetector(
                                            child: ReadMoreText(
                                          trimLines: 2,
                                          colorClickableText:
                                              constantColors.greenColor,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Read more',
                                          trimExpandedText: ' Show less',
                                          article.description,
                                          style: TextStyle(
                                              color: constantColors.greyColor,
                                              fontSize: 14),
                                        )),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        //articles tags

                                        Container(
                                          height: 40,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(3),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: tag.length,
                                            itemBuilder: ((context, index) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TagScreen(
                                                                      '${tag[index]}',
                                                                      token!)));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: Container(
                                                          width: 130,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30)),
                                                          child: Center(
                                                              child: Text(
                                                            tag[index],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                fontSize: 13),
                                                          ))),
                                                    ),
                                                  )
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
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
                    }));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: CircularProgressIndicator(
                          color: constantColors.greenColor)),
                );
              }
            },
          ),
        ],
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

    _articleModel = API_Manager().getAllArtciles(token!);
    _articlelikedeModel = API_Manager().getLikedArticles(token!, name!);

    _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
                          // retrieveUsernameValue();
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
                    'My Articles',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Favorited Articles',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(controller: _tabController, children: <Widget>[
              MyArticles(context),
              FavArticles(),
            ]),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
