import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _currentIndex = 0;

  void _onItemTapped( int index){
    print(index);
    setState(() {
      Navigator.pushNamed(context, 'login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem( icon: Icon(Icons.home) ,title: Text('任务大厅')),
        BottomNavigationBarItem( icon: Icon(Icons.fingerprint) ,title: Text('待配送订单')),
        BottomNavigationBarItem( icon: Icon(Icons.person_outline) ,title: Text('个人中心')),
      ],
      currentIndex: _currentIndex,
      fixedColor: Colors.orange,
      onTap: _onItemTapped,
    );
  }
}
