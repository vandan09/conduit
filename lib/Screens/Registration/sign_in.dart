import 'package:another_flushbar/flushbar.dart';
import 'package:first_app/Screens/Drawer/home.dart';
import 'package:first_app/Screens/Registration/signup_page.dart';
import 'package:first_app/Widget/customRaisedButton.dart';
import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/model/user_model.dart';
import 'package:first_app/provider/auth_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/services/api.dart';
import 'package:first_app/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
  String? _userEmail, _password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void doLoggedin() {
      // final form = _formKey.currentState;

      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        print('Entered');
        // final Future<Map<String, dynamic>> respose =
        //     auth.login(_userEmail!, _password!);
        // print('added');
        // respose.then((response) {
        //   if (response['status']) {
        //     User user = response['user'];
        //     print('here');

        //     Provider.of<UserProvider>(context, listen: false).setUser(user);
        //     print('SetUser');

        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
        //     print('Entered');
        //   }

        //   else {
        //     print('Error');

        //     Flushbar(
        //       title: "Failed Login",
        //       message: response['message']['message'].toString(),
        //       duration: Duration(seconds: 2),
        //     ).show(context);
        //   }
        // });
      } else {
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    }

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
                            controller: _controller,
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
                              auth.loggedInStatus == Status.Authenticating
                                  ? CircularProgressIndicator()
                                  : doLoggedin();
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
