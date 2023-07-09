import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizz_brain.dart';

QuizzBrain quizzBrain = QuizzBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: QuizzApp(),
      ),
    );
  }
}

class QuizzApp extends StatefulWidget {
  const QuizzApp({super.key});

  @override
  State<QuizzApp> createState() => _QuizzAppState();
}

class _QuizzAppState extends State<QuizzApp> {
  List<Icon> scorekeeper = [];
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizzBrain.getCorrectAnswer();

    setState(() {
      if (quizzBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizzBrain.reset();

        scorekeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scorekeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scorekeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }

        quizzBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizzBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              color: Colors.green,
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              color: Colors.red,
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}
