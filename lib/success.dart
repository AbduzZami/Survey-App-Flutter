import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({ Key? key }) : super(key: key);

  @override
  _SuccessViewState createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _signOut() async {
    await _firebaseAuth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
    });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              const Padding(padding: EdgeInsets.all(10.0),
              child: Icon(Icons.done,color: Colors.black,size: 70.0,),),
              const Text(
                      "Successfully submitted"
                      ,style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 40.0,),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shadowColor: Colors.white,
                    ),
                    child: const Text("Sign Out", style: TextStyle(fontSize: 20,color: Colors.white)),
                    onPressed: _signOut,//function
          

          ),
          ],
        ),
      ),
    );
  }
}