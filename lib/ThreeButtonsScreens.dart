import 'package:afpemergencyapplication/CallerClass/DirectCallerClass.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ThreeButtonsScreen extends StatefulWidget {
  const ThreeButtonsScreen({Key? key}) : super(key: key);
  static const routeName = '/threeButtonsScreen';

  @override
  _ThreeButtonsScreenState createState() => _ThreeButtonsScreenState();
}

class _ThreeButtonsScreenState extends State<ThreeButtonsScreen> {
  String name = "";

  DirectCallerClass directCallerClass = DirectCallerClass();
  Logger log = Logger(
    printer: PrettyPrinter(colors: true),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //////////////////////Ambulance/////////////////////////////////////
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: InkWell(
                    onTap: () async {
                      // Navigator.pushReplacementNamed(
                      //     context, CallForHelp.routeName);
                      await directCallerClass.callNumber();
                      log.i(
                        directCallerClass.callNumber(),
                      );
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
                      // Navigator.pushReplacementNamed(
                      //     context, CallForHelp.routeName);
                      directCallerClass.callFireFighterNumber();
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
                      // Navigator.pushReplacementNamed(
                      //     context, CallForHelp.routeName);
                      directCallerClass.callPoliceNumber();
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
