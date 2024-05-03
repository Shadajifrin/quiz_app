import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quizapp.dart';
import 'package:quiz_app/utils/colrs.dart';

class Splash extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor:MyColors.basicColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/quiztime.png"),
          ),
          SizedBox(height: 20), // Adjust spacing between image and button
          SizedBox(
            width: 158,
            height: 53,
            child: MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizApp()));
              },
              color: Colors.purple,
              textColor: MyColors.textColors,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Start',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
