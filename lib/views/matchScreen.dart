import 'package:flutter/material.dart';
import 'package:quantt/views/balls/add_ball_screen.dart';
import 'package:quantt/widgets/info.dart';

import '../styles/text_styles.dart';
import 'package:quantt/models/set.dart';

class MatchScreen extends StatefulWidget {
  final Set match;

  const MatchScreen({Key? key, required this.match}) : super(key: key);

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  @override
  Widget build(BuildContext context) {
    Set match = widget.match;
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>  AddBallScreen(
                player1: match.player1, player2: match.player2),
          ),
        ),
        child: const Text(
          "Add Points",
          textAlign: TextAlign.center,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.black87),
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Text(
                  widget.match.player1["name"],
                  style: QTTStyles.pleyerNames(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "vs",
                  style: TextStyle(color: Colors.white54),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.match.player2["name"],
                  style: QTTStyles.pleyerNames(),
                ),
              ],
            ),
          ),
          //Other Match Details
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(color: Colors.green),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Info(
                        label: "Tournament",
                        value: widget.match.tournament,
                      ),
                      Info(
                        label: "Date",
                        value: widget.match.date,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Info(
                        label: "Tournament",
                        value: widget.match.tournament,
                      ),
                      Info(
                        label: "Table",
                        value: widget.match.tableType,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
