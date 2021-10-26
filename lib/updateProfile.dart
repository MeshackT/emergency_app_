import 'package:afpemergencyapplication/HomeScreen.dart';
import 'package:afpemergencyapplication/LogIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'models/UserModel.dart';

class UpdateProfile extends StatefulWidget {
  static const routeName = '/updateProfil';

  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  UserModel loggedInUser = UserModel();

  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController firsNames = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    print(position.latitude);
    print(position.longitude);
    getAddressFromCordinates(
        Coordinates(position.latitude, position.longitude));
  }

  getAddressFromCordinates(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    if (kDebugMode) {
      print("${first.featureName} : ${first.addressLine}");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetch(context);
  }
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) => loggedInUser = UserModel.fromMap(value.data()));
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const EmergencyType()));
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Details",
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 80,
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Icon(
                              Icons.my_location,
                              size: 60,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Divider(
                          height: 8.0,
                          color: Colors.green[100],
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 20),
                          child: const Center(
                              child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: TextFormField(
                            controller: email,
                            onSaved: (value) {
                              setState(() {
                                email.text = value!;
                              });
                            },
                            validator: (value) {
                              // if (value!.isEmpty) {
                              //   return ("Enter an email");
                              // }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+.[a-zA-Z0-9>-]+.[a-z]")
                                  .hasMatch(value!)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.purple),
                            decoration: InputDecoration(
                              hintText: "${loggedInUser.email}",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: TextFormField(
                            controller: firsNames,
                            onSaved: (value) {
                              setState(() {
                                firsNames.text = value!;
                              });
                            },
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.purple),
                            decoration: InputDecoration(
                              hintText: "${loggedInUser.firstNames}",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 20),
                          child: TextFormField(
                            controller: phoneNumber,
                            onSaved: (value) {
                              setState(() {
                                phoneNumber.text = value!;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("10 digit number required");
                              }
                              if (value.length < 10 && value.length > 10) {
                                return ("Enter a valid phone number with 10 digits");
                              }
                            },
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.purple),
                            decoration: InputDecoration(
                              hintText: "${loggedInUser.phoneNumber}",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                            ),
                            // controller: phoneNumber,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            getCurrentLocation();

                            if (kDebugMode) {
                              print("location update click");

                              ///////////////////////////////////////////////
                            }
                          },
                          icon: const Icon(
                            Icons.my_location,
                            size: 29,
                            color: Colors.green,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: location,

                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.purple),
                            decoration: InputDecoration(
                              hintText: "${loggedInUser.location}",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                            ),
                            // controller: location,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        //////////////buttons///////////////

                        TextButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();

                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final User? user = auth.currentUser;

                            setState(() {
                              // progressBar = true;
                            });
                            var uid = user?.uid;
                            await _uploadUserData(
                                uid!,
                                email.text,
                                phoneNumber.text,
                                firsNames.text,
                                location.text);
                            Fluttertoast.showToast(
                                msg: "Your details have been updated.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16);
                          },
                          child: const Text(
                            "Update Details",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            logout(context);
                          },
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Divider(
                            height: 4.0,
                            color: Colors.grey,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "SOCORO",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LogIn()));
    setState(() {});
  }

  Future<void> _uploadUserData(String uid, String email, String phoneNumber,
      firstNames, String location) async {
    user = _auth.currentUser;
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(uid).update({
        'email': email,
        'phoneNumber': phoneNumber,
        'firstNames': firstNames,
        'location': location,
      }).whenComplete(() {
        setState(() {
          // progressBar = false;
        });
      });
    } catch (e) {
      setState(() {
        // progressBar = false;
      });
      Fluttertoast.showToast(
          msg: '$e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16);
    }
  }

  Future<void> _fetch(BuildContext context) async {
    user = _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(loggedInUser.uid)
          .get()
          .then((value) => loggedInUser = UserModel.fromMap(value.data()));
    }
  }
}
