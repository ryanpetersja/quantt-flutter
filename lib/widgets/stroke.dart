import 'package:flutter/material.dart';

class Stroke extends StatelessWidget {
   const Stroke({Key? key,  required this.stroke}) : super(key: key);

 final String stroke;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text( stroke),
    );
  }
}
