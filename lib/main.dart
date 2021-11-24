import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int queNum = 1;
  int correct = 0;
  int incorrect = 0;
  int score = 0;
  bool flag = true;
//list of checked ans
  List<Icon> scoreKeeper = [Icon(Icons.circle, color: Colors.blue)];

//all questions and answer
  List<Question> questionBank = [
    Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
    Question(
        q: 'Approximately one quarter of human bones are in the feet.',
        a: true),
    Question(q: 'A slug\'s blood is green.', a: true),
    Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
    Question(
        q: 'Approximately one quarter of human bones are in the feet.',
        a: true),
    Question(q: 'A slug\'s blood is green.', a: true),
  ];
//check if users ans is correct and add an icon element to scorekeeprs list
  void checkAns(userAns) {
    if (flag) {
      scoreKeeper.remove(scoreKeeper[queNum - 1]);
      if (questionBank[queNum - 1].questionAnswer == userAns) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        correct++;
        flag = false;
      } else if (questionBank[queNum - 1].questionAnswer != userAns) {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
        incorrect++;
        flag = false;
      }
      score = correct - incorrect;
    }
    if (queNum <= questionBank.length - 1) {
      queNum++;
      flag = true;
      scoreKeeper.add(
        Icon(
          Icons.circle,
          color: Colors.blue,
        ),
      );
    } else {
      Alert(
          context: context,
          title: "YOU DID IT !!",
          content: Column(
            children: <Widget>[
              Text(
                'Total correct : $correct',
                style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total incorrect : $incorrect',
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total score : $score',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  scoreKeeper.clear();
                  scoreKeeper.add(
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                    ),
                  );
                  queNum = 1;
                  correct = 0;
                  incorrect = 0;
                  score = 0;
                  flag = true;
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Restart Test",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ]).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          color: Color(0xFFfffcf2),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: scoreKeeper,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Que.$queNum',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Score : $score',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank[queNum - 1].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () {
                setState(() {
                  checkAns(true);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  checkAns(false);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
