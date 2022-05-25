import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/user_model.dart';

// import 'package:first_app/provider/auth_provider.dart';
import 'package:first_app/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

// import '../../services/api.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // RegisterWelcome? _welcome;
  Future<RegisterWelcome>? _registerModel;

  void initState() {
    super.initState();
  }

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  ConstantColors constantColors = ConstantColors();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // String? _userName, _userEmail, _password;
  Future<RegisterWelcome> doRegister(
      String name, String email, String password) async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      print('valid');
      var userBody = <String, dynamic>{
        "user": {"email": email, "password": password, "username": name}
      };

      try {
        http.Response response = await http.post(
            Uri.parse(Strings.register_url),
            body: json.encode(userBody),
            // encoding: Encoding.getByName("application/x-www-form-urlencoded"),
            headers: <String, String>{
              "Accept": "application/json",
              "content-type": "application/json"
            });
        if (response.statusCode == 200) {
          print('Accont created');

          return RegisterWelcome.fromJson(jsonDecode(response.body));
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: ((context) => LogInPage())));
          // print('Account Created successfully');
        } else {
          throw Exception('Failed to create model. ${response.body}');
        }
      } catch (e) {
        print(e);
      }
    } else {
      Flushbar(
        title: 'Invalid form',
        message: 'Please complete the form properly',
        duration: Duration(seconds: 2),
      ).show(context);
    }
    throw 'error';
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
                              // onSaved: (value) => _userName = value,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter User name" : null,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: usernameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Username'),
                            )),
                        //email
                        Container(
                            margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: TextFormField(
                              // onSaved: (value) => _userEmail = value,
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
                              // onSaved: (value) => _password = value,
                              validator: (value) =>
                                  value!.isEmpty ? "Enter Password" : null,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: passwordController,
                              decoration: InputDecoration(
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
                                  _registerModel = doRegister(
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
      )),
    );
  }

  // Widget _buildLoginForm() {
  //   return
  // }
}
