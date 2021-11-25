import 'package:afpemergencyapplication/MainSreens/HomeScreen.dart';
import 'package:afpemergencyapplication/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyRequest extends StatefulWidget {
  MyRequest({Key? key}) : super(key: key);
  static const routeName = '/myRequestScreen';
  @override
  _MyRequestState createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  Logger logger = Logger();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  UserModel userModel = UserModel();
  List requestList = [];
  String uid = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> ambulanceRequestStream = FirebaseFirestore.instance
        .collection("ambulance-requests")
        .where('owner', isEqualTo: user!.uid)
        .snapshots();
    Stream<QuerySnapshot> fireRequestStream = FirebaseFirestore.instance
        .collection("fire-fighter-request")
        .where('owner', isEqualTo: user!.uid)
        .snapshots();
    Stream<QuerySnapshot> policeRequestStream = FirebaseFirestore.instance
        .collection("police-requests")
        .where('owner', isEqualTo: user!.uid)
        .snapshots();

    List<dynamic> listStreams = [];
    listStreams.add(ambulanceRequestStream);
    listStreams.add(fireRequestStream);
    logger.i(listStreams.toList());

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
        stream: ambulanceRequestStream,
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
      /*Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: policeRequestStream,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                  style:
                                      TextStyle(fontSize: 14, color: Colors.red),
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
            ),*/
      ////////////////////////////////////////////////////
      //               police done                   //
      ////////////////////////////////////////////////////
      /*StreamBuilder<QuerySnapshot>(
              stream: fireRequestStream,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                  style:
                                      TextStyle(fontSize: 14, color: Colors.red),
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
            ////////////////////////////////////////////////////
            //                   fire done                    //
            ////////////////////////////////////////////////////

            StreamBuilder<QuerySnapshot>(
              stream: ambulanceRequestStream,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                  style:
                                      TextStyle(fontSize: 14, color: Colors.red),
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
            ),*/

      /////////////////////////////////////////////////////////////
      // StreamBuilder<QuerySnapshot>(
      //   stream: ambulanceRequestStream,
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     return StreamBuilder<QuerySnapshot>(
      //       stream: fireRequestStream,
      //       builder:
      //           (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //
      //         return StreamBuilder<QuerySnapshot>(
      //              stream: fireRequestStream,
      //              builder:
      //                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //
      //                return
      //       },
      //     );
      //   },
      //     // ),
      //   ],
      // ),
    );
  }
}
