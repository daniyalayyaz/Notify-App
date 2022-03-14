import 'package:flutter/material.dart';
import 'package:notify_app/Screens/Dashboard.dart';
import 'package:notify_app/Screens/Menu2.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static final route = 'tabsScreen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  @override
  void initState() {
    _pages = [
      {
        'Pages': Home(),
        'title': 'Home',
      },
      {
        'Pages': Menu2(),
        'title': 'Explore',
      },
      {
        'Pages': Home(),
        'title': 'Cart',
      },
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['Pages'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xffB788E5),
            icon: Icon(Icons.feed_rounded),
            label: 'News & Feeds',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xffB788E5),
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
