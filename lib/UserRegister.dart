import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomeScreen.dart';
import 'LogIn.dart';
import 'models/UserModel.dart';

class UserRegister extends StatefulWidget {
  static const routeName = '/registerUser';

  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController firstNames = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                        margin: const EdgeInsets.only(bottom: 5, top: 5),
                        child: const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 20),
                        child: TextFormField(
                          controller: email,
                          onSaved: (value) {
                            setState(() {
                              email.text = value!;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Enter an email");
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
                          obscureText: true,
                          controller: password,
                          onSaved: (value) {
                            setState(() {
                              password.text = value!;
                            });
                          },
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Enter an password");
                            }
                            if (value.length < 5) {
                              return ("Your password is too short!");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("password min of 6 characters");
                            }
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.purple),
                          decoration: const InputDecoration(
                            hintText: 'Password.',
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
                          controller: firstNames,
                          onSaved: (value) {
                            //Do something with the user input.
                            setState(() {
                              firstNames.text = value!;
                            });
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.purple),
                          decoration: const InputDecoration(
                            hintText: 'First Names',
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
                          decoration: const InputDecoration(
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
                          controller: location,
                          onSaved: (value) {
                            //Do something with the user input.
                            setState(() {
                              location.text = value!;
                            });
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.purple),
                          decoration: const InputDecoration(
                            hintText: 'Location',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      //////////////buttons///////////////
                      Container(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontSize: 19))),
                          onPressed: () {
                            registerUsers(email.text.toLowerCase().trim(),
                                password.text.trim());
                            if (kDebugMode) {
                              print(email);
                              print(password);
                              print(phoneNumber);
                            }
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('Login clicked');
                          }
                          Navigator.of(context)
                              .pushReplacementNamed(LogIn.routeName);
                        },
                        child: const Text(
                          "Login",
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
                        padding: const EdgeInsets.only(top: 20),
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
        ),
      ),
    );
  }

  void registerUsers(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: "Failed to login!" + e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    //writing to firebase
    userModel.email = user!.email!;
    userModel.uid = user.uid;
    userModel.phoneNumber = phoneNumber.text;
    userModel.password = password.text;
    userModel.location = location.text;
    userModel.firstNames = firstNames.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "account created successfully");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const EmergencyType()),
        result: (route) => false);
  }
}
