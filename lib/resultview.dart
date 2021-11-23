import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/main.dart';

class ResView extends StatefulWidget {
  const ResView({ Key? key }) : super(key: key);

  @override
  _ResViewState createState() => _ResViewState();
}

class _ResViewState extends State<ResView> {
  final answerRef = FirebaseFirestore.instance.collection('answers');
  double ans1=0;
  double fans1=0,fans1no=0;
  double ans2=0;
  double fans2=0,fans2no=0;
  double ans3=0;
  double fans3=0,fans3no=0;
  double ans4=0;
  double fans4=0,fans4no=0;
  int totalsnap = 0;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _signOut() async {
    await _firebaseAuth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
    });
   }
  Future<void> getAnsPercentage()async {
    answerRef.get().then((QuerySnapshot snapshot){
      for (var element in snapshot.docs) {
        if(element.get('0').toString()=="Yes")
        {
          ans1++;
        }
        if(element.get('1').toString()=="Yes")
        {
          ans2++;
        }
        if(element.get('2').toString()=="Yes")
        {
          ans3++;
        }
        if(element.get('3').toString()=="Yes")
        {
          ans4++;
        }
       }

        setState(() {
          totalsnap = snapshot.size;
          fans1 = ans1/totalsnap*100;
          fans1no = 100-fans1;
          fans2 = ans2/totalsnap*100;
          fans2no = 100-fans2;
          fans3 = ans3/totalsnap*100;
          fans3no = 100-fans3;
          fans4 = ans4/totalsnap*100;
          fans4no = 100-fans4;
        });
        print(fans1.toString());
    });
  }
  @override
  void initState() {
    super.initState();
    getAnsPercentage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child:
       Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40.0,),
            const Padding(padding: EdgeInsets.all(10.0),
            child: Text(
                "Survey Results",
                 style: TextStyle(
                 fontWeight: FontWeight.w800,
                 color: Colors.black,
                 fontSize: 36.0),
                 ),
            ),
            const SizedBox(height: 20.0,),
            Padding(padding: const EdgeInsets.all(10.0),
            child: Text(
                "1st: Binary search is better than Linear search. Do you agree with it?\nYes: "+fans1.toString()+" %\nNo: "+fans1no.toString()+"\n",
                 style: const TextStyle(
                 fontWeight: FontWeight.w500,
                 color: Colors.black,
                 fontSize: 18.0),
                 ),
            ),
            const SizedBox(height: 20.0,),
            Padding(padding: const EdgeInsets.all(10.0),
            child: Text(
                "2nd: Quick sort is better than Heap sort. Do you agree with it?\nYes: "+fans2.toString()+" %\nNo: "+fans2no.toString()+"\n",
                 style: const TextStyle(
                 fontWeight: FontWeight.w500,
                 color: Colors.black,
                 fontSize: 18.0),
                 ),
            ),
            const SizedBox(height: 20.0,),
            Padding(padding: const EdgeInsets.all(10.0),
            child: Text(
                "3rd: Merge sort is better than Raddix sort. Do you agree with it?\nYes: "+fans3.toString()+" %\nNo: "+fans3no.toString()+"\n",
                 style: const TextStyle(
                 fontWeight: FontWeight.w500,
                 color: Colors.black,
                 fontSize: 18.0),
                 ),
            ),
            const SizedBox(height: 20.0,),
            Padding(padding: const EdgeInsets.all(10.0),
            child: Text(
                "4th: Bubble sort is same as Insertion sort. Do you agree with it?\nYes: "+fans4.toString()+" %\nNo: "+fans4no.toString()+"\n",
                 style: const TextStyle(
                 fontWeight: FontWeight.w500,
                 color: Colors.black,
                 fontSize: 18.0),
                 ),
            ),
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
      )
    );
  }
}