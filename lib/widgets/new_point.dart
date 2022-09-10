import 'package:flutter/material.dart';

class NewPoint extends StatelessWidget {
  const NewPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.rocket,
          color: Colors.yellow,
          size: 30,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Let's Go!",
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white38),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Tap position that the ball was played from then the position that the ball was played to",
          textAlign: TextAlign.center,
          style: TextStyle(
               color: Colors.white38),
        
        )
      ],
    );
  }
}
