import 'package:crickinfo/firebase/firebackend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController econtroller = TextEditingController();
Future<void> Forgot(String email) async {
  print("EMAIL: $email");

  if (email.trim().isEmpty) {
    uiheler.alertbox("Enter email", context);
    return;
  }

  try {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email.trim());
    uiheler.alertbox("Check your email", context);
    econtroller.clear();

  } on FirebaseAuthException catch (e) {
    uiheler.alertbox(e.message ?? "Error", context);
  }
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('ForgotPassword'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 30),
              uiheler.customfield(
                'Enter your email',
                Icons.email,
                econtroller,
                false,
              ),
              SizedBox(height: 30),
              uiheler.button(
                () => Forgot(econtroller.text.toString()),
                'Reset password ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
