import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/Screens/Drawer/drawer.dart';
import 'package:first_app/Screens/HomePage/homepage_helper.dart';
import 'package:first_app/Screens/others/client_profile.dart';
import 'package:first_app/Screens/others/profile.dart';
import 'package:first_app/Screens/others/readmore_page.dart';
import 'package:first_app/Screens/others/tag_screen.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/article_model.dart';
import 'package:first_app/model/get_liked_modul.dart';
import 'package:first_app/model/liked_article_model.dart';
import 'package:first_app/model/user_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LikedArticle extends StatefulWidget {
  String? likedToken;
  String? LikedName;

  LikedArticle(this.likedToken, this.LikedName);

  @override
  State<LikedArticle> createState() =>
      _LikedArticleState(this.likedToken, this.LikedName);
}

class _LikedArticleState extends State<LikedArticle> {
  String? LikedName;
  String? likedToken;

  _LikedArticleState(this.likedToken, this.LikedName);

  ConstantColors constantColors = ConstantColors();
  Future<GetLikedArticlle>? _articleModel;
  SharedPreferences? prefs;

  int? len = 0;
  final check = List.generate(10, (index) => index * 2);
  final tagName = [
    'AllArticlle',
    'implementations',
    'introduction',
    'codebaseShow'
  ];

  @override
  void initState() {
    _articleModel = API_Manager().getLikedArticles(likedToken!, LikedName!);
    // _tabController = new TabController(length: 2, vsync: this);

    super.initState();
  }

  Widget customerListView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<GetLikedArticlle>(
            future: _articleModel,
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
                                              likedToken!,
                                              article.author.username,
                                              article.slug,
                                              context);
                                        }
                                      },
                                      onLongPress: () {
                                        if (article.favorited == true) {
                                          HomePageHelper().doDissLikedArticle(
                                              likedToken!,
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
                                        if (LikedName ==
                                            article.author.username) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfilePage(authorName,
                                                        likedToken)),
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
                                                              likedToken!,
                                                              LikedName!,
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
                                                                      likedToken!)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: Text(
          'Liked Articles',
          style: TextStyle(
              color: constantColors.whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              // color: constantColors.redColor,
              height: MediaQuery.of(context).size.height * 1.2,
              width: MediaQuery.of(context).size.width,
              child: customerListView(),
            ),
          ],
        ),
      ),
    );
  }
}
