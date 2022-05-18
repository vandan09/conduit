import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewArticlePage extends StatefulWidget {
  const NewArticlePage({super.key});

  @override
  State<NewArticlePage> createState() => _NewArticlePageState();
}

class _NewArticlePageState extends State<NewArticlePage> {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.greenColor),
        backgroundColor: constantColors.whiteColor,
        title: SizedBox(
          child: Text(
            'New Article',
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
              margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: TextField(
                onTap: FocusScope.of(context).unfocus,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Article Title'),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                onTap: FocusScope.of(context).unfocus,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "What's this article about?"),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                onTap: FocusScope.of(context).unfocus,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 5,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Write your article '),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                onTap: FocusScope.of(context).unfocus,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter tags'),
              )),
          Padding(
            padding: const EdgeInsets.all(40),
            child: GestureDetector(
                onTap: () {},
                child: CustomRaisedButton(
                  buttonText: 'Publish Article',
                )),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
