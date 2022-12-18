import 'package:flutter/material.dart';

//Screens
import '../screens/categories_screen.dart';
import '../screens/favorites.dart';

// Widgets
import '../widgets/drawer.dart';

// Models
import '../models/meal.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoritMeals;

  TabScreen(this.favoritMeals);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      {'page': Categories(), 'title': 'Categories'},
      {'page': Favorite(widget.favoritMeals), 'title': 'Favorites'},
    ];
    super.initState();
  }

  Widget get currentTab {
    return _pages[_selectedPageIndex]['page'] as Widget;
  }

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_pages[_selectedPageIndex]['title']}'),
      ),
      drawer: Drawer(
        child: DrawerTab(),
      ),
      body: currentTab,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          onTap: _selectedPage,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ]),
    );
  }
}
