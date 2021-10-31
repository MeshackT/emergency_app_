import 'dart:async';

import 'package:afpemergencyapplication/AmbulanceScreen.dart';
import 'package:afpemergencyapplication/CallForHelp.dart';
import 'package:afpemergencyapplication/FireFighterScreen.dart';
import 'package:afpemergencyapplication/HomeScreen.dart';
import 'package:afpemergencyapplication/LogIn.dart';
import 'package:afpemergencyapplication/PoliceScreen.dart';
import 'package:afpemergencyapplication/ThreeButtonsScreens.dart';
import 'package:afpemergencyapplication/UserProfile.dart';
import 'package:afpemergencyapplication/UserRegister.dart';
import 'package:afpemergencyapplication/updateProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    routes: {
      ////user login and register
      LogIn.routeName: (ctx) => const LogIn(),
      UserRegister.routeName: (ctx) => const UserRegister(),
      ////
      EmergencyType.routeName: (ctx) => const EmergencyType(),
      ////update profile
      UpdateProfile.routeName: (ctx) => const UpdateProfile(),
      UserProfile.routeName: (ctx) => const UserProfile(),
      ////Navigation screens
      AmbulanceScreen.routeName: (ctx) => const AmbulanceScreen(),
      FireFighterScreen.routeName: (ctx) => const FireFighterScreen(),
      PoliceScreen.routeName: (ctx) => const PoliceScreen(),
      ThreeButtonsScreen.routeName: (ctx) => const ThreeButtonsScreen(),
      CallForHelp.routeName: (ctx) => const CallForHelp(),
      SplashScreen.routeName: (ctx) => const SplashScreen(),
    },

    /// check if user is signed (Open Chat page ) if user is not signed in (open welcome page)
    initialRoute: FirebaseAuth.instance.currentUser != null
        ? EmergencyType.routeName
        : SplashScreen.routeName,
    home: const SplashScreen(),
    // home: const SplashScreen(),
    // home: LogIn(),
    // home: UserRegister(),
    // home: const EmergencyType(),
    // home: UserProfile(),
    // home: ThreeButtonsScreen(),
    // home: AmbulanceScreen(),

    theme: ThemeData(
      primaryColor: Colors.green,
      primaryColorDark: Colors.purple[700],
      appBarTheme: const AppBarTheme(color: Colors.white),
    ),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    // late StreamSubscription<User?> user;

    // Timer(const Duration(seconds: 3), () {
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (_) => const LogIn()));
    // });
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out! then go to splash screen');
        }
        Timer(const Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LogIn()));
        });
      } else {
        if (kDebugMode) {
          print('User is signed in!');
        }
      }
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
