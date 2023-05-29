import "package:flutter/material.dart";
import 'package:roll_dice/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_dice/result.dart';

class Quizzes extends StatelessWidget {
  const Quizzes(this.answers, {super.key} );

  final List<String> answers;

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
          child: QForm(answers),
        ),
      ),
    );
  }
}


class QForm extends StatefulWidget {
  const QForm(this.answers, {super.key});
  final List<String> answers;

  @override
  State<QForm> createState() {
    return _QForm();
  }
}

class _QForm extends State<QForm> {
  var currentQuestionIndex = 0;
  var currentQuestion = questions[0];
  void answerQuestion(String selectAnswer){
    widget.answers.add(selectAnswer);
    currentQuestionIndex++;
    setState(() {
      currentQuestion = questions[currentQuestionIndex];
    });
  }

  void check(){
    if (widget.answers.length >= questions.length - 1){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(answers: widget.answers)),
      );
      //Navigator.pop(context);
    }
  }

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentQuestion.text,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 40),
          ...currentQuestion.getShuffledAnswers().map((item) {
            return AnswerButton(
                answer: item,
                onTap: (){answerQuestion(item);check();
                }
            );
          }),
        ],
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton({required this.answer,required this.onTap, super.key});
  final String answer;
  final void Function() onTap;

  @override
  Widget build(context){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
          child: Text(answer,textAlign: TextAlign.center),
      ),
    );
  }
}