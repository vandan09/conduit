import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/Screens/HomePage/homepage_helper.dart';
import 'package:first_app/Screens/others/client_profile.dart';
import 'package:first_app/Screens/others/profile.dart';
import 'package:first_app/Screens/others/update_article.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/all_article_model.dart';
import 'package:first_app/model/comment_model.dart';
import 'package:first_app/model/get_comment_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class ReadMorePage extends StatefulWidget {
  final String token;
  final String authorname;
  final String title;
  final String slug;

  // const TagScreen(String s, {super.key});
  ReadMorePage(this.token, this.authorname, this.title, this.slug);

  @override
  State<ReadMorePage> createState() =>
      _ReadMorePageState(this.token, this.authorname, this.title, this.slug);
}

class _ReadMorePageState extends State<ReadMorePage> {
  bool? follow = false;

  final String token;
  final String authorname;
  final String title;
  final String slug;

  // const TagScreen(String s, {super.key});
  _ReadMorePageState(this.token, this.authorname, this.title, this.slug);
  ConstantColors constantColors = ConstantColors();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

  Future<AllArticlle>? _articleModel;
  Future<GetCommentModel>? _commentModel;

  Widget followButton(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: GestureDetector(
          onTap: () {
            setState(() {
              follow = !follow!;
            });
          },
          child: Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(follow == true ? null : Icons.add,
                    color: Colors.grey.shade500,
                    size: MediaQuery.of(context).size.width * 0.035),
                SizedBox(
                  width: (follow == true ? 0 : 10),
                ),
                Row(
                  children: [
                    Text(
                      follow == true ? "Unfollow" : "Follow",
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: MediaQuery.of(context).size.width * 0.035),
                    ),
                    Text(
                      ' $name',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: MediaQuery.of(context).size.width * 0.035),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget deleteButton(String slug, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            HomePageHelper().deleteArticle(token, slug, context, name);
          });
        },
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
              border:
                  Border.all(color: constantColors.redColor.withOpacity(0.8)),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                color: constantColors.redColor.withOpacity(0.8),
              ),
              Text(
                'Delete Article',
                style:
                    TextStyle(color: constantColors.redColor.withOpacity(0.8)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget updateArticle(String slug, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UpdateArticleScreen(authorname, slug, token)));
          });
        },
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              Text(
                'Update Article',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _articleModel = API_Manager().getAllArtciles(token);
    _commentModel = API_Manager().getComments(token, slug);

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
            'Article',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formkey,
        child: Column(
          children: [
            FutureBuilder<AllArticlle>(
                future: API_Manager().getAllArtciles(token),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.articles.length,
                      itemBuilder: ((context, index) {
                        var article = snapshot.data!.articles[index];
                        // String authorName = article.author.username;
                        // List tag = article.tagList;
                        if (title == article.title) {
                          return Column(
                            children: [
                              //title container
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                color: Color(0xff333333),
                                // child: Padding(
                                //   padding:
                                //       const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // title
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        article.title,
                                        style: TextStyle(
                                            color: constantColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025),
                                      ),
                                    ),

                                    //image name row
                                    ListTile(
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
                                      title: Text(
                                        article.author.username,
                                        style: TextStyle(
                                            color: constantColors.whiteColor),
                                      ),
                                      subtitle: Text(
                                        '${article.createdAt.month}/${article.createdAt.day}/${article.createdAt.year}',
                                        style: TextStyle(
                                            color: constantColors.greyColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.017),
                                      ),
                                    ),
                                    //follow box
                                    Container(),
                                    authorname == article.author.username
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                                deleteButton(
                                                    article.slug, authorname),
                                                updateArticle(
                                                    article.slug, authorname)
                                              ])
                                        : followButton(article.author.username),
                                  ],
                                ),
                              ),
                              // dec
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, right: 20, left: 20, bottom: 20),
                                child: Container(
                                  child: Text(
                                    article.body,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              // divider
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Divider(
                                  color: constantColors.greyColor,
                                ),
                              ),
                              // comment
                              // Padding(
                              //   padding: const EdgeInsets.all(20.0),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey.shade200,
                              //       border:
                              //           Border.all(color: Colors.grey.shade400),
                              //       borderRadius: BorderRadius.circular(5),
                              //     ),
                              //     height: 250,
                              //     child: Column(
                              //       children: [
                              //         Container(
                              //           // height: 10,
                              //           // width: 400?,
                              //           color: constantColors.whiteColor,
                              //           child: TextFormField(
                              //             validator: (value) => value!.isEmpty
                              //                 ? 'Required'
                              //                 : null,
                              //             onTap: FocusScope.of(context).unfocus,
                              //             keyboardType: TextInputType.multiline,
                              //             maxLines: null,
                              //             minLines: 5,
                              //             controller: commentController,
                              //             textInputAction: TextInputAction.next,
                              //             decoration: InputDecoration(
                              //                 border: OutlineInputBorder(
                              //                     borderSide: BorderSide.none),
                              //                 hintText: 'Write a comment'),
                              //           ),
                              //         ),
                              //         Expanded(
                              //           flex: 1,
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(17.0),
                              //             child: Container(
                              //               decoration: BoxDecoration(
                              //                 // border: Border.all(color: Colors.grey.shade300),
                              //                 color: constantColors.greenColor,
                              //                 borderRadius:
                              //                     BorderRadius.circular(5),
                              //               ),
                              //               width: 170,
                              //               child: GestureDetector(
                              //                   onTap: () {
                              //                     setState(() {
                              //                       HomePageHelper()
                              //                           .doPulishComment(
                              //                               _formkey,
                              //                               context,
                              //                               commentController
                              //                                   .text,
                              //                               article.slug,
                              //                               token,
                              //                               commentController,
                              //                               authorname);
                              //                     });
                              //                   },
                              //                   child: Center(
                              //                     child: Text(
                              //                       "Post Comment",
                              //                       style: TextStyle(
                              //                           color: Colors.white,
                              //                           fontWeight:
                              //                               FontWeight.bold),
                              //                     ),
                              //                   )),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // )

                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.all(value),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                        ),
                                        height: 150,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // child: Text(comment.body),
                                        child: TextFormField(
                                          validator: (value) => value!.isEmpty
                                              ? 'Required'
                                              : null,
                                          onTap: FocusScope.of(context).unfocus,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          minLines: 5,
                                          controller: commentController,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: 'Write a comment'),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: constantColors.whiteColor,
                                        ),
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 80, vertical: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    constantColors.greenColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    HomePageHelper()
                                                        .doPulishComment(
                                                            _formkey,
                                                            context,
                                                            commentController
                                                                .text,
                                                            article.slug,
                                                            token,
                                                            commentController,
                                                            authorname);
                                                  });
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "Post Comment",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container(
                            height: 0,
                            width: 0,
                          );
                        }
                      }),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: constantColors.greenColor,
                      ),
                    );
                  }
                }),
            //comment list
            FutureBuilder<GetCommentModel>(
                future: API_Manager().getComments(token, slug),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: snapshot.data!.comments.length,
                      itemBuilder: ((context, index) {
                        var comment = snapshot.data!.comments[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(comment.body),
                                ),
                                Container(
                                  // height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
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
                                      imageUrl: comment.author.image,
                                    ),
                                    title: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (authorname ==
                                              comment.author.username) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(
                                                          authorname, token)),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientProfilePapge(
                                                          authorname,
                                                          comment
                                                              .author.image)),
                                            );
                                          }
                                        });
                                      },
                                      child: Text(
                                        comment.author.username,
                                        style: TextStyle(
                                            color: constantColors.greenColor,
                                            fontSize: 16),
                                      ),
                                    ),
                                    //date
                                    subtitle: Text(
                                      '${comment.createdAt.month}/${comment.createdAt.day}/${comment.createdAt.year}',
                                      style: TextStyle(
                                          color: constantColors.greyColor,
                                          fontSize: 12),
                                    ),

                                    trailing: authorname ==
                                            comment.author.username
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                HomePageHelper().deleteComment(
                                                    token,
                                                    slug,
                                                    context,
                                                    authorname,
                                                    comment.id);
                                              });
                                            },
                                            child: Icon(Icons.delete))
                                        : Container(
                                            width: 0,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return Container(
                      height: 0,
                    );
                  }
                }),
          ],
        ),
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
