import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Screens/HomePage/home.dart';
import 'package:first_app/Screens/Registration/signup_page.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/user_model.dart';

import 'package:first_app/services/api.dart';
import 'package:first_app/services/google_singin.dart';
import 'package:first_app/services/shared_prefences.dart';
import 'package:first_app/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  PrefServices _prefServices = PrefServices();
  bool visible = false;
  ConstantColors constantColors = ConstantColors();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // Future<Album>? _futureAlbum;
  RegisterWelcome? _registerModel;

  SharedPreferences? prefs;
  String? value;
  String? name;
  String? emailValue;

  saveStringValue(String token) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("token", token);
  }

  saveEmailValue(String email) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("email", email);
  }

  saveNameValue(String name) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setString("username", name);
  }

  retrieveStringValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      value = prefs!.getString("token");
    });
    print('token at sign in value $value');
  }

  retrieveUsernameValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs!.getString("username");
    });
    print('user name at sign in $name');
  }

  retrieveemailValue() async {
    prefs = await SharedPreferences.getInstance();
    emailValue = prefs!.getString("email");
    print('user name $emailValue');
  }

  void doLoggedin(String email, String password) async {
    _prefServices.createCache(emailController.text).whenComplete(() async {
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
            RegisterWelcome.fromJson(jsonDecode(response.body));
            retrieveStringValue();
            retrieveUsernameValue();
            // saveEmailValue(email);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(value, name)),
                (Route<dynamic> route) => false);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
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
                              autofillHints: [AutofillHints.email],

                              autofocus: false,
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
                                          color: constantColors.greenColor)),
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
                              // onTap: FocusScope.of(context).unfocus,
                              autofocus: false,
                              validator: (value) => value!.isEmpty
                                  ? "Please enter password"
                                  : null,
                              // onSaved: (value) => _password = value,
                              obscureText: !visible,
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: constantColors.greenColor)),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: GestureDetector(
                              onTap: () {
                                print('enter');

                                Provider.of<GoogleSignInPRovider>(context,
                                        listen: false)
                                    .googlelogin()
                                    .whenComplete(() {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                              Provider.of<GoogleSignInPRovider>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  .id,
                                              Provider.of<GoogleSignInPRovider>(
                                                      context,
                                                      listen: false)
                                                  .user
                                                  .displayName)),
                                      (Route<dynamic> route) => false);
                                });

                                print('done');
                              },
                              child: Row(
                                children: [
                                  CustomRaisedButton(
                                    buttonText: 'Sign in using Google',
                                  ),
                                ],
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
        ),
      )),
    );
  }
}
