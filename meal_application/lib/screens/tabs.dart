import 'package:flutter/material.dart';

//Screens
import '../screens/categories_screen.dart';
import '../screens/favorites.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meal'),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.category),
              text: 'Categories',
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: 'Favorite',
            ),
          ]),
        ),
        body: TabBarView(children: [
          Categories(),
          Favorite(),
        ]),
      ),
    );
  }
}
