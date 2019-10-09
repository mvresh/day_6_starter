import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:day_5_starter/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
void main() {
  runApp(Quizlr());
}

class Quizlr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
          ),
        ));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int scoreCounter = 0;

  QuizBrain brain = QuizBrain();

  void checkAnswer(bool userAnswer) {
    setState(() {
      print(brain.currentQuestionNumber());
      if (brain.currentQuestionNumber() == brain.questions.length-1){
        Alert(
          context: context,
          type: AlertType.error,
          title: "Quiz Completed",
          desc: "You have reached the end of the quiz and scored ${scoreCounter} out of ${brain.questions.length}",
          buttons: [
            DialogButton(
              child: Text(
                "RESTART",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: (){
                setState(() {
                  Navigator.pop(context);
                  scoreCounter = 0;
                  brain.resetQuestionNumber();
                  scoreKeeper = [];
                });
              },
              width: 120,
            )
          ],
        ).show();
      }

      if (brain.correctAnswer(userAnswer)) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        scoreCounter++;
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      if(brain.currentQuestionNumber() < brain.questions.length-1){
        brain.nextQuestion();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                brain.getCurrentQuestion().ques,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

// Sample Questions and Answers
// Q.1 Amartya Sen was awarded the Nobel prize for his contribution to Welfare Economics., true
// Q.2 The Headquarters of the Southern Naval Command of the India Navy is located at Thiruvananthapuram., false
// Q.3 There are 4 sessions of the Parliament each year: Spring, Summer, Autumn and Winter., false