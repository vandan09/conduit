// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// class MapServices {
//   final String key = "AIzaSyBqDtT8TqvxSz4ok5DFGiQyb6LI4PfxMb0";

//   Future<String> getPlaceId(String input) async {
//     final String url =
//         "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key";

//     var response = await http.get(Uri.parse(url));

//     var json = convert.jsonDecode(response.body);

//     var placeId = json['candidates'][0]['place_id'] as String;

//     print(placeId);
//     return placeId;
//   }
//   // Future<Map<String,dynamic>> getPlaceId(String input)async{}

// }
