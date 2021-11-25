import 'package:afpemergencyapplication/RequestAndHistory/MainAlertTypeScreen.dart';
import 'package:afpemergencyapplication/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FireFighterRequest extends StatefulWidget {
  const FireFighterRequest({Key? key}) : super(key: key);
  static const routeName = '/fireRequestScreen';

  @override
  _FireFighterRequestState createState() => _FireFighterRequestState();
}

class _FireFighterRequestState extends State<FireFighterRequest> {
  Logger logger = Logger();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  UserModel userModel = UserModel();
  List requestList = [];
  String uid = "";

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> fireRequestStream = FirebaseFirestore.instance
        .collection("fire-fighter-request")
        .where('owner', isEqualTo: user!.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainAlertTypeScreen(),
              ),
            );
          },
        ),
        title: const Text("My Request"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireRequestStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //TO DO
          if (snapshot.hasError) {
            return Center(
              child: Stack(
                children: const [
                  Text('Something went wrong'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Stack(
                children: const [
                  Text('Loading information'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return InkWell(
                onTap: () {},
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          data['fullName'],
                          style: const TextStyle(color: Colors.green),
                        ),
                        subtitle: ExpansionTile(
                          title: const Text(
                            "More",
                            style: TextStyle(fontSize: 14, color: Colors.red),
                          ),
                          children: [
                            const Text(
                              "EM Type: ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              data['emergencyTypeRequest'],
                              style: const TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                            const Text("Phone Number"),
                            Text(
                              data["phoneNumber"],
                              style: const TextStyle(
                                letterSpacing: 3,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   data['emergencyTypeRequest'],
                        //   style: const TextStyle(color: Colors.red),
                        // ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(
                            data['fullName'][0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        trailing: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height + 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Address",
                                style: TextStyle(color: Colors.green),
                              ),
                              Text(
                                data['address'],
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.grey,
                              ),
                              onPressed: () async {
                                final CollectionReference requestCollection =
                                    FirebaseFirestore.instance
                                        .collection('fire-fighter-request');
                                requestCollection.doc(uid).delete();
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
