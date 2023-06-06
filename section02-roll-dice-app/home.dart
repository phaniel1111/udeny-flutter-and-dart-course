import "package:flutter/material.dart";
import "dart:math";

final randomizer = Random();
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var activeImage = 'assets/images/dice-1.png';

  void _rollDice() {
    setState(() {
      activeImage = 'assets/images/dice-${(randomizer.nextInt(6) + 1).toString()}.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              activeImage,
              width: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _rollDice,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                child: const Text("Role Dice")),
          ],
        ),
      ),
    );
  }
}
