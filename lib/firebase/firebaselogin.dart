// ignore_for_file: unused_local_variable

import 'package:crickinfo/firebase/SignU.dart';
import 'package:crickinfo/firebase/firebackend.dart';
import 'package:crickinfo/firebase/forgotass.dart';
import 'package:crickinfo/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Criclogin extends StatefulWidget {
  const Criclogin({super.key});
  //
  @override
  State<Criclogin> createState() => _CricloginState();
}

class _CricloginState extends State<Criclogin> {
  @override
  void initState(){
    super.initState();
   
  }
  
  TextEditingController econtroller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();

  signin(String email, String pass) async {
    if (email == '' || pass == '') {
      return uiheler.alertbox("Enter required fields", context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass)
            .then(
              (value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ),
            );
      } on FirebaseAuthException catch (e) {
        return uiheler.alertbox(e.code.toString(), context);
        econtroller.clear();
        pcontroller.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Cricket[A]pp', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/saia.png'),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
                pcontroller,
                true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan
                ),
                onPressed: () => signin(
                  econtroller.text.toString(),
                  pcontroller.text.toString(),
                ),child: Text('Login')),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?'),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    ),
                    child: Text('Signup'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Forgot()),
                ),
                child: Text(
                  'Forgot Password ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
