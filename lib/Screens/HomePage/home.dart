import 'dart:convert';
import 'dart:io';

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
import 'package:first_app/databse/article_dao.dart';
import 'package:first_app/databse/article_database.dart';
import 'package:first_app/databse/article_table.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  String? token, name;
  HomeScreen(this.token, this.name);

  @override
  State<HomeScreen> createState() => _HomeScreenState(this.token, this.name);
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String? token, name;
  _HomeScreenState(this.token, this.name);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? thumbnailUrl;

  ConstantColors constantColors = ConstantColors();
  TabController? _tabController;
  VideoPlayerController? _videoController;
  bool ActiveConnection = false;
  String T = "";
  final Uri _url = Uri.parse(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  void initState() {
    CheckUserConnection();
    _tabController = new TabController(length: 2, vsync: this);
    // generateThumbnails();
    _videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    super.initState();
  }

  String selected = "Global Feed";

  int? len = 0;
  final check = List.generate(10, (index) => index * 2);
  final tagName = ['implementations', 'introduction', 'codebaseShow'];
  // ArticleDao? articleDao;

  // ignore: prefer_typing_uninitialized_variables
  var result;
  addInfoToFloor() async {
    final database =
        await $FloorArticleDatabase.databaseBuilder('article.db').build();
    final articleDuo = database.articleDao;

    await articleDuo.insertArticle(
      ArticleFloor("article.slug", "article.title", "article.description",
          "article.body", true, 1),
    );
    setState(() {
      // ignore: await_only_futures
      result = articleDuo.getAllFloorArticle();
    });
  }

  // getInfoToFloor() async {
  //   final database =
  //       await $FloorArticleDatabase.databaseBuilder('article.db').build();
  //   final articleDuo = database.articleDao;

  //   final result = await articleDuo.getAllFloorArticle();
  //   return Container(
  //     child: Text(result.toString()),
  //   );
  // }

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
          future: API_Manager().getAllArtciles(token!),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return GridView.builder(
                itemCount: snapshot.data!.articles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 4),
                itemBuilder: (BuildContext context, index) {
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
                                    setState(() {
                                      if (article.favorited == false) {
                                        HomePageHelper().doLikedArticle(
                                            token!,
                                            article.author.username,
                                            article.slug,
                                            context);
                                      }
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      if (article.favorited == true) {
                                        HomePageHelper().doDissLikedArticle(
                                            token!,
                                            article.author.username,
                                            article.slug,
                                            context);
                                      }
                                    });
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
                                    setState(() {
                                      if (name == article.author.username) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProfilePage(
                                                  authorName, token)),
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
                                    });
                                  },
                                  child: Text(
                                    authorName,
                                    style: TextStyle(
                                        color: constantColors.greenColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.033),
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
                                        article.body,
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
    return FutureBuilder<AllArticlle>(
      future: API_Manager().getAllArtciles(token!),
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
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15, right: 15),
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
                                  setState(() {
                                    if (article.favorited == false) {
                                      HomePageHelper().doLikedArticle(
                                          token!,
                                          article.author.username,
                                          article.slug,
                                          context);
                                    }
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    if (article.favorited == true) {
                                      HomePageHelper().doDissLikedArticle(
                                          token!,
                                          article.author.username,
                                          article.slug,
                                          context);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: article.favorited == true
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
                                            color: article.favorited == true
                                                ? constantColors.whiteColor
                                                : constantColors.greenColor,
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
                              padding: EdgeInsets.symmetric(horizontal: 20),
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
                                    article.body,
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
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(3),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
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
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Container(
                                                    width: 130,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors
                                                              .grey.shade400,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                        child: Text(
                                                      tag[index],
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade400,
                                                          fontSize: 13),
                                                    ))),
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }

  Widget badegWidget() {
    return Container(
      height: 30,
      width: 35,
      child: FutureBuilder<GetLikedArticlle>(
        future: API_Manager().getLikedArticles(token!, name!),
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

  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          print("_________Data on $ActiveConnection");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        print("____________Data off $ActiveConnection");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<GetLikedArticlle>? _articleModel;

    return Scaffold(
      key: _scaffoldKey,
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
                  addInfoToFloor();
                },
                child: ActiveConnection
                    ? Icon(
                        Icons.refresh,
                        size: 30,
                      )
                    : Container(),
              ),
            ),
            // ChangeThemeButtonWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LikedArticle('$token', '$name')));
                    });
                  },
                  child: ActiveConnection
                      ? badegWidget()
                      : buildCustomeBadge(0,
                          child: Icon(
                            Icons.favorite,
                            color: constantColors.whiteColor,
                            size: 30,
                          ))),
            ),
            // ChangeThemeButtonWidget(),
          ),
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
          // ActiveConnection ? addInfoToFloor() : Container(),

          ActiveConnection
              ? LimitedBox(
                  maxHeight: MediaQuery.of(context).size.height * 1.01,
                  maxWidth: MediaQuery.of(context).size.width,
                  child:
                      TabBarView(controller: _tabController, children: <Widget>[
                    yourFeed(),
                    customerListView(),
                  ]))
              : Container(
                  // child: Text(result),
                  ),

          // video
          _videoController != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                  child: GestureDetector(
                    onTap: () {
                      _launchUrl();
                    },
                    onLongPress: () {
                      setState(() {
                        _videoController!.value.isPlaying
                            ? _videoController!.pause()
                            : _videoController!.play();
                      });
                    },
                    child: Center(
                      child: _videoController!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            )
                          : Container(),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),

          Padding(
            padding:
                const EdgeInsets.only(top: 0.0, right: 20, left: 20, bottom: 0),
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
          )
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
