import 'package:flutter/material.dart';

class QTTStyles {
  static boldText() {
    return TextStyle(fontWeight: FontWeight.w700, color: Colors.green[900]);
  }

  static pleyerNames() {
    return const TextStyle(
        fontWeight: FontWeight.w900, color: Colors.white, fontSize: 25);
  }

  static infoLabel() {
    return const TextStyle(fontWeight: FontWeight.bold);
  }

  static infoValue() {
    return const TextStyle(fontWeight: FontWeight.w400, color: Colors.white);
  }

  static backhandTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      color: Color.fromARGB(255, 212, 21, 21),
      fontSize: 12,
    );
  }

  static foreHandTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
      color: Color.fromARGB(255, 10, 10, 10),
      fontSize: 12,
    );
  }

  static playerName() {
    return const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 10,
        fontWeight: FontWeight.w800);
  }
}
