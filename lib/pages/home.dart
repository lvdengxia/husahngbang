import 'package:flutter/material.dart';
import 'package:hushangbang/components/BottomBar.dart';
import 'package:hushangbang/pages/person.dart';
import 'package:hushangbang/pages/task.dart';
import 'package:hushangbang/pages/todo.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageController = PageController();
  final _currentIndex = 0;

  void _onItemTapped( int index){
    setState(() {
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTapped,
        children: [
          Task(),
          Todo(),
          Person()
        ],
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem( icon: Icon(Icons.home) ,title: Text('任务大厅')),
          BottomNavigationBarItem( icon: Icon(Icons.fingerprint) ,title: Text('待配送订单')),
          BottomNavigationBarItem( icon: Icon(Icons.person_outline) ,title: Text('个人中心')),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}


