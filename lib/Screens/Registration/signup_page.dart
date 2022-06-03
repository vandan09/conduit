import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Screens/HomePage/home.dart';
import 'package:first_app/Screens/others/new_article.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/user_model.dart';

import 'package:first_app/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // RegisterWelcome? _welcome;

  void initState() {
    super.initState();
  }

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  bool visible = false;
  ConstantColors constantColors = ConstantColors();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // String? _userName, _userEmail, _password;

  RegisterWelcome? _registerWelcome;
  SharedPreferences? prefs;
  String? value;

  saveStringValue(String token) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("token", token);
  }

  saveUsernameValue(String name) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("username", name);
  }

  void doRegister(String name, String email, String password) async {
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
        "user": {"email": email, "password": password, "username": name}
      };

      try {
        http.Response response = await http.post(
            Uri.parse(Strings.register_url),
            body: json.encode(userBody),
            headers: <String, String>{
              "Accept": "application/json",
              "content-type": "application/json"
            });
        if (response.statusCode == 200) {
          print('Accont created');

          _registerWelcome =
              RegisterWelcome.fromJson(jsonDecode(response.body));
          saveStringValue(_registerWelcome!.user.token);
          saveUsernameValue(name);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => LogInPage())));
          print('Account Created successfully');
        } else {
          String str1 = jsonDecode(response.body).toString();
          String str2 =
              str1.replaceAll(new RegExp(r"\p{P}", unicode: true), "");
          String error = str2.substring(7);
          Navigator.pop(context);

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
    return AutofillGroup(
      child: GestureDetector(
        child: Scaffold(
            body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    //sign in head
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 150),
                        child: Text('Sign up',
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
                            // username Text Field
                            Container(
                                margin: EdgeInsets.fromLTRB(30, 80, 30, 0),
                                child: TextFormField(
                                  autofillHints: [AutofillHints.givenName],
                                  // onSaved: (value) => _userName = value,
                                  validator: (value) =>
                                      value!.isEmpty ? "Enter User name" : null,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color:
                                                  constantColors.greenColor)),
                                      border: OutlineInputBorder(),
                                      hintText: 'Username'),
                                )),
                            //email
                            Container(
                                margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                                child: TextFormField(
                                  autofillHints: [AutofillHints.email],

                                  // onSaved: (value) => _userEmail = value,
                                  validator: validateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color:
                                                  constantColors.greenColor)),
                                      border: OutlineInputBorder(),
                                      hintText: 'Email'),
                                )),
                            //password
                            Container(
                                margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                                child: TextFormField(
                                  autofillHints: [AutofillHints.password],
                                  onEditingComplete: () =>
                                      TextInput.finishAutofillContext(),

                                  // onSaved: (value) => _password = value,
                                  validator: (value) =>
                                      value!.isEmpty ? "Enter Password" : null,
                                  obscureText: !visible,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color:
                                                  constantColors.greenColor)),
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              visible = !visible;
                                            });
                                          },
                                          child: Icon(
                                            visible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: constantColors.greenColor,
                                          )),
                                      border: OutlineInputBorder(),
                                      hintText: 'Password'),
                                )),
                            //login button
                            Padding(
                              padding: const EdgeInsets.all(40),
                              child: GestureDetector(
                                  onTap: () {
                                    // auth.loggedInStatus == Status.Authenticating
                                    // ? CircularProgressIndicator()
                                    setState(() {
                                      doRegister(
                                          usernameController.text,
                                          emailController.text,
                                          passwordController.text);
                                    });
                                  },
                                  child: CustomRaisedButton(
                                    buttonText: 'Sign up',
                                  )),
                            ),
                          ],
                        )),
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
                                      builder: (context) => LogInPage()));
                            },
                            child: Container(
                              child: Text(
                                'Have an account?',
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
          ),
        )),
      ),
    );
  }

  // Widget _buildLoginForm() {
  //   return
  // }
}
