import 'package:afpemergencyapplication/LogIn.dart';
import 'package:afpemergencyapplication/UserProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'models/UserModel.dart';

class UpdateProfile extends StatefulWidget {
  static const routeName = '/updateProfile';
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  UserModel userModel = UserModel();

  bool showProgressBar = false;
  bool progressBar = false;

  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;

  String uid = "";
  final TextEditingController email = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetch(context);

    setState(() {
      user = _auth.currentUser;
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userModel.uid)
            .get()
            .then((value) => userModel = UserModel.fromMap(value.data()));
      }
      if (kDebugMode) {
        print(userModel.email);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pushReplacementNamed(context, UserProfile.routeName);
          },
        ),
        backgroundColor: Colors.green,
        title: const Text('Profile'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),

                  Container(
                    height: 70,
                    margin: const EdgeInsets.only(
                      bottom: 7,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.my_location,
                        size: 70,
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
                        "Details Update",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    shadowColor: Colors.green,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Form(
                        key: _formKey,
                        child: Expanded(
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 20),
                                child: TextFormField(
                                  controller: email,
                                  onSaved: (value) {
                                    setState(() {
                                      email.text = value!;
                                      // if (kDebugMode) {
                                      //   print("email: $_email");
                                      // }
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Enter email");
                                    }
                                    if (!RegExp(
                                            "^[a-zA-Z0-9+_.-]+.[a-zA-Z0-9>-]+.[a-z]")
                                        .hasMatch(value)) {
                                      return ("Please Enter a valid email");
                                    }
                                    return null;
                                  },
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.purple),
                                  decoration: const InputDecoration(
                                    label: Text('Email'),
                                    hintText: 'email',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: TextFormField(
                                  // obscureText: true,
                                  controller: fullName,
                                  onSaved: (value) {
                                    //Do something with the user input.
                                    setState(() {
                                      fullName.text = value!;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.purple),
                                  decoration: const InputDecoration(
                                    label: Text('Full Names'),
                                    hintText: 'Full Names',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: TextFormField(
                                  // controller: phoneNumber,
                                  onSaved: (value) {
                                    setState(() {
                                      phoneNumber.text = value!;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("10 digit number required");
                                    }
                                    if (value.length < 10 &&
                                        value.length > 10) {
                                      return ("Enter a valid phone number with 10 digits");
                                    }
                                  },
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.purple),
                                  decoration: const InputDecoration(
                                    label: Text('Phone Number'),
                                    hintText: 'Phone Number.',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: TextFormField(
                                  // obscureText: true,
                                  controller: address,
                                  onSaved: (value) {
                                    //Do something with the user input.
                                    setState(() {
                                      address.text = value!;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.purple),
                                  decoration: const InputDecoration(
                                      label: Text('Address'),
                                      hintText: 'Address',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      icon: IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.my_location,
                                            size: 30.0,
                                            color: Colors.green,
                                          ))),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //////////////buttons///////////////

                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(15)),
                          // foregroundColor:
                          //     MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                      side: const BorderSide(
                                          color: Colors.green)))),
                      onPressed: () {
                        _uploadUserData();
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const Divider(
                    height: 4.0,
                    color: Colors.grey,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                      alignment: Alignment.bottomCenter,
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
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LogIn()));
    setState(() {});
  }

  Future<void> _fetch(BuildContext context) async {
    user = _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .get()
          .then((value) => userModel = UserModel.fromMap(value.data()));
    }
  }

  Future<void> _uploadUserData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    try {
      //writing to firebase
      //adding the details to the constructor
      await firebaseFirestore
          .collection("users")
          .doc(user?.uid)
          .update(userModel.toMap()); //writing to firebase
      //adding the details to the constructor
      userModel.uid = user?.uid;
      userModel.email = email.text;
      userModel.fullName = fullName.text;
      userModel.phoneNumber = phoneNumber.text;
      userModel.address = address.text;
    } catch (e) {
      setState(() {
        progressBar = false;
      });
      Fluttertoast.showToast(
          msg: '$e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16);
    }
  }
}
