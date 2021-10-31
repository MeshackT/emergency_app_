import 'package:afpemergencyapplication/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireFighterScreen extends StatefulWidget {
  const FireFighterScreen({Key? key}) : super(key: key);
  static const routeName = '/firefighterScreen';

  @override
  _FireFighterScreenState createState() => _FireFighterScreenState();
}

class _FireFighterScreenState extends State<FireFighterScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();

  bool showProgressBar = false;
  bool progressBar = false;

  String uid = "";
  String email = "";
  String phoneNumber = "";
  String fullName = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Center(
                child: Text(
                  "Details",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 2.0,
                  // color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Center(
                            child: Text(
                              "$userModel",
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return const Text("Loading data, please wait...");
                        }
                      },
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 60,
                  right: 60,
                ),
                child: Divider(
                  height: 10.0,
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Request",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orangeAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                        // side: const BorderSide(color: Colors.purple),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _fetch() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((value) {
        userModel = UserModel.fromMap(value.data());
      });
    }
  }
}
