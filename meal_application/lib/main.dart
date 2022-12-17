import 'dart:ui';

import 'package:flutter/material.dart';

// Screens
import '../screens/categories_screen.dart';
import '../screens/category_meals.dart';
import '../screens/meal_details.dart';
import '../screens/tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeal',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(
                  color: Color.fromRGBO(
                20,
                51,
                51,
                1,
              )),
              // titleMedium:
              //     TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed')
            ),
      ),
      routes: {
        '/': (ctx) => TabScreen(),
        CategoryMeals.routeName: (ctx) => CategoryMeals(),
        MealDetail.routeName: (ctx) => MealDetail(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: ((context) => Categories()));
      },
    );
  }
}
