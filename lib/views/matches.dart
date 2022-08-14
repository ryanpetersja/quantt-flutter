import 'package:flutter/material.dart';
import 'package:quantt/controllers/set_controller.dart';
import 'package:quantt/models/set.dart';
import 'package:quantt/services/remote_services.dart';

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
      body: ListView.builder(
          itemCount: _sets?.length,
          itemBuilder: (context, index) {
            Set? set = _sets?[index];
            return Container(child: Text('${_sets?[index].venue}'));
          }),
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
