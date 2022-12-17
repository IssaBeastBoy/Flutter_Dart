import 'package:flutter/material.dart';

class DrawerTab extends StatelessWidget {
  Widget _buildDrawContent(String title, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Colors.cyan,
          child: Text(
            'What\'s cooking?',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26,
                color: Theme.of(context).primaryColor),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _buildDrawContent("Meal", Icons.restaurant),
        _buildDrawContent("Filters", Icons.filter),
      ],
    ));
  }
}
