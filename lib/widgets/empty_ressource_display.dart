import 'package:flutter/material.dart';

class EmptyResource extends StatelessWidget {
  final String text;
  const EmptyResource({Key? key, required this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
    );
  }
}