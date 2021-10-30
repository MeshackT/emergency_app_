import 'package:afpemergencyapplication/HomeScreen.dart';
import 'package:flutter/material.dart';

class CallForHelp extends StatefulWidget {
  const CallForHelp({Key? key}) : super(key: key);
  static const routeName = '/callforhelpScreen';

  @override
  _CallForHelpState createState() => _CallForHelpState();
}

class _CallForHelpState extends State<CallForHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, EmergencyType.routeName);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: const Center(
        child: Text("Call for help"),
      ),
    );
  }
}
