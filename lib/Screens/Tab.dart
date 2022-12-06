import 'package:flutter/material.dart';
import 'package:notify_app/Screens/Dashboard.dart';
import 'package:notify_app/Screens/Emergency.dart';
import 'package:notify_app/Screens/Grocery.dart';
import 'package:notify_app/Screens/History.dart';
import 'package:notify_app/Screens/News&Feeds.dart';
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
        'Pages': Grocery(),
        'title': 'Grocery',
      },
      {
        'Pages': Emergency(),
        'title': 'Emergency',
      },
      {
        'Pages': Newsandfeeds(),
        'title': 'News & Feeds',
      },
      {
        'Pages': ButtonsHistory(),
        'title': 'History',
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
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_rounded),
            label: 'Grocery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_rounded),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_rounded),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
