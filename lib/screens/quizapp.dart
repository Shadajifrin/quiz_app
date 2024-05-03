import 'package:flutter/material.dart';
import 'package:quiz_app/model/queAns.dart';
import 'package:quiz_app/utils/colrs.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
   late PageController controller;
  late List<String?> userAns;
  
  @override
  void initState() {
    super.initState();
    controller = PageController();
    userAns = List.filled(queAns.length, null);
  }
  @override
  Widget build(BuildContext context) {
    return  PageView.builder(
      
      controller: controller,
      itemCount: queAns.length,
      itemBuilder: (context, index) {
        return buildQuizPage(index);
      },
    );
  }
  Widget buildQuizPage(int index) {
  return Container(
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 43, 24, 75), // Deep purple background color
    ),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            queAns[index]['question'],
            style: TextStyle(color: MyColors.textColors, fontSize: 20, fontWeight: FontWeight.normal, decoration: TextDecoration.none), // Remove yellow underline
          ),
          SizedBox(height: 20),
          Column(
            children: List.generate(queAns[index]['options'].length, (optionIndex) {
              String option = queAns[index]['options'][optionIndex];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    // Set user's answer to the clicked option
                    userAns[index] = option;
                  });
                },
                child: Container(
                  height: 45,
                  width: 300,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: _getOptionColor(option, index),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: MyColors.textColors), // White border
                  ),
                  child: Center(
                    child: Text(
                      option,
                      style: TextStyle(
                        color: _getOptionTextColor(option, index),
                        fontWeight: FontWeight.normal, // Normal font weight
                        fontSize: 18, // Font size
                        decoration: TextDecoration.none, // Remove underline
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (index < queAns.length - 1) {
                controller.nextPage(
                  duration: Duration(seconds: 1),
                  curve: Curves.ease,
                );
                
              } else {
                showResult();
              }
                ElevatedButton.styleFrom(
              foregroundColor: MyColors.basicColor, backgroundColor: MyColors.textColors, // Text color
              fixedSize: Size(124, 45), // Set width and height
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Border radius
              ),
                );
            },
            child: Text(index < queAns.length - 1 ? "Next" : "Submit"),
          )
        ],
      ),
    ),
  );
}

Color _getOptionColor(String option, int index) {
  if (userAns[index] != null) {
    if (queAns[index]['correctanswer'] == option) {
      return Colors.green;
    } else if (userAns[index] == option) {
      return Colors.red;
    } else {
      return Colors.transparent;
    }
  }
  return Colors.transparent;
}

Color _getOptionTextColor(String option, int index) {
  return Colors.white;
}

  void showResult() {}}