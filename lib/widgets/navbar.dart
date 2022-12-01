import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key, int this.index = 0}) : super(key: key);

  final index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart ),
          label: 'Dashboard',
        ),
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
        ),
      ],
      currentIndex: index,
      unselectedItemColor: Colors.black38,
      selectedItemColor: const Color.fromARGB(255, 0, 158, 34),
      onTap: null,
    );
  }
}
