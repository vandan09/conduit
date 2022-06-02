import 'package:first_app/Screens/HomePage/homepage_helper.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateArticleScreen extends StatefulWidget {
  final String authorname;
  final String slug;
  final String token;

  UpdateArticleScreen(this.authorname, this.slug, this.token);

  @override
  State<UpdateArticleScreen> createState() =>
      _UpdateArticleScreenState(this.authorname, this.slug, this.token);
}

class _UpdateArticleScreenState extends State<UpdateArticleScreen> {
  final String authorname;
  final String slug;
  final String token;

  _UpdateArticleScreenState(this.authorname, this.slug, this.token);

  ConstantColors constantColors = ConstantColors();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? CustomeValidaor(String? value) {
    String? _msg;

    if (value!.isEmpty) {
      _msg = "Required";
    }
    return _msg;
  }

  // String? token;
  // SharedPreferences? prefs;

  // retrieveStringValue() async {
  //   prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = prefs!.getString("token");
  //   });
  //   print('token value $token');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: SizedBox(
          child: Text(
            'New Article',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // drawer: DrawerWidget(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    // onTap: FocusScope.of(context).unfocus,
                    keyboardType: TextInputType.multiline,
                    // controller: _controller,
                    controller: descController,

                    maxLines: null,
                    minLines: 5,
                    validator: CustomeValidaor,

                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write your article '),
                  )),
              Padding(
                padding: const EdgeInsets.all(40),
                child: GestureDetector(
                    onTap: () {
                      HomePageHelper().updateArticle(
                        slug,
                        authorname,
                        token,
                        _formkey,
                        context,
                        descController.text,
                      );
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                    },
                    child: CustomRaisedButton(
                      buttonText: 'Publish Article',
                    )),
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: BottomAppBarPage(),
    );
  }
}
