import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  // const name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message,
          ),
          title: Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.group,
          ),
          title: Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          title: Container(height: 0.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          title: Container(height: 0.0),
        ),
      ],
      // onTap: ,
      // currentIndex: null,
    );
  }
}
