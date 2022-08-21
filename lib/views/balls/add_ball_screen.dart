import 'package:flutter/material.dart';
import 'package:quantt/styles/text_styles.dart';

import '../../services/helper.dart';

class AddBallScreen extends StatefulWidget {
  final Map player1;
  final Map player2;
  //  final Set match;
  const AddBallScreen({Key? key, required this.player1, required this.player2})
      : super(key: key);

  @override
  State<AddBallScreen> createState() => _AddBallScreenState();
}

class _AddBallScreenState extends State<AddBallScreen> {
  double padding = 1;
  double appWidth = 411;
  double borderSize = 1;
  double appHeight = 866;
  double tableProportion = 0.60;
  double tableWidthProportion = 0.75;
  int from = 0;
  int to = 0;
  String selectedStroke = '';
  String strokeCategory = 'offensive';
  String selectedStrokeCategory = 'offensive';
  String chosenHand = "";
  String selectedSpin = "";
  Map<dynamic, dynamic> topPlayer = {};
  Map<dynamic, dynamic> bottomPlayer = {};
  double tableBorderThickness = 4;

  _buildStrokeList() {
    List<String> strokes = [];

    switch (selectedStrokeCategory) {
      case 'offensive':
        {
          strokes = [
            "Drive",
            "Slow Topspin",
            "Counter Topspin",
            "Flick",
            "Smash",
            'punch',
            "Banna Flick"
          ];
        }
        break;

      case 'defensive':
        {
          strokes = [
            "Block",
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
            "Cork Screw",
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

              switch (stroke) {
                case 'Push':
                case 'Chop':
                  selectedSpin = "Back";
                  break;
                case 'Drive':
                case 'Slow Topspin':
                case 'Counter Topspin':
                  selectedSpin = "Top";
                  break;
                case 'Banna Flick':
                  selectedSpin = "Top-side";
                  chosenHand = "Backhand";
                  break;
                case 'Smash':
                  selectedSpin = "Flat";
                  chosenHand = "Forehand";
                  break;
                case 'Flick':
                  selectedSpin = "Top";
                  break;
                case 'Block':
                  selectedSpin = "Flat";
                  chosenHand = "Backhand";
                  break;
                case 'Lob':
                  selectedSpin = "Top";
                  break;
                case 'chop':
                  chosenHand = "Back";
                  break;
                case 'Cork Screw':
                  chosenHand = "Backhand";
                  break;
                case 'Shovel':
                  chosenHand = "Forehand";
                  break;
                case 'Pendullum':
                  chosenHand = "Forehand";
                  break;
                case 'Birdman':
                  chosenHand = "Forehand";
                  break;
                default:
              }
            });
          },
          child: Container(
            width: appWidth * 0.26,
            decoration: selectedStroke == stroke
                ? BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    border: const Border.symmetric(
                      horizontal: BorderSide(
                        color: Color.fromARGB(255, 0, 100, 38),
                      ),
                    ),
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
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: Text(
                stroke,
                textAlign: TextAlign.center,
                style: selectedStroke == stroke
                    ? const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      )
                    :  TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        fontSize: 14,
                        fontWeight: FontWeight.bold
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
    bool isCenterQuadrant = false;
    List<int> centerQuadrants = [3, 8, 13, 18];

    Color backgroundColor = const Color.fromARGB(255, 31, 64, 101);
    if (height > 0.45) {
      throw "Too tall for table, use a number less tan 0.5";
    }
    if (from == id) {
      backgroundColor = Theme.of(context).primaryColor.withOpacity(0.5);
    }
    if (to == id) {
      backgroundColor = Colors.red;
      // assert(from != to);
    }
    if (centerQuadrants.contains(id)) {
      isCenterQuadrant = true;
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
              color: const Color.fromARGB(255, 44, 72, 112), width: borderSize),
        ),
        child: SizedBox(
          width: (appWidth - (padding * 2) - (borderSize * 10)) * 0.15,
          height: ((appHeight * tableProportion) * height) - (borderSize * 8),
          child: SizedBox(
            width: 1,
            child: SizedBox(
              width: 2,
              child: isCenterQuadrant
                  ? const VerticalDivider(
                      color: Colors.white,
                      thickness: 1.5,
                    )
                  : const SizedBox(),
            ),
          ),
          // child: Text(
          //   id.toString(),
          //   style: const TextStyle(color: Colors.grey),
          // ),
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
          width: appWidth * 0.28,
          decoration: hand == chosenHand
              ? BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  border: const Border.symmetric(
                    horizontal: BorderSide(
                      color: Color.fromARGB(255, 0, 100, 38),
                    ),
                  ),
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

  double _getTableHeight() {
    double height = ((appHeight * tableProportion) * 1) - (borderSize * 8);
    return height;
  }

  _buildBorderVertical() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SizedBox(
        width: tableBorderThickness,
        height: _getTableHeight() - 37,
        // child: const Text(""),
      ),
    );
  }

