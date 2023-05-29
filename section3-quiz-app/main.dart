import "package:flutter/material.dart";
import "package:roll_dice/home.dart";

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      title: "Quiz App",
      home: MyHomePage(),
    );
  }
}






