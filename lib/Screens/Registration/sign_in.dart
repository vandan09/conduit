import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Screens/HomePage/home.dart';
import 'package:first_app/Screens/Registration/signup_page.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/user_model.dart';

import 'package:first_app/services/api.dart';
import 'package:first_app/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  ConstantColors constantColors = ConstantColors();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // Future<Album>? _futureAlbum;
  Future<RegisterWelcome>? _registerModel;

  String? _userEmail, _password;
  void doLoggedin(String email, String password) async {
    if (_formkey.currentState!.validate()) {
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
      _formkey.currentState!.save();
      print('valid');
      var userBody = <String, dynamic>{
        "user": {"email": email, "password": password}
      };

      try {
        http.Response response = await http.post(Uri.parse(Strings.login_url),
            body: json.encode(userBody),
            // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
            headers: <String, String>{
              "Accept": "application/json",
              "content-type": "application/json"
            });
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => HomeScreen())));
          // print('Account Created successfully');
          RegisterWelcome.fromJson(jsonDecode(response.body));
        } else {
          String str1 = jsonDecode(response.body).toString();
          String str2 =
              str1.replaceAll(new RegExp(r"\p{P}", unicode: true), "");
          String error = str2.substring(7);
          Navigator.pop(context);
          // Navigator.pop(context);
          // ignore: use_build_context_synchronously

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
    } else {
      Flushbar(
        title: 'Invalid form',
        message: 'Please complete the form properly',
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formkey,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                //sign in head
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 150),
                    child: Text('Sign in',
                        style: TextStyle(
                            color: constantColors.darkColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                //form
                Container(
                  // margin: EdgeInsets.only(top: 80),
                  margin: EdgeInsets.fromLTRB(30, 180, 30, 50),

                  child: Column(
                    children: [
                      // Email Text Field
                      Container(
                          margin: EdgeInsets.fromLTRB(30, 80, 30, 0),
                          child: TextFormField(
                            autofocus: false,
                            onSaved: (value) => _userEmail = value,
                            validator: validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Email'),
                          )),
                      //password
                      Container(
                          margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: TextFormField(
                            // onTap: FocusScope.of(context).unfocus,
                            autofocus: false,
                            validator: (value) =>
                                value!.isEmpty ? "Please enter password" : null,
                            onSaved: (value) => _password = value,
                            obscureText: true,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Password'),
                          )),
                      //login button
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                doLoggedin(emailController.text,
                                    passwordController.text);
                              });

                              // FocusScope.of(context).unfocus();
                            },
                            child: CustomRaisedButton(
                              buttonText: 'Sign in',
                            )),
                      ),
                    ],
                  ),
                ),
                // SignUp Line
                Container(
                  margin: EdgeInsets.fromLTRB(30, 200, 30, 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Container(
                          child: Text(
                            'Need an account?',
                            style: TextStyle(
                              color: constantColors.greenColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
