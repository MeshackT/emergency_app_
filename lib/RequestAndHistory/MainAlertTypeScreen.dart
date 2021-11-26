import 'package:afpemergencyapplication/MainSreens/HomeScreen.dart';
import 'package:afpemergencyapplication/RequestAndHistory/FireFighterRequest.dart';
import 'package:afpemergencyapplication/RequestAndHistory/MyRequest.dart';
import 'package:afpemergencyapplication/RequestAndHistory/PoliceRequest.dart';
import 'package:flutter/material.dart';

class MainAlertTypeScreen extends StatefulWidget {
  static const routeName = '/requestTypScreen';

  const MainAlertTypeScreen({Key? key}) : super(key: key);

  @override
  _MainAlertTypeScreenState createState() => _MainAlertTypeScreenState();
}

class _MainAlertTypeScreenState extends State<MainAlertTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alert Type",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmergencyType(),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MyRequest.routeName, (route) => false);
                },
                child: const Text(
                  "Ambulance",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
              ),
            ),
            Container(
              height: 100,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FireFighterRequest()),
                  );
                },
                child: const Text(
                  "Fire Fighter",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
              ),
            ),
            Container(
              height: 100,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PoliceRequest(),
                    ),
                  );
                },
                child: const Text(
                  "Police",
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
