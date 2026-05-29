// ignore_for_file: unused_local_variable

import 'package:crickinfo/firebase/reusableWidgets.dart';
import 'package:crickinfo/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController econtroller = TextEditingController();
  TextEditingController controller = TextEditingController();
 
  Signup(String email, String pass) async {
    if (email == '' || pass == '') {
      return uiheler.alertbox("Enter required fields", context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass)
            .then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ),
            );
      } on FirebaseAuthException catch (e) {
        return uiheler.alertbox(e.code.toString(), context);
        econtroller.clear();
        controller.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            return Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Cricket[A]pp'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/roc.jpg'),
                height: 100,
                width: 100,
              ),
              SizedBox(height: 20),
              Text(
                'SignUp',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              uiheler.customfield(
                'Enter your email',
                Icons.email,
                econtroller,
                false,
              ),
              SizedBox(height: 20),
              uiheler.customfield(
                'Enter your password',
                Icons.password,
                controller,
                true,
              ),
              SizedBox(height: 20),
              uiheler.button(
                () => Signup(
                  econtroller.text.toString(),
                  controller.text.toString(),
                ),
                'Signup',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
