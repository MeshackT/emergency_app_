import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DirectCallerClass {
  callAmbulanceNumber() async {
    int number = 08177;
    await FlutterPhoneDirectCaller.callNumber(number.toString());
  }

  callFireFighterNumber() async {
    int number = 0800055555;
    await FlutterPhoneDirectCaller.callNumber(number.toString());
  }

  callPoliceNumber() async {
    int number = 1011;
    await FlutterPhoneDirectCaller.callNumber(number.toString());
  }

// launchPhoneURL(String phoneNumberCaller) async {
//   String url = 'tel:' + phoneNumberCaller;
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }

}
