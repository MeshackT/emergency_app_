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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
                  child: SizedBox(
                    child: Icon(
                      Icons.add_alert,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          side: const BorderSide(color: Colors.purple),
                        ),
                      ),
                    ),
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
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 100,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          side: const BorderSide(color: Colors.purple),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FireFighterRequest()),
                      );
                    },
                    child: const Text(
                      "Fire Fighter",
                      style: TextStyle(fontSize: 25, color: Colors.purple),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 100,
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          side: const BorderSide(color: Colors.purple),
                        ),
                      ),
                    ),
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
        ),
      ),
    );
  }
}
