import 'package:afpemergencyapplication/AmbulanceScreen.dart';
import 'package:afpemergencyapplication/FireFighterScreen.dart';
import 'package:afpemergencyapplication/PoliceScreen.dart';
import 'package:afpemergencyapplication/ThreeButtonsScreens.dart';
import 'package:afpemergencyapplication/UserProfile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmergencyType extends StatefulWidget {
  const EmergencyType({Key? key}) : super(key: key);
  static const routeName = '/emergencyHomeScreen';

  @override
  State<EmergencyType> createState() => _EmergencyTypeState();
}

class _EmergencyTypeState extends State<EmergencyType> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    ThreeButtonsScreen(),
    AmbulanceScreen(),
    FireFighterScreen(),
    PoliceScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  // final tabs = [
  //
  // Column(
  //   children: [
  //     Container(
  //       height: 200,
  //       width: 200,
  //       color: Colors.green[50],
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: const [
  //           Text("ambulance"),
  //         ],
  //       ),
  //     ),
  //     TextButton(
  //       onPressed: () {},
  //       child: const Text("Proceed"),
  //     )
  //   ],
  // ),
  // Column(
  //   children: [
  //     Container(
  //       height: 200,
  //       width: 200,
  //       color: Colors.green[50],
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: const [
  //           Text("firefighter"),
  //         ],
  //       ),
  //     ),
  //     TextButton(
  //       onPressed: () {},
  //       child: const Text("Proceed"),
  //     )
  //   ],
  // ),
  // Column(
  //   children: [
  //     Container(
  //       height: 200,
  //       width: 200,
  //       color: Colors.green[50],
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: const [
  //           Text("Police"),
  //         ],
  //       ),
  //     ),
  //     TextButton(
  //       onPressed: () {},
  //       child: const Text("Proceed"),
  //     )
  //   ],
  // ),
  //     ],
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Emergency"),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'update details',
            onPressed: () {
              if (kDebugMode) {
                print('person update tapped');
                Navigator.pushReplacementNamed(context, UserProfile.routeName);
              }
              // Navigator.of(context)
              //     .pushReplacementNamed(UpdateProfile.routeName);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _tabs[_currentIndex],

      //////////////////////////NAVIGATION////////////////////////////
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 13.0,
        unselectedFontSize: 10.0,
        backgroundColor: Colors.grey[100],
        selectedItemColor: Colors.green,
        elevation: 0.0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
              label: 'Ambulance',
              icon: Icon(
                Icons.car_repair,
                size: 20,
                color: Colors.green,
              )),
          const BottomNavigationBarItem(
              label: 'fighters',
              icon: Icon(
                Icons.local_fire_department,
                size: 20,
                color: Colors.orange,
              )),
          BottomNavigationBarItem(
            label: 'Police',
            icon: Icon(
              Icons.local_police,
              size: 20,
              color: Colors.blue[400],
            ),
          ),
        ],

        ///////////////////NAVIGATION ON-TAP//////////////////////
        onTap: ((int index) {
          setState(() {
            _currentIndex = index;
          });
        }),
      ),
    );
  }
}
