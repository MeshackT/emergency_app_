import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomeScreen.dart';
import 'UserRegister.dart';

class LogIn extends StatefulWidget {
  static const routeName = '/login';

  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool progressBar = false;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
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
                        margin: const EdgeInsets.only(bottom: 20),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.my_location,
                            size: 80,
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
                        child: const Center(child: Text("LogIn")),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 20),
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
                            hintText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: TextFormField(
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
                          obscureText: true,
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.purple),
                          decoration: const InputDecoration(
                            hintText: 'Enter Password.',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
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
                            signIn(email.text.toLowerCase().trim(),
                                password.text.trim());
                            if (kDebugMode) {
                              print(email);
                              print(password);
                            }
                          },
                          child: const Text(
                            "LogIn",
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
                            print('register clicked');
                          }
                          Navigator.of(context)
                              .pushReplacementNamed(UserRegister.routeName);
                        },
                        child: const Text(
                          "Register",
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
                      TextButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('Login clicked');
                          }
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
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
    );
  }

  Future<User?> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Success"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const EmergencyType()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: "Failed to login!" + e!.message);
      });
    } else {
      return _auth.currentUser;
    }
  }
}
