import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DirectCallerClass {
  callNumber() async {
    const number = '0604564022'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future<void> callAmbulanceNumber() async {
    String number = "0604564022";
    await FlutterPhoneDirectCaller.callNumber(int.parse(number).toString());
  }

  callFireFighterNumber() async {
    String number = "0800055555";
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  callPoliceNumber() async {
    int number = 081011;
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
