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
}
