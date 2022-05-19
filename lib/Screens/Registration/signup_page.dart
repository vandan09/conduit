import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/Screens/Registration/sign_in.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  ConstantColors constantColors = ConstantColors();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? _userName, _userEmail, _password;

  void doRegister() {
    // final FormState form = formKey.currentContext as FormState;

    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      print("done");
      print(_userEmail);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_function_declarations_over_variables

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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

                  child: _buildLoginForm(),
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

  Widget _buildLoginForm() {
    return Column(
      children: [
        // username Text Field
        Container(
            margin: EdgeInsets.fromLTRB(30, 80, 30, 0),
            child: TextFormField(
              onSaved: (value) => _userName = value,
              validator: (value) => value!.isEmpty ? "Enter User name" : null,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Username'),
            )),
        //email
        Container(
            margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: TextFormField(
              onSaved: (value) => _userEmail = value,
              validator: validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Email'),
            )),
        //password
        Container(
            margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: TextFormField(
              onSaved: (value) => _password = value,
              validator: (value) => value!.isEmpty ? "Enter Password" : null,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Password'),
            )),
        //login button
        Padding(
          padding: const EdgeInsets.all(40),
          child: GestureDetector(
              onTap: () {
                doRegister();
              },
              child: CustomRaisedButton(
                buttonText: 'Sign up',
              )),
        ),
      ],
    );
  }
}
