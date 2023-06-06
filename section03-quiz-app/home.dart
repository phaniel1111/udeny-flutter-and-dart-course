import "package:flutter/material.dart";
import "package:roll_dice/quiz.dart";
import 'package:roll_dice/data/questions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState(){ return _MyHomePage();}
}

class _MyHomePage extends State<MyHomePage>{
  List<String> selectedAnswers = [];

  void reset(){
    setState(() {
      selectedAnswers = [];
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                  "assets/images/quiz-logo.png",
                  width: 200,
                  color: const Color.fromARGB(150, 255, 255, 255)),
              const SizedBox(height: 40),
              const Text(
                "Learn Flutter the fun way",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 40),
              OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    reset();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Quizzes(selectedAnswers)),
                    );
                  },
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Start")),
            ],
          ),
        ),
      ),
    );
  }
}
