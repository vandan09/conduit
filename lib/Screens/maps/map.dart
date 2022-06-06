import 'package:first_app/constants/Constantcolors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController googleMapController;
  CameraPosition initicameraPosition = CameraPosition(target: LatLng(0, 0));
  // Location location = new Location();
  Set<Marker> makers = {};
  Location location = Location();
  bool? _isServiceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  bool _isListenLoction = false;
  bool _isGetLoction = false;
  ConstantColors constantColors = ConstantColors();
  // LatLng? latLng;
  double? latitude;
  double? longitude;
  double? deslatitude;
  double? deslongitude;
  @override
  void initState() {
    // TODO: implement initState
    // latLng=
    super.initState();
  }

  Marker _kLakeMarker = Marker(
    markerId: MarkerId('_kGLakePlex'),
    infoWindow: InfoWindow(title: 'Lake Plex'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    position: LatLng(0, 0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: constantColors.whiteColor),
        backgroundColor: constantColors.greenColor,
        title: SizedBox(
          child: Text(
            'Map',
            overflow: TextOverflow.visible,
            style: TextStyle(
                color: constantColors.whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // body: Center(
      //     child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ElevatedButton(
      //       onPressed: () async {
      //         _isServiceEnabled = await location.serviceEnabled();
      //         if (!_isServiceEnabled!) {
      //           _isServiceEnabled = await location.requestService();
      //           if (_isServiceEnabled!) {
      //             return;
      //           }
      //         }
      //         _permissionGranted = await location.hasPermission();
      //         if (_permissionGranted == PermissionStatus.denied) {
      //           _permissionGranted = await location.requestPermission();
      //           if (_permissionGranted == PermissionStatus.granted) {
      //             return;
      //           }
      //         }
      //         _locationData = await location.getLocation();
      //         setState(() {
      //           _isGetLoction = true;
      //           print('true');
      //         });
      //       },
      //       child: Text('Get Location'),
      //     ),
      //     _isGetLoction
      //         ? Text(
      //             'Location : ${_locationData!.latitude}/${_locationData!.longitude}')
      //         : Container(),
      //     ElevatedButton(
      //       onPressed: () async {
      //         _isServiceEnabled = await location.serviceEnabled();
      //         if (!_isServiceEnabled!) {
      //           _isServiceEnabled = await location.requestService();
      //           if (_isServiceEnabled!) {
      //             return;
      //           }
      //         }
      //         _permissionGranted = await location.hasPermission();
      //         if (_permissionGranted == PermissionStatus.denied) {
      //           _permissionGranted = await location.requestPermission();
      //           if (_permissionGranted == PermissionStatus.granted) {
      //             return;
      //           }
      //         }
      //         // _locationData = await location.getLocation();
      //         setState(() {
      //           _isListenLoction = true;
      //           print('true');
      //         });
      //       },
      //       child: Text('Listen Location'),
      //     ),
      //     StreamBuilder(
      //         stream: location.onLocationChanged,
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           } else {
      //             var data = snapshot.data as LocationData;
      //             return Text(
      //                 'location always change: ${data.latitude}/${data.longitude}');
      //           }
      //         }),
      body: Column(
        children: [
          // Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         padding: EdgeInsets.symmetric(horizontal: 20.0),
          //         child: TextFormField(
          //           // controller: searchController,
          //           textCapitalization: TextCapitalization.words,
          //           decoration: InputDecoration(
          //             hintText: ' Search here',
          //           ),
          //           onChanged: (value) {
          //             print(value);
          //           },
          //         ),
          //       ),
          //     ),
          //     IconButton(
          //       onPressed: () {},
          //       icon: Icon(Icons.search),
          //     ),
          //   ],
          // ),
          Expanded(
            child: GoogleMap(
              onTap: (latLng) {
                setState(() {
                  deslatitude = latLng.latitude;
                  deslongitude = latLng.longitude;
                  Marker _kFinalMarker = Marker(
                      markerId: MarkerId('_kGLakePlex'),
                      infoWindow: InfoWindow(title: 'Final Loction'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueViolet),
                      position: LatLng(deslatitude!, deslongitude!));

                  makers.add(_kFinalMarker);
                });
                Fluttertoast.showToast(timeInSecForIosWeb: 2,
                    // textColor: constantColors.darkColor,
                    msg: '''
Final Location : 
${deslatitude}/${deslongitude}''');
              },
              markers: makers,
              initialCameraPosition: initicameraPosition,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _isServiceEnabled = await location.serviceEnabled();
          if (!_isServiceEnabled!) {
            _isServiceEnabled = await location.requestService();
            if (_isServiceEnabled!) {
              return;
            }
          }
          _permissionGranted = await location.hasPermission();
          if (_permissionGranted == PermissionStatus.denied) {
            _permissionGranted = await location.requestPermission();
            if (_permissionGranted == PermissionStatus.granted) {
              return;
            }
          }
          _locationData = await location.getLocation();
          setState(() {
            _isGetLoction = true;
            latitude = _locationData!.latitude;
            longitude = _locationData!.longitude;
            Marker _kGooglePlexMarker = Marker(
                markerId: MarkerId('_kGooglePlex'),
                infoWindow: InfoWindow(title: 'Current Loction'),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(latitude!, longitude!));

            makers.add(_kGooglePlexMarker);
            initicameraPosition = CameraPosition(
                target: LatLng(
                  latitude!,
                  longitude!,
                ),
                zoom: 19.151926040649414);
            print('true');
          });
          !_isGetLoction
              ? Fluttertoast.showToast(msg: 'Location : 0')
              : Fluttertoast.showToast(
                  timeInSecForIosWeb: 5,
                  // textColor: constantColors.darkColor,
                  msg:
                      'Current Location : ${_locationData!.latitude}/${_locationData!.longitude}');
        },
      ),
    );
  }
}
