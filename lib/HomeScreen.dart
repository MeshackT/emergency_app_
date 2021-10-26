import 'package:afpemergencyapplication/updateProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'LogIn.dart';
import 'models/UserModel.dart';

class EmergencyType extends StatefulWidget {
  const EmergencyType({Key? key}) : super(key: key);
  static const routeName = '/emergencyHomeScreen';

  @override
  State<EmergencyType> createState() => _EmergencyTypeState();
}

class _EmergencyTypeState extends State<EmergencyType> {
  int _currentIndex = 0;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) => loggedInUser = UserModel.fromMap(value.data()));
    setState(() {});
  }

  final tabs = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: () {
              if (kDebugMode) {
                print('ambulance tapped');
              }
            },
            onLongPress: () {},
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.car_repair,
                size: 80,
                color: Colors.green,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            child: Container(
              height: 150,
              width: 150,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print('Fire fighter tapped');
                  }
                },
                onLongPress: () {},
                child: const Icon(
                  Icons.local_fire_department,
                  size: 80,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        ),
        InkWell(
            onTap: () {
              if (kDebugMode) {
                print('Police tapped');
              }
            },
            onLongPress: () {},
            child: Icon(
              Icons.local_police,
              size: 80,
              color: Colors.blue[400],
            )),
      ],
    ),

    // Card
    Column(children: [
      Container(
          height: 200,
          color: Colors.green[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text("Name"),
              SizedBox(
                height: 8,
              ),
              Text("Phone Number "),
              SizedBox(
                height: 8,
              ),
              Text("Address"),
              SizedBox(
                height: 8,
              ),
              Text("Emergency Type "),
            ],
          )),
      Padding(
        padding: const EdgeInsets.only(left: 80),
        child: Container(
            height: 200,
            color: Colors.green[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text("Meshack"),
                SizedBox(
                  height: 8,
                ),
                Text("00000022022 "),
                SizedBox(
                  height: 8,
                ),
                Text("4401 Asijiki"),
                SizedBox(
                  height: 8,
                ),
                Text("accident"),
              ],
            )),
      ),
      TextButton(
        onPressed: () {},
        child: const Text("Proceed"),
      )
    ]),
    Column(
      children: [
        const Card(
          elevation: 2.0,
          shadowColor: Colors.grey,
          child: Text("Fire Fighter"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Proceed"),
        )
      ],
    ),
    Column(
      children: [
        Container(
          height: 200,
          width: 200,
          color: Colors.green[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Police"),
              Text("Police"),
              Text("Police"),
              Text("Police"),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Proceed"),
        )
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
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
                Navigator.of(context)
                    .pushReplacementNamed(UpdateProfile.routeName);
              }
              // Navigator.of(context)
              //     .pushReplacementNamed(UpdateProfile.routeName);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
              child: Expanded(child: tabs[_currentIndex]))),

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
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LogIn()));
  }

  // Card _card() {
  //   return Card(
  //     child: Container(
  //       height: 100,
  //       width: MediaQuery.of(context).size.width,
  //       child: Column(
  //         children: [
  //           Center(child: const Text('User data')),
  //           Row(
  //             children: [
  //               Text('Name '),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
