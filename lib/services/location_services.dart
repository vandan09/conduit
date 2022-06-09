import 'dart:async';

import 'package:first_app/model/loction_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

class locationSevices {
  Location location = Location();
  LocationModel? curreLoction;
  StreamController<LocationModel> loctionController =
      StreamController<LocationModel>.broadcast();

  Stream<LocationModel> get getStreamData => loctionController.stream;
  locationSevices() {
    location.requestPermission().then((loctionPermission) {
      if (loctionPermission == PermissionStatus.granted) {
        location.onLocationChanged.listen((loctionValue) {
          loctionController.add(LocationModel(
              latitude: loctionValue.latitude!,
              longitude: loctionValue.longitude!));

          // Fluttertoast.showToast(
          //     timeInSecForIosWeb: 3,
          //     textColor: Colors.white,
          //     msg:
          //         ' latitude: ${loctionValue.latitude!}, longitude: ${loctionValue.longitude!}',
          //     backgroundColor: Colors.black);
        });
      }
    });
  }
}
