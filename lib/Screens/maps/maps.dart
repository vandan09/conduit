// // ignore_for_file: prefer_const_constructors

// import 'dart:async';

// import 'package:first_app/Screens/maps/map_services.dart';
// import 'package:first_app/constants/Constantcolors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   // initlization some value
//   ConstantColors constantColors = ConstantColors();
//   Completer<GoogleMapController> _controller = Completer();
//   TextEditingController searchController = TextEditingController();
//   // ignore: prefer_const_constructors
//   // google map intializtion
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//   static final Marker _kGooglePlexMarker = Marker(
//     markerId: MarkerId('_kGooglePlex'),
//     infoWindow: InfoWindow(title: 'Google Plex'),
//     icon: BitmapDescriptor.defaultMarker,
//     position: LatLng(37.42796133580664, -122.085749655962),
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//   static final Marker _kLakeMarker = Marker(
//     markerId: MarkerId('_kGLakePlex'),
//     infoWindow: InfoWindow(title: 'Lake Plex'),
//     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
//     position: LatLng(37.43296265331129, -122.08832357078792),
//   );
//   static final Polyline _kPolyLine = Polyline(
//       polylineId: PolylineId('_kPolyLine'),
//       points: [
//         LatLng(37.42796133580664, -122.085749655962),
//         LatLng(37.43296265331129, -122.08832357078792),
//       ],
//       width: 5);

//   // scafold
//   @override
//   Widget build(BuildContext context) {
//     // ignore: unnecessary_new
//     return new Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: constantColors.whiteColor),
//         backgroundColor: constantColors.greenColor,
//         title: SizedBox(
//           child: Text(
//             'Google Map',
//             overflow: TextOverflow.visible,
//             style: TextStyle(
//                 color: constantColors.whiteColor, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: TextFormField(
//                     controller: searchController,
//                     textCapitalization: TextCapitalization.words,
//                     decoration: InputDecoration(
//                       hintText: ' Search here',
//                     ),
//                     onChanged: (value) {
//                       print(value);
//                     },
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   MapServices().getPlaceId(searchController.text);
//                 },
//                 icon: Icon(Icons.search),
//               ),
//             ],
//           ),
//           Expanded(
//             child: GoogleMap(
//               mapType: MapType.normal,
//               // polylines: {_kPolyLine},
//               markers: {
//                 _kGooglePlexMarker,
//               },
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//           ),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton.extended(
//       //   onPressed: _goToTheLake,
//       //   label: Text('To the lake!'),
//       //   icon: Icon(Icons.directions_boat),
//       // ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
