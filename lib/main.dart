import 'dart:async';

import 'package:afpemergencyapplication/EditRequests/EditFireFighterRequest.dart';
import 'package:afpemergencyapplication/EditRequests/EditPoliceRequest.dart';
import 'package:afpemergencyapplication/EditRequests/EditRequest.dart';
import 'package:afpemergencyapplication/LoginAndRegisterScreens/LogIn.dart';
import 'package:afpemergencyapplication/LoginAndRegisterScreens/PasswordReset.dart';
import 'package:afpemergencyapplication/LoginAndRegisterScreens/UserProfile.dart';
import 'package:afpemergencyapplication/LoginAndRegisterScreens/UserRegister.dart';
import 'package:afpemergencyapplication/LoginAndRegisterScreens/updateProfile.dart';
import 'package:afpemergencyapplication/MainSreens/AmbulanceScreen.dart';
import 'package:afpemergencyapplication/MainSreens/FireFighterScreen.dart';
import 'package:afpemergencyapplication/MainSreens/HomeScreen.dart';
import 'package:afpemergencyapplication/MainSreens/PoliceScreen.dart';
import 'package:afpemergencyapplication/MainSreens/ThreeButtonsScreens.dart';
import 'package:afpemergencyapplication/RequestAndHistory/FireFighterRequest.dart';
import 'package:afpemergencyapplication/RequestAndHistory/MainAlertTypeScreen.dart';
import 'package:afpemergencyapplication/RequestAndHistory/MyHistory.dart';
import 'package:afpemergencyapplication/RequestAndHistory/MyRequest.dart';
import 'package:afpemergencyapplication/RequestAndHistory/PoliceRequest.dart';
import 'package:afpemergencyapplication/UserRequestHistoryScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool loaded = false;

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
      EmergencyType.routeName: (ctx) => EmergencyType(),
      ////update profile
      UpdateProfile.routeName: (ctx) => const UpdateProfile(),
      UserProfile.routeName: (ctx) => const UserProfile(),
      ////Navigation screens
      AmbulanceScreen.routeName: (ctx) => const AmbulanceScreen(),
      FireFighterScreen.routeName: (ctx) => const FireFighterScreen(),
      PoliceScreen.routeName: (ctx) => const PoliceScreen(),
      ThreeButtonsScreen.routeName: (ctx) => const ThreeButtonsScreen(),
      ////splashScreen
      SplashScreen.routeName: (ctx) => const SplashScreen(),
      ////reset password
      PasswordReset.routeName: (ctx) => const PasswordReset(),
      ////list of requests made
      UserRequestHistoryScreen.routeName: (ctx) =>
          const UserRequestHistoryScreen(),
      ////my request screen
      MyHistory.routeName: (ctx) => MyHistory(),
      //edit your Requests
      EditRequest.routeName: (ctx) => const EditRequest(),
      EditPoliceRequest.route: (ctx) => const EditPoliceRequest(),
      EditFireFighterRequest.routeName: (ctx) => const EditFireFighterRequest(),
      // EditPoliceRequest.routename: (ctx) => const EditPoliceRequest(),
      //my alert button screens
      MyRequest.routeName: (ctx) => const MyRequest(),
      MainAlertTypeScreen.routeName: (ctx) => const MainAlertTypeScreen(),
      FireFighterRequest.routeName: (ctx) => const FireFighterRequest(),
      PoliceRequest.routeName: (ctx) => const PoliceRequest(),
    },

    /// check if user is signed (Open Chat page ) if user is not signed in (open welcome page)
    initialRoute: FirebaseAuth.instance.currentUser != null
        ? EmergencyType.routeName
        : SplashScreen.routeName,
    home: const SplashScreen(),
    // home: const LogIn(),
    // home: UserRegister(),
    // home: const EmergencyType(),
    // home: UserProfile(),
    // home: ThreeButtonsScreen(),
    // home: AmbulanceScreen(),

    theme: ThemeData(
      primaryColor: Colors.green,
      primaryColorDark: Colors.purple[700],
      fontFamily: 'GaramondBold',
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

    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out! then go to splash screen');
        }
        Timer(const Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, LogIn.routeName, (route) => false);
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => const LogIn()));
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (_) => const LogIn()));
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
