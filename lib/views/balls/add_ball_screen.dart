import 'package:flutter/material.dart';

class AddBallScreen extends StatefulWidget {
  //  final Set match;
  const AddBallScreen({Key? key}) : super(key: key);

  @override
  State<AddBallScreen> createState() => _AddBallScreenState();
}

class _AddBallScreenState extends State<AddBallScreen> {
  double padding = 10;
  double appWidth = 411;
  double borderSize = 2;
  double appHeight = 866;
  double tableProportion = 0.55;
  double tableWidthProportion = 0.80;
  int from = 0;
  int to = 0;
  String selectedStroke = '';
  String strokeCategory = 'offensive';
  String selectedStrokeCategory = 'offensive';
  String chosenHand = "";
  String selectedSpin = "";

  _buildStrokeList() {
    List<String> strokes = [];

    switch (selectedStrokeCategory) {
      case 'offensive':
        {
          strokes = [
            "Drive",
            "Slow Topspin",
            "Counter Topspin",
            "Push",
            "Flick",
            "Chop",
            "Banna Flip"
          ];
        }
        break;

      case 'defensive':
        {
          strokes = [
            "Push",
            "Lob",
            "Chop",
          ];
        }
        break;

      case 'service':
        {
          strokes = [
            "Pendullum",
            "Cork Skrew",
            "Shovel",
            "Birdman",
          ];
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }

    List<Widget> children = [];
    for (var stroke in strokes) {
      children.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedStroke = stroke;
              print(selectedStroke);
            });
          },
          child: Container(
            width: appWidth * 0.26,
            decoration: selectedStroke == stroke
                ? BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    border: const Border.symmetric(
                        horizontal: BorderSide(
                            color: Color.fromARGB(255, 205, 193, 66))),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.0),
                        Theme.of(context).primaryColor.withOpacity(0.9),
                        Theme.of(context).primaryColor.withOpacity(0.00),
                      ],
                    ))
                : const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                stroke,
                textAlign: TextAlign.center,
                style: selectedStroke == stroke
                    ? const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      )
                    : const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildStrokeTypeIconButton(
      {required String strokeType, required Widget icon}) {
    return IconButton(
      onPressed: () {
        setState(() {
          selectedStrokeCategory = strokeType;
        });
      },
      icon: icon,
      color: selectedStrokeCategory == strokeType
          ? Theme.of(context).primaryColor
          : Colors.grey,
    );
  }

  _buildSector(height, {required int id}) {
    Color backgroundColor = const Color.fromARGB(255, 209, 209, 209);
    if (height > 0.45) {
      throw "Too tall for table, use a number less tan 0.5";
    }
    if (from == id) {
      backgroundColor = Colors.green;
    }
    if (to == id) {
      backgroundColor = Colors.red;
      // assert(from != to);
    }

    return GestureDetector(
      onTap: () {
        if (to == 0 && from == id) {
          setState(() {
            from = 0;
          });
        } else {
          if (from == 0) {
            setState(() {
              if (to == 0 && id == from) {
                from = 0;
              } else {
                from = id;
              }
              print(id);
            });
          } else {
            setState(() {
              if (id == to) {
                to = 0;
              } else {
                to = id;
              }
              print(id);
            });
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255), width: 2),
        ),
        child: SizedBox(
          width: (appWidth - (padding * 2) - (borderSize * 10)) * 0.15,
          height: ((appHeight * tableProportion) * height) - (borderSize * 8),
          child: Text(
            id.toString(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  _buildHandSelector() {
    List hands = ["Forehand", "Backhand"];

    List<Widget> handWidgets = [];
    for (var hand in hands) {
      handWidgets.add(GestureDetector(
        onTap: () {
          setState(() {
            chosenHand = hand;
          });
        },
        child: Container(
          width: 120,
          decoration: hand == chosenHand
              ? BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  border: const Border.symmetric(
                      horizontal:
                          BorderSide(color: Color.fromARGB(255, 205, 193, 66))),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.0),
                      Theme.of(context).primaryColor.withOpacity(0.9),
                      Theme.of(context).primaryColor.withOpacity(0.00),
                    ],
                  ))
              : const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              hand,
              textAlign: TextAlign.center,
              style: chosenHand == hand
                  ? const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    )
                  : const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
            ),
          ),
        ),
      ));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: handWidgets,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildSpinSelector() {
    List spins = ["Top", "Top-side", "Side", "Back-side", "back"];

    List<Widget> handWidgets = [];
    for (var spin in spins) {
      handWidgets.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedSpin = spin;
          });
        },
        child: Container(
          width: appWidth * 0.26,
          decoration: spin == selectedSpin
              ? BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  border: const Border.symmetric(
                      horizontal:
                          BorderSide(color: Color.fromARGB(255, 205, 193, 66))),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.0),
                      Theme.of(context).primaryColor.withOpacity(0.9),
                      Theme.of(context).primaryColor.withOpacity(0.00),
                    ],
                  ))
              : const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            child: Text(
              spin,
              textAlign: TextAlign.center,
              style: selectedSpin == spin
                  ? const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    )
                  : const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
            ),
          ),
        ),
      ));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: handWidgets,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Full page
      body: ListView(children: [
        Container(
          height: appHeight * tableProportion,
          width: appWidth * 0.26,
          padding: const EdgeInsets.all(0),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 21, 21, 21)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //far side long
                  Row(children: [
                    _buildSector(0.1, id: 1),
                    _buildSector(0.1, id: 2),
                    _buildSector(0.1, id: 3),
                    _buildSector(0.1, id: 4),
                    _buildSector(0.1, id: 5),
                  ]),
                  Row(children: [
                    _buildSector(0.40, id: 6),
                    _buildSector(0.40, id: 7),
                    _buildSector(0.40, id: 8),
                    _buildSector(0.40, id: 9),
                    _buildSector(0.40, id: 10),
                  ]),
                  Row(
                    children: [
                      _buildSector(0.40, id: 11),
                      _buildSector(0.40, id: 12),
                      _buildSector(0.40, id: 13),
                      _buildSector(0.40, id: 14),
                      _buildSector(0.40, id: 15),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          _buildSector(0.1, id: 16),
                          _buildSector(0.1, id: 17),
                          _buildSector(0.1, id: 18),
                          _buildSector(0.1, id: 19),
                          _buildSector(0.1, id: 20),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Row(children: <Widget>[
            _buildStrokeTypeIconButton(
                strokeType: 'defensive', icon: const Icon(Icons.shield_sharp)),
            _buildStrokeTypeIconButton(
                strokeType: 'offensive',
                icon: const RotatedBox(
                  quarterTurns: 3,
                  child: Icon(Icons.double_arrow),
                )),
            _buildStrokeTypeIconButton(
              strokeType: 'service',
              icon: const Icon(Icons.play_arrow),
            )
          ]),
        ),
        Container(
          height: appHeight * 0.34,
          decoration: const BoxDecoration(color: Colors.black87),
          child: Row(
            children: [
              //List controlls
              _buildStrokeList(),
              _buildHandSelector(),
              _buildSpinSelector()
              
            ],
          ),
        )
      ]),
    );
  }
}
