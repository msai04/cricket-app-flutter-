 import 'package:crickinfo/firebase/firebaselogin.dart';
import 'package:crickinfo/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshots) {

        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }  
        if (snapshots.hasData) {
          return HomeScreen(); 
        } else {
          return Criclogin();
        }
      },
    );
  }
}