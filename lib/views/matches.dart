import 'package:flutter/material.dart';
import 'package:quantt/controllers/set_controller.dart';
import 'package:quantt/models/set.dart';
import 'package:quantt/styles/text_styles.dart';
import 'package:quantt/widgets/empty_ressource_display.dart';

import 'matchScreen.dart';

class matches extends StatefulWidget {
  matches({Key? key, required this.title}) : super(key: key);

  String title;
  @override
  State<matches> createState() => _matchesState();
}

class _matchesState extends State<matches> {
  List<Set>? _sets;
  var isLoaded = false;
  final _setController = SetController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  _buildMatch(BuildContext context, set) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MatchScreen(match: set))),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              width: 1.0,
              color: (Colors.green[200])!,
            )),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      set.player1["name"],
                      style: QTTStyles.boldText(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "vs",
                      style: QTTStyles.boldText(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      set.player2["name"],
                      style: QTTStyles.boldText(),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      set.venue,
                    ),
                     Text(set.date ?? "-", textAlign: TextAlign.start, style: const TextStyle(),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getData() async {
    List<Set> sets = await _setController.getSets();
    setState(() {
      _sets = sets;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // ignore: avoid_unnecessary_containers
      body: _sets != null ? ListView.builder(
          itemCount: _sets?.length,
          itemBuilder: (context, index) {
            Set set = _sets![index];
                double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("height: $height \n width: $width");
            return _buildMatch(context, set);
            // return Container(child: Text('${set.venue}'));
          }) : const EmptyResource(text: "No sets added yet"),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Players',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile',
          )
        ],
        currentIndex: 0,
        selectedItemColor: const Color.fromARGB(255, 0, 158, 34),
        onTap: null,
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
