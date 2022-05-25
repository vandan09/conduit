import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/Screens/others/readmore_page.dart';
import 'package:first_app/Screens/others/tag_screen.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/model/article_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:readmore/readmore.dart';

class ClientProfilePapge extends StatefulWidget {
  final String author;
  final String imageUrl;

  // const TagScreen(String s, {super.key});
  ClientProfilePapge(this.author, this.imageUrl);

  @override
  State<ClientProfilePapge> createState() =>
      _ClientProfilePapgeState(this.author, this.imageUrl);
}

class _ClientProfilePapgeState extends State<ClientProfilePapge>
    with TickerProviderStateMixin {
  Future<Welcome>? _articleModel;
  bool? follow = false;

  @override
  void initState() {
    _articleModel = API_Manager().getArtciles();
    _tabController = new TabController(length: 2, vsync: this);

    super.initState();
  }

  final String author;
  final String imageUrl;

  // const TagScreen(String s, {super.key});
  _ClientProfilePapgeState(this.author, this.imageUrl);
  ConstantColors constantColors = ConstantColors();
  String selected = "Favorited Article";
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

  Widget yourFeed() {
    return Container(
      margin: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.02, top: 20),
      child: Text(
        'No articles are here... yet.',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget myArticle() {
    return SingleChildScrollView(
        child: Column(children: [
      FutureBuilder<Welcome>(
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

                  if (authorName == author) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                      child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            ListTile(
                              // like button
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    article.favorited = true;
                                  });
                                },
                                onLongPress: () {
                                  setState(() {
                                    article.favorited = false;
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
                              // author image
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                                        article.title,
                                                        authorName,
                                                        article.description,
                                                        article.createdAt,
                                                        article.author.image)));
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
                                                            )));
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
                      // color: constantColors.blueColor,
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
    ]));
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: SizedBox(
          child: Text(
            author,
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
                CachedNetworkImage(
                  width: 50,
                  height: 50,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: constantColors.greenColor,
                      value: progress.progress,
                    ),
                  ),
                  imageUrl: imageUrl,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                //follow unfollow
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          follow = !follow!;
                        });
                      },
                      child: Container(
                        width: 170,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              follow == true ? null : Icons.add,
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(
                              width: (follow == true ? 0 : 10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  follow == true ? "Unfollow" : "Follow",
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                                Text(
                                  ' $author',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
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
                    'My Artcle',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Favorited Article',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(controller: _tabController, children: <Widget>[
              myArticle(),
              yourFeed(),
            ]),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
