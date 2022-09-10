import 'package:flutter/material.dart';

class FlexLoader extends StatelessWidget {
  const FlexLoader({Key? key, this.barCount = 1, this.currentValue = 0})
      : super(key: key);
  final int barCount;
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    List<Widget> bars = [];
    for (var i = 0; i < barCount; i++) {
      bars.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Container(
              color: currentValue > i
                  ? Theme.of(context).primaryColor.withOpacity(barCount == currentValue ? 1 : 0.7)
                  : Colors.grey,
                  child: const SizedBox(height: 5),
            ),
          ),
        ),
      );
    }

    return Container(
      color: Colors.black87,
      child: Row(
        children: bars,
      ),
    );
  }
}