  _buildBorderHorizontal() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SizedBox(
        width: _getTableWidth() * tableWidthProportion,
        height: tableBorderThickness,
        child: const Text(""),
      ),
    );
  }

  double _getTableWidth() {
    return (appWidth + 2);
  }

  _buildSpinSelector() {
    List spins = ["Top", "Top-side", "Side", "Flat", "Back-side", "Back"];

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
                          BorderSide(color: Color.fromARGB(255, 0, 100, 38))),
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
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

  _buildTopPosition(player) {
    if (topPlayer.isEmpty) {
      topPlayer = widget.player1;
    }
    return Container(
      width: (appWidth - (padding * 2)) * 0.75,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 70, 144, 98),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            Helper.isForehand(area: 1, player: topPlayer)
                ? "Forehand"
                : "Backand",
            style: Helper.isForehand(area: 1, player: topPlayer)
                ? QTTStyles.foreHandTextStyle()
                : QTTStyles.backhandTextStyle(),
          ),
          Text(
            topPlayer["name"],
            style: QTTStyles.playerName(),
          ),
          Text(
            Helper.isForehand(area: 2, player: topPlayer)
                ? "Forehand"
                : "Backand",
            style: Helper.isForehand(area: 2, player: topPlayer)
                ? QTTStyles.foreHandTextStyle()
                : QTTStyles.backhandTextStyle(),
          ),
        ],
      ),
    );
  }

  _buildBottomPosition(player) {
    if (bottomPlayer.isEmpty) {
      bottomPlayer = widget.player2;
    }
    return Container(
      width: (appWidth - (padding * 2)) * 0.75,
      height: 18,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 70, 144, 98),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            Helper.isForehand(area: 3, player: bottomPlayer)
                ? "Forehand"
                : "Backand",
            style: Helper.isForehand(area: 3, player: bottomPlayer)
                ? QTTStyles.foreHandTextStyle()
                : QTTStyles.backhandTextStyle(),
          ),
          Text(
            bottomPlayer["name"],
            style: QTTStyles.playerName(),
          ),
          Text(
            Helper.isForehand(area: 4, player: bottomPlayer)
                ? "Forehand"
                : "Backand",
            style: Helper.isForehand(area: 4, player: bottomPlayer)
                ? QTTStyles.foreHandTextStyle()
                : QTTStyles.backhandTextStyle(),
          ),
        ],
      ),
    );
  }

  _switcheroo() {
    setState(() {
      if (topPlayer == widget.player1) {
        topPlayer = widget.player2;
        bottomPlayer = widget.player1;
      } else {
        topPlayer = widget.player1;
        bottomPlayer = widget.player2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print("long pressed container");
      },
      child: Scaffold(
        //Full page
        body: ListView(scrollDirection: Axis.vertical, children: [
          Container(
            height: appHeight * tableProportion,
            width: appWidth,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.9)),
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBorderVertical(),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //far side long
                        Row(
                          children: [_buildTopPosition(topPlayer)],
                        ),
                        _buildBorderHorizontal(),
                        Row(children: [
                          _buildSector(0.1, id: 1),
                          _buildSector(0.1, id: 2),
                          _buildSector(0.1, id: 3),
                          _buildSector(0.1, id: 4),
                          _buildSector(0.1, id: 5),
                        ]),
                        Row(children: [
                          _buildSector(0.37, id: 6),
                          _buildSector(0.37, id: 7),
                          _buildSector(0.37, id: 8),
                          _buildSector(0.37, id: 9),
                          _buildSector(0.37, id: 10),
                        ]),
                        Container(
                          decoration: const BoxDecoration(
                            border:
                                Border(top: BorderSide(color: Colors.white)),
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 8,
                                width: appWidth * 0.75,
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            _buildSector(0.37, id: 11),
                            _buildSector(0.37, id: 12),
                            _buildSector(0.37, id: 13),
                            _buildSector(0.37, id: 14),
                            _buildSector(0.37, id: 15),
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
                        _buildBorderHorizontal(),
                        Row(
                          children: [_buildBottomPosition(bottomPlayer)],
                        )
                      ],
                    ),
                  ),
                  _buildBorderVertical()
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildStrokeTypeIconButton(
                      strokeType: 'defensive',
                      icon: const Icon(Icons.shield_sharp)),
                  _buildStrokeTypeIconButton(
                      strokeType: 'offensive',
                      icon: const RotatedBox(
                        quarterTurns: 3,
                        child: Icon(Icons.double_arrow),
                      )),
                  _buildStrokeTypeIconButton(
                    strokeType: 'service',
                    icon: const Icon(Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: _switcheroo,
                    icon: const Icon(
                      Icons.swap_vertical_circle_rounded,
                      color: Colors.yellow,
                    ),
                  )
                ]),
          ),
          Container(
            // height: appHeight * 0.34,
            padding: EdgeInsets.only(bottom: appHeight * 0.15),
            decoration: const BoxDecoration(color: Colors.black87),
            child: Column(
              children: [
                Row(
                  children: [
                    //List controlls
                    _buildStrokeList(),
                    _buildHandSelector(),
                    _buildSpinSelector()
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        print(
                            "From: $from \n To: $to \n Stroke: $selectedStroke \n Stroke Category:  $selectedStrokeCategory \n Hand: $chosenHand \n Spin: $selectedSpin");
                      },
                      icon: const Icon(
                        Icons.check_circle,
                      ),
                      label: const Text(
                        "Add Point",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
