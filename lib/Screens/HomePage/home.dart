import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:first_app/Screens/Drawer/drawer.dart';

import 'package:first_app/Screens/HomePage/homepage_helper.dart';
import 'package:first_app/Screens/others/client_profile.dart';
import 'package:first_app/Screens/others/liked_articles.dart';
import 'package:first_app/Screens/others/profile.dart';
import 'package:first_app/Screens/others/readmore_page.dart';
import 'package:first_app/Screens/others/tag_screen.dart';

import 'package:first_app/Widget/buttomAppBar.dart';

import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/all_article_model.dart';

import 'package:first_app/model/article_model.dart';
import 'package:first_app/model/delete_fav.dart';
import 'package:first_app/model/get_liked_modul.dart';
import 'package:first_app/model/liked_article_model.dart';
import 'package:first_app/model/new_article_model.dart';
import 'package:first_app/model/user_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  String? token, name;
  HomeScreen(this.token, this.name);

  String? newname;
  retrieveUsernameValue() async {
    prefs = await SharedPreferences.getInstance();
    newname = prefs!.getString("username");
    print('user name $newname');
  }

  String? newtoken;
  SharedPreferences? prefs;

  retrieveStringValue() async {
    prefs = await SharedPreferences.getInstance();

    newtoken = prefs!.getString("token");

    print('token value $newtoken');
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState(this.token, this.name);
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ConstantColors constantColors = ConstantColors();
  String? token, name;
  _HomeScreenState(this.token, this.name);

  Future<AllArticlle>? _articleModel;
  Future<GetLikedArticlle>? _AllarticleModel;

  @override
  void initState() {
    _articleModel = API_Manager().getAllArtciles(token!);
    _AllarticleModel = API_Manager().getLikedArticles(token!, name!);

    _tabController = new TabController(length: 2, vsync: this);

    super.initState();
  }

  String selected = "Global Feed";

  int? len = 0;
  final check = List.generate(10, (index) => index * 2);
  final tagName = [
    'AllArticlle',
    'implementations',
    'introduction',
    'codebaseShow'
  ];

  chechDesc(String desc) {
    if (desc.length > 20) {
      String s1 = desc.substring(0, 20);

      return Container(
        width: 250,
        child: Row(
          children: [
            Flexible(
              child: Text(
                '$s1...',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
          width: 250,
          child: Row(children: [
            Flexible(
              child: Text(
                desc,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]));
    }
  }

  Widget yourFeed() {
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: FutureBuilder<AllArticlle>(
          future: _articleModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return GridView.builder(
                itemCount: snapshot.data!.articles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 4),
                itemBuilder: (BuildContext context, int index) {
                  var article = snapshot.data!.articles[index];
                  String authorName = article.author.username;
                  List tag = article.tagList;
                  return Padding(
                    padding: const EdgeInsets.only(left: 2, top: 2),
                    child: Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                            color: constantColors.greenColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    // alignment: AlignmentDirectional.center,
                                    // alignment: Alignment.topRight,
                                    height: 20,
                                    width: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: article.favorited == true
                                              ? constantColors.whiteColor
                                              : constantColors.greenColor,
                                          size: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //author image
                                leading: CachedNetworkImage(
                                  width: 35,
                                  height: 40,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    // width: 15.0,
                                    // height: 30.0,
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
                                      strokeWidth: 1,
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
                                                ProfilePage(authorName, token)),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ClientProfilePapge(authorName,
                                                    article.author.image)),
                                      );
                                    }
                                  },
                                  child: Text(
                                    authorName,
                                    style: TextStyle(
                                        color: constantColors.greenColor,
                                        fontSize: 14),
                                  ),
                                ),
                                //date
                                subtitle: Text(
                                  '${article.createdAt.month}/${article.createdAt.day}/${article.createdAt.year}',
                                  style: TextStyle(
                                      color: constantColors.greyColor,
                                      fontSize: 10),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //title
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReadMorePage(
                                                          token!,
                                                          name!,
                                                          article.title,
                                                          article.slug)));
                                        },
                                        child: Text(
                                          article.title,
                                          style: TextStyle(
                                              color: constantColors.darkColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // descripton
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReadMorePage(
                                                        token!,
                                                        name!,
                                                        article.title,
                                                        article.slug)));
                                      },
                                      child: chechDesc(
                                        article.description,
                                      ),
                                    ),

                                    //articles tags

                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 100,
                                            // padding: EdgeInsets.all(3),
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: tag.length,
                                              itemBuilder: ((context, index) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TagScreen(
                                                                          '${tag[index]}',
                                                                          token!)));
                                                        },
                                                        child: Container(
                                                            // width: 90,
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
                                                                  fontSize: 10),
                                                            ))),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ])),
                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: CircularProgressIndicator(
                        color: constantColors.greenColor)),
              );
            }
          }),
    );
  }

  Widget customerListView() {
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
                                                        article.author.image)),
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
                                                              token!,
                                                              name!,
                                                              article.title,
                                                              article.slug)));
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
          //popular tags
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, right: 20, left: 20, bottom: 0),
            child: Container(
              padding: EdgeInsets.only(top: 20),
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
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 0),
            child: Container(
              padding: EdgeInsets.only(bottom: 30, left: 15, right: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              // padding: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.12,
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
                                          '${tagName[index]}', token!)));
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(tagName[index]),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
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
      ),
    );
  }

  Widget badegWidget() {
    return Container(
      height: 30,
      width: 35,
      child: FutureBuilder<GetLikedArticlle>(
        future: _AllarticleModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: ((context, index) {
                return buildCustomeBadge(
                  snapshot.data!.articles.length,
                  child: Icon(
                    Icons.favorite,
                    color: constantColors.whiteColor,
                    size: 30,
                  ),
                );
              }),
            );
          } else {
            return buildCustomeBadge(
              0,
              child: Icon(
                Icons.favorite,
                color: constantColors.whiteColor,
                size: 30,
              ),
            );
          }
        },
      ),
    );
  }

  TabController? _tabController;

  void getAllArticle(String email, String password) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: constantColors.transperant,
            actions: [
              Center(
                  child: CircularProgressIndicator(
                color: constantColors.greenColor,
              ))
            ],
          );
        });
    // retrieveStringValue();

    print('valid');

    try {
      http.Response response = await http.get(Uri.parse(Strings.article_url),

          // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json",
            'Authorization': "Token ${token}",
          });
      if (response.statusCode == 200) {
        RegisterWelcome.fromJson(jsonDecode(response.body));
        // retrieveStringValue();
      } else {
        String str1 = jsonDecode(response.body).toString();
        String str2 = str1.replaceAll(new RegExp(r"\p{P}", unicode: true), "");
        String error = str2.substring(7);

        Flushbar(
          title: 'Invalid form',
          message: '${error}',
          duration: Duration(seconds: 3),
        ).show(context);
      }
    } catch (e) {
      Navigator.pop(context);

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<GetLikedArticlle>? _articleModel;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: Text(
          'conduit',
          style: TextStyle(
              color: constantColors.whiteColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LikedArticle('$token', '$name')));
                },
                child: badegWidget(),
              ),
            ),
            // ChangeThemeButtonWidget(),
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
          // physics: ClampingScrollPhysics(),
          child: Column(
        children: [
          //top container //carouseal

          HomePageHelper().carouselWidget(context),
          TabBar(

              // overlayColor: Colors.orange,
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
          LimitedBox(
            maxHeight: MediaQuery.of(context).size.height * 1.2,
            maxWidth: MediaQuery.of(context).size.width,
            child: TabBarView(controller: _tabController, children: <Widget>[
              yourFeed(),
              customerListView(),
            ]),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}

Widget buildCustomeBadge(
  int i, {
  required Widget child,
}) {
  final text = i.toString();
  return Stack(
    children: [
      child,
      Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.redAccent,
            radius: 8,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ))
    ],
  );
}
