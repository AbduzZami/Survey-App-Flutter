import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/adminlogin.dart';
import 'package:survey_app/regact.dart';
import 'package:survey_app/surveyques.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email='';
  String _password='';
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
                  image: AssetImage('assets/bc1.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Stack(
                children: const <Widget>[
                  Positioned(
                    left: 30.0,
                    bottom: 30.0,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 28.0,
                        letterSpacing: 1.5,
                        color: Colors.white
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
                      prefixIcon: Icon(Icons.email, color: Colors.black, ),
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
                            ).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SurveyQues()));
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    child: const Text(
                      "Don't have an account? Register now."
                      ,style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Regi()));
                    }
                  ),
                  const SizedBox(height: 30.0,),
                  GestureDetector(
                    child: 
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.person, color: Colors.black)
                              ,Text(
                            'Admin login'
                            ,style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                            ],
                          ),
                        ),
                      
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>  const AdminLogin()));
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