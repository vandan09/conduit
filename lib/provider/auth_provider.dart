// import 'dart:async';
// import 'dart:convert';

// import 'package:first_app/model/user_model.dart';
// import 'package:first_app/utils/app_url.dart';
// import 'package:first_app/utils/shared_prefences.dart';
// // import 'package:first_app/utils/shared_prefences.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart';

// enum Status {
//   NotLoggedIn,
//   NotRegistered,
//   LoggedIn,
//   Registered,
//   Authenticating,
//   Registering,
//   LoggedOut
// }

// class AuthProvider extends ChangeNotifier {
//   Status _logedInStatus = Status.NotLoggedIn;
//   Status _registeredInStatus = Status.NotRegistered;

//   Status get loggedInStatus => _logedInStatus;

//   set loggedInStatus(Status value) {
//     _logedInStatus = value;
//   }

//   Status get registeredInStatus => _registeredInStatus;

//   set registeredInStatus(Status value) {
//     _registeredInStatus = value;
//   }

//   Future<FutureOr> register(String email, String password) async {
//     final Map<String, dynamic> apiBodyData = {
//       'email': email,
//       'password': password
//     };

//     return await post(Uri.parse(AppUrl.register),
//             body: json.encode(apiBodyData),
//             headers: {'Content-Type': 'application/json'})
//         .then(onValue)
//         .catchError(onError);
//   }

//   notify() {
//     notifyListeners();
//   }

//   static Future<FutureOr> onValue(Response response) async {
//     var result;

//     final Map<String, dynamic> responseData = json.decode(response.body);

//     print(responseData);

//     if (response.statusCode == 200) {
//       var userData = responseData['data'];

//       // now we will create a user model
//       User authUser = User.fromJson(responseData);

//       // now we will create shared preferences and save data
//       UserPreferences().saveUser(authUser);

//       result = {
//         'status': true,
//         'message': 'Successfully registered',
//         'data': authUser
//       };
//     } else {
//       result = {
//         'status': false,
//         'message': 'Successfully registered',
//         'data': responseData
//       };
//     }
//     return result;
//   }

//   Future<Map<String, dynamic>> login(String email, String password) async {
//     var result;

//     final Map<String, dynamic> loginData = {
//       'UserEmail': email,
//       'Password': password
//     };

//     _logedInStatus = Status.Authenticating;
//     notifyListeners();

//     Response response = await post(
//       Uri.parse(AppUrl.login),
//       body: json.encode(loginData),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
//         'X-ApiKey': 'ZGlzIzEyMw=='
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);

//       print(responseData);

//       var userData = responseData['Content'];

//       User authUser = User.fromJson(userData);

//       UserPreferences().saveUser(authUser);

//       _logedInStatus = Status.LoggedIn;
//       notifyListeners();

//       result = {'status': true, 'message': 'Successful', 'user': authUser};
//     } else {
//       _logedInStatus = Status.NotLoggedIn;
//       notifyListeners();
//       result = {
//         'status': false,
//         'message': json.decode(response.body)['error']
//       };
//     }

//     return result;
//   }

//   static onError(error) {
//     print('the error is ${error.detail}');
//     return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
//   }
// }
