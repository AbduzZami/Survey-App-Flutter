import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/main.dart';
import 'package:survey_app/resultview.dart';
import 'package:survey_app/surveyques.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({ Key? key }) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String _email='';
  String _password='';
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String _uid,String _email,String _password) {
    return users
      .doc(_uid)
      .set({
        'email': _email,
        'password': _password,
        'user_type': 'consumer'
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
  }
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.55,
              decoration: const BoxDecoration(
                image:  DecorationImage(
                  image: AssetImage('assets/bc2.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Stack(
                children: const <Widget>[
                  Positioned(
                    left: 30.0,
                    bottom: 30.0,
                    child: Text(
                      'Admin\nLogin',
                        style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 28.0,
                        letterSpacing: 1.5,
                        color: Colors.black
                        ),
                    )
                  )
                ],),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                   TextField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.black, )
                    ),
                    onChanged: (text){
                      setState(() {
                        _email=text.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 20.0,),
                   TextField(
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.black, ),
                      ),
                      obscureText: true,
                      onChanged: (text){
                      setState(() {
                        _password=text.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[Color(0xFF141314),Color(0xFF3B3841)]),
                          borderRadius: BorderRadius.circular(50.0)
                          ),
                          child: const Center(child: 
                          Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18.0),
                            ),
                          )
                    ),
                    onTap: () async {
                      try {
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: _email,
                              password: _password
                            ).then((value) async {
                              DocumentSnapshot documentSnapshot = 
                              await FirebaseFirestore.instance.collection('users').doc(value.user!.uid.toString()).get();
                               if(documentSnapshot['user_type'] == "admin"){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ResView()));
                              }
                            
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                      // auth.createUserWithEmailAndPassword(email: _email, password: _password);
                      
                    }
                  ),
                  const SizedBox(height: 20.0,),
                  GestureDetector(
                    child: const Text(
                      "Not an admin?."
                      ,style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                    }
                  ),
                ],
              ),
            )
          ],
        ),) 
    );
  }
}