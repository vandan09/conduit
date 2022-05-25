import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Screens/Drawer/Home.dart';
import 'package:first_app/Widget/buttomAppBar.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  ConstantColors constantColors = ConstantColors();
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? CustomeValidaor(String? value) {
    String? _msg;

    if (value!.isEmpty) {
      _msg = "Required";
    }
    return _msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: SizedBox(
          child: Text(
            'Setting',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                  child: TextFormField(
                    autofocus: false,
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'URL of profile picture'),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Bio"),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextFormField(
                    obscureText: true,
                    validator: CustomeValidaor,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'New Password'),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                        print('Entered');
                        Flushbar(
                          title: 'Setting updated',
                          message: ' ',
                          duration: Duration(seconds: 2),
                        ).show(context);
                      } else {
                        Flushbar(
                          title: 'Invalid form',
                          message: 'Please complete the form properly',
                          duration: Duration(seconds: 2),
                        ).show(context);
                      }
                    },
                    child: CustomRaisedButton(
                      buttonText: 'Update Settings',
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: constantColors.greyColor,
                ),
              ),
              //logout
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) => LogInPage(),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: constantColors.redColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Or click here to logout',
                        style: TextStyle(color: constantColors.redColor),
                      ),
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
