import 'package:bloc_task/size_config.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => new _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xffDB0162),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xff80003B),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.wifi,
            color: Colors.white,
            size: SizeConfig.screenWidth * 0.09,
          ),
          label: 'Trending',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.article,
            color: Color(0xff80003B),
            size: SizeConfig.screenWidth * 0.09,
          ),
          label: 'My base',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.flag,
            color: Color(0xff80003B),
            size: SizeConfig.screenWidth * 0.09,
          ),
          label: 'Live scores',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.more_horiz,
            color: Color(0xff80003B),
            size: SizeConfig.screenWidth * 0.09,
          ),
          label: 'More',
        ),
      ],
      currentIndex: _selectedIndex,
    );
  }
}
