import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_app/Screens/Drawer/profile.dart';
import 'package:first_app/Screens/Drawer/new_article.dart';
import 'package:first_app/Screens/others/client_profile.dart';
import 'package:first_app/Screens/others/readmore_page.dart';
import 'package:first_app/Screens/others/tag_screen.dart';
// import 'package:first_app/Screens/others/readmore_page.dart'le.dart';?
// import 'package:first_app/Screens/others/readmore_page.dart';??
// import 'package:first_app/Screens/others/others/client_profile.dart';
// import 'package:first_app/Screens/client_profile.dart'';
// import 'package:first_app/Screens/others/tag_screen.dart'n.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Screens/Drawer/setting_page.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/main.dart';
import 'package:first_app/model/article_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
// import 'package:cached_network_image/cached_network_image.dart';

final List<String> imgList = [
  'assets/images/a.jpg',
  'assets/images/c2.jpg',
  'assets/images/c3.jpg',
  'assets/images/c4.jpg',
  'assets/images/c5.jpg'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ConstantColors constantColors = ConstantColors();

  Future<Welcome>? _articleModel;
  @override
  void initState() {
    _articleModel = API_Manager().getArtciles();
    _tabController = new TabController(length: 2, vsync: this);

    super.initState();
  }

  String selected = "Global Feed";

  String selectDrawer = 'home';

  final check = List.generate(10, (index) => index * 2);
  final tagName = [
    'welcome',
    'implementations',
    'introduction',
    'codebaseShow'
  ];

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  // int? selectedIndex;
  _setIndex(bool index) {
    setState(() {
      index = false;
    });
  }

  _unSet(bool index) {
    setState(() {
      index = false;
    });
  }

  bool _checkColor(bool index) {
    if (index == true) {
      return true;
    } else {
      return false;
    }
  }

  Widget yourFeed() {
    return Container(
      height: 20,
      padding: EdgeInsets.all(20),
      // margin: EdgeInsets.only(right: 10, top: 20),
      child: Text(
        'No articles are here... yet.',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget customerListView() {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15, right: 15),
                        child: Card(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              // CachedNetworkImage(),
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
                                                          article
                                                              .author.image)));
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                  .circular(
                                                                      30)),
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
            padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
            child: Container(
              padding: EdgeInsets.only(top: 5),
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
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              padding: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.15,
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
                                            '${tagName[index]}',
                                          )));
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

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: Text(
          'conduit',
          style: TextStyle(
              color: constantColors.whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        backgroundColor: constantColors.whiteColor,
        child: ListView(
          padding: EdgeInsets.all(0),

          // padding: EdgeInsets.symmetric(vertical: 30),
          children: [
            SizedBox(
              height: 90,
              child: DrawerHeader(
                  // padding: EdgeInsets.all(0),
                  child: Container(
                      child: Text(
                'conduit',
                style: TextStyle(
                    color: constantColors.greenColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ))),
            ),
            Container(
              decoration: BoxDecoration(
                  color: selectDrawer == 'home'
                      ? constantColors.greenColor
                      : constantColors.whiteColor,
                  border: Border.all(color: constantColors.greenColor),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectDrawer = 'home';
                  });
                },
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selectDrawer = 'New Article';
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.edit_note_sharp,
                  color: Colors.grey,
                  size: 30,
                ),
                title: Text(
                  'New Article',
                  style: TextStyle(
                      color: selectDrawer == 'New Article'
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewArticlePage()));
                },
              ),
            ),
            GestureDetector(
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Setting',
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingPage()));
                },
              ),
            ),
            GestureDetector(
              child: ListTile(
                leading: Icon(
                  Icons.face,
                  color: Colors.grey,
                  size: 30,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          //top container //carouseal

          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
          ),

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
          Container(
            height: MediaQuery.of(context).size.height * 1.5,
            width: MediaQuery.of(context).size.width,
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
