import 'package:afpemergencyapplication/MainSreens/AmbulanceScreen.dart';
import 'package:afpemergencyapplication/MainSreens/HomeScreen.dart';
import 'package:afpemergencyapplication/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRequest extends StatefulWidget {
  MyRequest({Key? key}) : super(key: key);
  static const routeName = '/myRequestScreen';
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  _MyRequestState createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  UserModel userModel = UserModel();
  AmbulanceScreen ambulanceScreen = AmbulanceScreen();
  List requestList = [];

  @override
  void initState() {
    super.initState();
    fetchListFromDatabase();
  }

  void fetchListFromDatabase() {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('ambulance-requests').snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, EmergencyType.routeName, (route) => false);
          },
        ),
        title: const Text("My Request"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(fontSize: 14.0, color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                backgroundColor: Colors.green,
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
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.call,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.archive_sharp,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.forward_sharp,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.directions,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
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
