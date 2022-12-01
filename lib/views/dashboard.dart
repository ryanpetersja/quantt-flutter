import 'package:flutter/material.dart';
import 'package:quantt/widgets/navbar.dart';

import '../widgets/charts/pie_chart.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView(
          children: const [
            BackhandForehandChart(),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(index: 0),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}