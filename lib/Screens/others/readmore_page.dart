import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReadMorePage extends StatefulWidget {
  final String title;
  final String author;
  final String desc;
  final DateTime date;
  final String imageUrl;

  // const TagScreen(String s, {super.key});
  ReadMorePage(this.title, this.author, this.desc, this.date, this.imageUrl);

  @override
  State<ReadMorePage> createState() => _ReadMorePageState(
      this.title, this.author, this.desc, this.date, this.imageUrl);
}

class _ReadMorePageState extends State<ReadMorePage> {
  bool? follow = false;

  final String title;
  final String author;
  final String desc;
  final DateTime date;
  final String imageUrl;
  // const TagScreen(String s, {super.key});
  _ReadMorePageState(
      this.title, this.author, this.desc, this.date, this.imageUrl);
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
                    title,
                    style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.025),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  leading: CachedNetworkImage(
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
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: constantColors.greenColor,
                        value: progress.progress,
                      ),
                    ),
                    imageUrl: imageUrl,
                  ),
                  title: Text(
                    author,
                    style: TextStyle(color: constantColors.whiteColor),
                  ),
                  subtitle: Text(
                    '${date.month}/${date.day}/${date.year}',
                    style: TextStyle(
                        color: constantColors.greyColor,
                        fontSize: MediaQuery.of(context).size.height * 0.017),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                          children: [
                            Icon(
                              follow == true ? null : Icons.add,
                              color: Colors.grey.shade500,
                            ),
                            SizedBox(
                              width: (follow == true ? 0 : 10),
                            ),
                            Row(
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
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, right: 20, left: 20, bottom: 20),
            child: Container(
              child: Text(
                desc,
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
