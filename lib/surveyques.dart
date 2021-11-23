import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:survey_app/main.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:survey_app/success.dart';

class SurveyQues extends StatefulWidget {
  const SurveyQues({ Key? key }) : super(key: key);

  @override
  _SurveyQuesState createState() => _SurveyQuesState();
}

class _SurveyQuesState extends State<SurveyQues> {
  int _stackIndex = 0;
  final String currentUser = FirebaseAuth.instance.currentUser!.uid;
  int _currentIndex = 0;
  CollectionReference answers = FirebaseFirestore.instance.collection('answers');
  List<String> arr = ['No','No','No','No','No'];
  
  final List<String> data = <String>[
    'Binary search is better than Linear search. Do you agree with it?',
     'Quick sort is better than Heap sort. Do you agree with it?',
      'Merge sort is better than Raddix sort. Do you agree with it?',
       'Bubble sort is same as Insertion sort. Do you agree with it?'
       ];


  String _answer = "No";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200.0,
            ),
            Padding(padding: const EdgeInsets.all(10.0),
            child: Text(
                data[_currentIndex],
                 style: const TextStyle(
                 fontWeight: FontWeight.w500,
                 color: Colors.black,
                 fontSize: 18.0),
                 ),
                 ),
                Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RadioButton(
                  description: "Yes",
                  value: "Yes",
                  groupValue: _answer,
                  onChanged: (value) => setState(
                    () => _answer = value.toString(),
                  ),
                  activeColor: Colors.black,
                ),
                RadioButton(
                  description: "No",
                  value: "No",
                  groupValue: _answer,
                  onChanged: (value) => setState(
                    () => _answer = value.toString(),
                  ),
                  activeColor: Colors.black,
                ),
                
              ],
            ),
            const SizedBox(height: 40.0,
            ),
            ElevatedButton(
            onPressed: () {
              setState(() {
                if(_currentIndex<data.length-1){
                  arr[_currentIndex]=_answer;
                  _currentIndex++;
                  _answer="No";
                }else{
                  //navigator
                  answers
                  .doc(currentUser)
                  .set({
                    '0': arr[0],
                    '1': arr[1],
                    '2': arr[2],
                    '3': arr[3],
                  })
                  .then((value) => print("Answer submitteed"))
                  .catchError((error) => print("Failed to submit: $error"));
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessView()));
                            
                }
              });
            },
            child: const Icon(Icons.navigate_next, color: Colors.white),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              primary: Colors.black, // <-- Button color
              onPrimary: Colors.white, // <-- Splash color
            ),
          )
          ],
        ),
      ),
    );
  }
}