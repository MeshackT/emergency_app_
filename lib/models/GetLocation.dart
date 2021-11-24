import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class GetLocation {
  Position? currentPosition;
  String? currentAddress;
  Logger log = Logger();

  Future<void> getCurrentLocation() async {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      currentPosition = position;
      getAddressFromLatLng();
    });
  }

  Future<void> getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
              currentPosition!.latitude, currentPosition!.longitude)
          .whenComplete(
        () => Fluttertoast.showToast(
            msg: 'Current location captured',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16),
      );

      Placemark place = placemarks[0];

      currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";
      log.i("Location: $currentAddress");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
