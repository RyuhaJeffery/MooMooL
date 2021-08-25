import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  // final String currentUserId;
  const HomeScreen({
    Key? key,
  }) : super(key: key);
//required this.currentUserId
  @override
  _HomeScreenState createState() => _HomeScreenState();
  //currentUserId: currentUserId
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState({Key? key});
  // required this.currentUserId
  //final currentUserId;
  String? _token;

  bool isSent = false;

  late FirebaseMessaging messaging;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      _token = value;
      print("token: $_token");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold();
  }
}
