import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class Info extends StatelessWidget {
  final String label;
  final value;

  const Info({Key? key, required this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "$label: ",
          style: QTTStyles.infoLabel(),
        ),
        Text(
          value ?? "n/a",
          style: QTTStyles.infoValue(),
        ),
      ],
    );
  }
}
