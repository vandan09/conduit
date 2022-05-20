// import 'dart:convert';

// import 'package:first_app/model/user_model.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:first_app/constants/constant_strings.dart';
import 'package:first_app/model/article_model.dart';
import 'package:http/http.dart' as http;

// //converting
// Future<Album> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }

class API_Manager {
  Future<Welcome> getArtciles() async {
    var client = http.Client();
    var articleModel = null;
    try {
      var response = await client.get(Uri.parse(Strings.article_url));
      if (response.statusCode == 200) {
        var jsonString = response.body;

        var jsonMap = json.decode(jsonString);

        articleModel = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      return articleModel;
    }
    return articleModel;
  }
}
