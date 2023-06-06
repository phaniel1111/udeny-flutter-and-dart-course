import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
//import 'package:roll_dice/models/question_model.dart';
import 'package:roll_dice/data/questions.dart';

class ResultScreen extends StatelessWidget{
  const ResultScreen({required this.answers, super.key} );
  final List<String> answers;

  List<Map<String,Object>> getSummaryData(){
    final List<Map<String,Object>> summary =[];

    for(var i = 0; i < answers.length; i++){
      summary.add({
        'question_idx': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': answers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(context) {
    final numTotalQ = questions.length;
    final numRightQ = getSummaryData().where((data) { return data ['user_answer'] == data['correct_answer']; }).length;

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
              Text(
                "Your answers is $numRightQ out of $numTotalQ",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 30,),
              TextButton(
                onPressed: (){Navigator.popUntil(context, (route) => route.isFirst);},
                child: const Text("Restart Quiz"),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultTable extends StatelessWidget {
  const ResultTable(this.summary, {super.key});

  final List<Map<String,Object>> summary;

  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summary.map((data){
            return Row(
                children: [
                  Text(
                    ((data["question_idx"] as int) + 1).toString(),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(data["question"] as String),
                        const SizedBox(height: 5,),
                        Text(data["correct_answer"] as String),
                        const SizedBox(height: 5,),
                        Text(data["user_answer"] as String),
                        const SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
