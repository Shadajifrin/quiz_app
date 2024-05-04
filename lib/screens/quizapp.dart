import 'package:flutter/material.dart';
import 'package:quiz_app/model/queAns.dart';
import 'package:quiz_app/utils/colrs.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 24, 75),
      body: PageView.builder(
        controller: controller,
        itemCount: queAns.length,
        itemBuilder: (context, index) {
          return buildQuizPage(index);
        },
      ),
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
            Center(
              child: Text(
                queAns[index]['question'],
                style: TextStyle(
                  color: MyColors.textColors,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(queAns[index]['options'].length, (optionIndex) {
                String option = queAns[index]['options'][optionIndex];

                return GestureDetector(
                  onTap: () {
                    setState(() {
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
                      border: Border.all(color: MyColors.textColors),
                    ),
                    child: Center(
                      child: Text(
                        option,
                        style: TextStyle(
                          color: _getOptionTextColor(option, index),
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                if (index < queAns.length - 1) {
                  controller.nextPage(
                    duration: Duration(seconds: 1),
                    curve: Curves.ease,
                  );
                } else {
                  showResult();
                }
              },
              child: Text(index < queAns.length - 1 ? "Next" : "Submit", style: TextStyle(fontSize: 18),),
              textColor: MyColors.basicColor,
              color: MyColors.textColors,
              height: 65,
              minWidth: 140,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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

  void showResult() {
    int totalQuestions = queAns.length;
    int correctAnswers = 0;

    // Calculate the number of correct answers
    for (int i = 0; i < totalQuestions; i++) {
      if (userAns[i] == queAns[i]['correctanswer']) {
        correctAnswers++;
      }
    }

    // Calculate the percentage score
    double percentageScore = (correctAnswers / totalQuestions) * 100;

    // Define the text color for the total questions and correct answers
    Color totalQuestionsColor = Colors.red;
    Color correctAnswersColor = Colors.green;

    // Navigate to the result page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          totalQuestions: totalQuestions,
          correctAnswers: correctAnswers,
          percentageScore: percentageScore,
          totalQuestionsColor: totalQuestionsColor,
          correctAnswersColor: correctAnswersColor,
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final double percentageScore;
  final Color totalQuestionsColor;
  final Color correctAnswersColor;

  ResultPage({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.percentageScore,
    required this.totalQuestionsColor,
    required this.correctAnswersColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 24, 75), // Deep purple background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
            AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/congrats 1.jpg',
                    height: 100,
                    width: 208,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${percentageScore.toStringAsFixed(2)}% Score',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Quiz Completed Successfully!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You attempted $totalQuestions Questions.',
                    style: TextStyle(fontSize: 18, color: totalQuestionsColor),
                  ),
                  Text(
                    '$correctAnswers answers are correct.',
                    style: TextStyle(fontSize: 18, color: correctAnswersColor),
                  ),
                ],
              ),
            ),
          
        
      SizedBox(height: 15,),
    MaterialButton(
              onPressed: () {
                if (percentageScore < 50) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Close the result page and go back to the quiz
                } else {
                  Navigator.of(context).pop(); // Close the result page
                }
              },
              child: Text(percentageScore < 50 ? 'Try Again' : 'Back',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
             
              height: 75,
              minWidth: 180,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: percentageScore < 50 ? Colors.red : Colors.green,
              textColor: Colors.white,
            ),
        ],
      ),
    );
  }
}
