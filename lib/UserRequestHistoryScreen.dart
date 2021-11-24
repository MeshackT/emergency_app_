import 'package:afpemergencyapplication/MainSreens/HomeScreen.dart';
import 'package:flutter/material.dart';

class UserRequestHistoryScreen extends StatefulWidget {
  const UserRequestHistoryScreen({Key? key}) : super(key: key);
  static const routeName = '/userRequestHistoryScreen';

  @override
  _UserRequestHistoryScreenState createState() =>
      _UserRequestHistoryScreenState();
}

class _UserRequestHistoryScreenState extends State<UserRequestHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pushReplacementNamed(context, EmergencyType.routeName);
          },
        ),
        backgroundColor: Colors.green,
        title: const Text('History of requests'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.white70,
                child: Text("Meshack"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
