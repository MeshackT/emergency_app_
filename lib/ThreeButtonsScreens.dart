import 'package:afpemergencyapplication/CallForHelp.dart';
import 'package:flutter/material.dart';

class ThreeButtonsScreen extends StatefulWidget {
  const ThreeButtonsScreen({Key? key}) : super(key: key);
  static const routeName = '/threeButtonsScreen';

  @override
  _ThreeButtonsScreenState createState() => _ThreeButtonsScreenState();
}

class _ThreeButtonsScreenState extends State<ThreeButtonsScreen> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //////////////////////Ambulance/////////////////////////////////////
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, CallForHelp.routeName);
                    },
                    child: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.car_repair,
                        color: Colors.green,
                        size: 80,
                      ),
                    ),
                  ),
                ),
              ),
              //////////////////////Fire/////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, CallForHelp.routeName);
                    },
                    child: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                        size: 80,
                      ),
                    ),
                  ),
                ),
              ),
              //////////////////////Police/////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, CallForHelp.routeName);
                    },
                    child: const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.local_police,
                        color: Colors.blue,
                        size: 80,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
