import 'package:first_app/Screens/Drawer/home.dart';
import 'package:first_app/Screens/Registration/SignupPage.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/model/user_model.dart';
import 'package:first_app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  ConstantColors constantColors = ConstantColors();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  // Future<Album>? _futureAlbum;

  Widget _buildLoginForm() {
    return Column(
      children: [
        // Email Text Field
        Container(
            margin: EdgeInsets.fromLTRB(30, 80, 30, 0),
            child: TextField(
              onTap: FocusScope.of(context).unfocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: _controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Email'),
            )),
        //password
        Container(
            margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: TextField(
              onTap: FocusScope.of(context).unfocus,
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
                setState(() {
                  // _futureAlbum = createAlbum(_controller.text);
                });
                FocusScope.of(context).unfocus();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: CustomRaisedButton(
                buttonText: 'Sign in',
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
