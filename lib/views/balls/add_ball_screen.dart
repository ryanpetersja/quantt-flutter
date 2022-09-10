import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantt/styles/text_styles.dart';
import 'package:quantt/widgets/flex_loader.dart';
import 'package:quantt/widgets/new_point.dart';

import '../../models/ball.dart';
import '../../models/player.dart';
import '../../services/helper.dart';
import '../../services/placements.dart';
import '../../services/stroke_helper.dart';

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
  RxInt from = 0.obs;
  RxInt to = 0.obs;
  RxString selectedStroke = ''.obs;
  String strokeCategory = 'offensive';
  String selectedStrokeCategory = 'offensive';
  RxString chosenHand = "".obs;
  RxString selectedSpin = "".obs;
  Map<dynamic, dynamic> topPlayer = {};
  Map<dynamic, dynamic> bottomPlayer = {};
  double tableBorderThickness = 4;
  double sectorCount = 0;
  dynamic winner;
  RxInt loaderValue = 0.obs;
  RxInt stage = 0.obs;

  _reset() {
    setState(() {
      padding = 1;
      appWidth = 411;
      borderSize = 1;
      appHeight = 866;
      tableProportion = 0.60;
      tableWidthProportion = 0.75;
      from.value = 0;
      to.value = 0;
      selectedStroke.value = '';
      strokeCategory = 'offensive';
      selectedStrokeCategory = 'offensive';
      chosenHand.value = "";
      selectedSpin.value = "";
      topPlayer = {};
      bottomPlayer = {};
      tableBorderThickness = 4;
      sectorCount = 0;
      winner = null;
      loaderValue.value = 0;
      stage = 0.obs;
    });
  }

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
            "Reverse pendullum",
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
              selectedStroke.value = stroke;
              switch (stroke) {
                case 'Push':
                case 'Chop':
                  selectedSpin.value = "Back";
                  break;
                case 'Drive':
                case 'Slow Topspin':
                case 'Counter Topspin':
                  selectedSpin.value = "Top";
                  break;
                case 'Banna Flick':
                  selectedSpin.value = "Top-side";
                  chosenHand.value = "Backhand";
                  break;
                case 'Smash':
                  selectedSpin.value = "Flat";
                  chosenHand.value = "Forehand";
                  break;
                case 'Flick':
                  selectedSpin.value = "Top";
                  break;
                case 'Block':
                  selectedSpin.value = "Flat";
                  chosenHand.value = "Backhand";
                  break;
                case 'Lob':
                  selectedSpin.value = "Top";
                  break;
                case 'chop':
                  chosenHand.value = "Back";
                  break;
                case 'Cork Screw':
                  chosenHand.value = "Backhand";
                  break;
                case 'Shovel':
                  chosenHand.value = "Forehand";
                  break;
                case 'Pendullum':
                  chosenHand.value = "Forehand";
                  break;
                case 'Birdman':
                  chosenHand.value = "Forehand";
                  break;
                default:
              }

              Future.delayed(const Duration(milliseconds: 700), () {
                stage.value = 2;
              });
            });
          },
          child: Container(
            width: appWidth * 0.26,
            decoration: selectedStroke.value == stroke
                ? BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    border: const Border.symmetric(
                      horizontal: BorderSide(
                        color: Color.fromARGB(255, 0, 100, 38),
                      ),
                    ),
                  )
                : BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(74, 255, 255, 255),
                    ),
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stroke,
                  textAlign: TextAlign.center,
                  style: selectedStroke.value == stroke
                      ? const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        )
                      : const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: SizedBox(
            height: 150,
            child: GridView.count(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: children,
            ),
          ),
        ),
      ],
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
    if (from.value == id) {
      backgroundColor = Theme.of(context).primaryColor.withOpacity(0.5);
    }
    if (to.value == id) {
      backgroundColor = Colors.red;
      // assert(from != to);
    }
    if (centerQuadrants.contains(id)) {
      isCenterQuadrant = true;
    }

    sectorCount++;
    return GestureDetector(
      onTap: () {
        if (to.value == 0 && from.value == id) {
          setState(() {
            from.value = 0;
          });
        } else {
          if (from.value == 0) {
            setState(() {
              if (to.value == 0 && id == from.value) {
                from.value = 0;
              } else {
                from.value = id;
              }
            });
          } else {
            setState(() {
              if (id == to.value) {
                to.value = 0;
              } else {
                to.value = id;
              }
            });
          }
        }
        if (to.value != 0 && from.value != 0) {
          stage.value = 1;
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
            chosenHand.value = hand;
            Future.delayed(const Duration(milliseconds: 700), () {
              stage.value = 3;
            });
          });
        },
        child: Container(
          width: appWidth * 0.28,
          decoration: hand == chosenHand.value
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
              style: chosenHand.value == hand
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
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            Expanded(child: handWidgets[0]),
            Expanded(child: handWidgets[1])
          ],
        ),
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
            selectedSpin.value = spin;
          });
          Future.delayed(const Duration(milliseconds: 700), () {
            stage.value = 4;
          });
        },
        child: Container(
          width: appWidth * 0.26,
          decoration: spin == selectedSpin.value
              ? BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  border: const Border.symmetric(
                      horizontal:
                          BorderSide(color: Color.fromARGB(255, 0, 100, 38))),
                )
              : BoxDecoration(
                  // color: Theme.of(context).primaryColor.withOpacity(0.7),
                  border: Border.all(color: Colors.grey),
                ),
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
      padding: const EdgeInsets.all(30),
      child: GridView.count(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: handWidgets,
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
        color: Colors.white70,
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
        color: Colors.white70,
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

  _getFromPlayer() {
    String fromPosition = Placements.getPlayerPosition(from.value);
    if (fromPosition == 'top') {
      return topPlayer;
    } else if (fromPosition == 'bottom') {
      return bottomPlayer;
    } else {
      throw "unable to detect from player";
    }
  }

  _getToPlayer() {
    String toPosition = Placements.getPlayerPosition(to.value);
    if (toPosition == 'top') {
      return topPlayer;
    } else if (toPosition == 'bottom') {
      return bottomPlayer;
    } else {
      throw "unable to detect from player";
    }
  }

  _submissionConfirmation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {
            Player fromPlayer = Player.fromJson(_getFromPlayer());
            Player toPlayer = Player.fromJson(_getToPlayer());

            Ball ball = Ball(
              pointId: 1,
              winner: true,
              spin: selectedSpin.value,
              from: Placements.getPlacement(
                  playerPosition: Placements.getPlayerPosition(from.value),
                  sectorIndex: from.value,
                  rightHanded: fromPlayer.rightHanded),
              to: Placements.getPlacement(
                  playerPosition: Placements.getPlayerPosition(to.value),
                  sectorIndex: to.value,
                  rightHanded: toPlayer.rightHanded),
              strokeType: selectedStroke.value,
              playerId: fromPlayer.id,
              loser: toPlayer.id,
              isService: StrokeHelper.isService(selectedStroke.value),
            );
            ball.save();
            _reset();
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(scrollDirection: Axis.vertical, children: [
        Container(
          height: appHeight * tableProportion,
          width: appWidth,
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
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
                  decoration:
                      const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
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
                          border: Border(top: BorderSide(color: Colors.white)),
                          color: Color.fromARGB(255, 29, 29, 29),
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
        Obx(() {
          int currentValue = 0;
          if (from.value != 0) {
            currentValue++;
          }
          if (to.value != 0) {
            currentValue++;
          }
          if (selectedStroke.value != "") {
            currentValue++;
          }
          if (selectedSpin.value != "") {
            currentValue++;
          }
          if (chosenHand.value != "") {
            currentValue++;
          }
          return FlexLoader(
            barCount: 5,
            currentValue: currentValue,
          );
        }),
        Container(
          // height: appHeight * 0.34,
          padding: EdgeInsets.only(bottom: appHeight * 0.15),
          decoration: const BoxDecoration(color: Colors.black87),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     //List controlls
              //     _buildStrokeList(),
              //     _buildHandSelector(),
              //     _buildSpinSelector()
              //   ],
              // ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 220,
                  child: Obx(() {
                    switch (stage.value) {
                      case 0:
                        return const NewPoint();
                      case 1:
                        return _buildStrokeList();
                      case 2:
                        return _buildHandSelector();
                      case 3:
                        return _buildSpinSelector();
                      case 4:
                        return _submissionConfirmation();
                      default:
                        return const SizedBox();
                    }
                  }),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      onTap: () => stage--,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          stage.value.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                        child: const Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                        onTap: () => stage++),
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
