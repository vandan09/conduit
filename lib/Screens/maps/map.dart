import 'dart:async';
// import 'dart:html';
import 'dart:math';

import 'package:first_app/constants/Constantcolors.dart';
import 'package:first_app/model/loction_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

const fetchBackground = "fetchBackground";

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController googleMapController;
  Completer<GoogleMapController> _controller = Completer();
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
  Set<Polyline> polylines = {};

  String calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    print('total dis:${12742 * asin(sqrt(a))}');
    return (12742 * asin(sqrt(a))).toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    // initStateAsync();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    var locationModel = Provider.of<LocationModel>(context);

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
      body: Stack(
        children: [
          // map
          GoogleMap(
            // destnation loaction
            onTap: latitude != null
                ? (latLng) async {
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
                    final GoogleMapController controller =
                        await _controller.future;
                    controller.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            bearing: 192.8334901395799,
                            target: LatLng(deslatitude!, deslongitude!),
                            tilt: 59.440717697143555,
                            zoom: 19.151926040649414)));

                    Fluttertoast.showToast(timeInSecForIosWeb: 2,
                        // textColor: constantColors.darkColor,
                        msg: '''
Final Location : 
${deslatitude}/${deslongitude}''');
                    Polyline polyline = Polyline(
                        width: 4,
                        color: constantColors.blueColor,
                        polylineId: PolylineId('finalPolylineId'),
                        visible: true,
                        points: [
                          LatLng(deslatitude!, deslongitude!),
                          LatLng(
                            latitude!,
                            longitude!,
                          ),
                        ]);
                    polylines.add(polyline);
                  }
                : null,

            markers: makers,

            initialCameraPosition: initicameraPosition,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            polylines: polylines,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: constantColors.whiteColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(40)),
              // margin: EdgeInsets.all(value),
              margin: EdgeInsets.only(left: 20, top: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.89,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),

              child: latitude == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Current loaction',
                          style: TextStyle(fontSize: 20),
                        ),
                        // current loc buton

                        GestureDetector(
                          child: Icon(Icons.send),
                          onTap: () async {
                            _isServiceEnabled = await location.serviceEnabled();
                            if (!_isServiceEnabled!) {
                              _isServiceEnabled =
                                  await location.requestService();
                              if (_isServiceEnabled!) {
                                return;
                              }
                            }
                            _permissionGranted = await location.hasPermission();
                            if (_permissionGranted == PermissionStatus.denied) {
                              _permissionGranted =
                                  await location.requestPermission();
                              if (_permissionGranted ==
                                  PermissionStatus.granted) {
                                return;
                              }
                            }
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
                            _locationData = await location.getLocation();
                            setState(() {
                              _isGetLoction = true;
                              latitude = _locationData!.latitude;
                              longitude = _locationData!.longitude;
                              Marker _kGooglePlexMarker = Marker(
                                  markerId: MarkerId('_kGooglePlex'),
                                  infoWindow:
                                      InfoWindow(title: 'Current Loction'),
                                  icon: BitmapDescriptor.defaultMarker,
                                  position: LatLng(latitude!, longitude!));

                              makers.add(_kGooglePlexMarker);
                            });
                            Navigator.pop(context);
                            final GoogleMapController controller =
                                await _controller.future;
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    bearing: 192.8334901395799,
                                    target: LatLng(latitude!, longitude!),
                                    tilt: 59.440717697143555,
                                    zoom: 19.151926040649414)));
                            !_isGetLoction
                                ? Fluttertoast.showToast(msg: 'Location : 0')
                                : Fluttertoast.showToast(
                                    timeInSecForIosWeb: 5,
                                    // textColor: constantColors.darkColor,
                                    msg:
                                        'Current Location : ${_locationData!.latitude}/${_locationData!.longitude}');
                          },
                        ),
                      ],
                    )
                  : deslatitude == null
                      ? Center(
                          child: Text(
                            'Select Destination loaction',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : Center(
                          child: Text(
                            'Total Distance : ${calculateDistance(latitude, longitude, deslatitude, deslongitude)} KM',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 70.0),
            child: Container(
              decoration: BoxDecoration(
                  color: constantColors.whiteColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(40)),
              // margin: EdgeInsets.all(value),
              margin: EdgeInsets.only(left: 20, top: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.89,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Center(
                child: Text(
                  'Current Location : ${locationModel.latitude}/${locationModel.longitude}',
                  style: TextStyle(color: constantColors.darkColor),
                ),
              ),
            ),
          ),
        ],
      ),
      // current loction
      // floatingActionButton:
    );
  }
}
