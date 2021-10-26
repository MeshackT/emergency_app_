import 'dart:async';

import 'package:afpemergencyapplication/HomeScreen.dart';
import 'package:afpemergencyapplication/LogIn.dart';
import 'package:afpemergencyapplication/UserRegister.dart';
import 'package:afpemergencyapplication/updateProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var status = preferences.getBool('isLoggedIn') ?? false;

  if (kDebugMode) {
    print(status);
  }

  runApp(MaterialApp(
    // home: EmergencyType(),
    debugShowCheckedModeBanner: false,
    // home: const SplashScreen(),
    // home: LogIn(),
    // home: UserRegister(),
    home: EmergencyType(),
    routes: {
      LogIn.routeName: (ctx) => const LogIn(),
      UserRegister.routeName: (ctx) => const UserRegister(),
      UpdateProfile.routeName: (ctx) => const UpdateProfile(),
      EmergencyType.routeName: (ctx) => const EmergencyType(),
    },

    theme: ThemeData(
      primaryColor: Colors.green,
      primaryColorDark: Colors.purple[700],
      appBarTheme: const AppBarTheme(color: Colors.white),
    ),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const LogIn()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Expanded(
          child: Image.asset(
            'images/splashscreenicon.png',
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ),
    );
  }
}
