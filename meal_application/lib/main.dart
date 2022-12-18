import 'dart:ui';

import 'package:flutter/material.dart';

// Data
import './data/dummy_data.dart';

// Screens
import '../screens/categories_screen.dart';
import '../screens/category_meals.dart';
import '../screens/meal_details.dart';
import '../screens/tabs.dart';
import '../screens/filter.dart';

// Modal
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'Gluten': false,
    'Lactose': false,
    'Vegan': false,
    'Vegetarian': false,
  };

  List<Meal> _mealData = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;

      _mealData = DUMMY_MEALS.where((meal) {
        if (_filters['Gluten'] == true && !meal.isGlutenFree) {
          return false;
        } else if (_filters['Lactose'] == true && !meal.isLactoseFree) {
          return false;
        } else if (_filters['Vegan'] == true && !meal.isVegan) {
          return false;
        } else if (_filters['Vegetarian'] == true && !meal.isVegetarian) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  List<Meal> _favoritMeals = [];

  void _setFavorite(String mealId) {
    final indexExit = _favoritMeals.indexWhere((meal) => meal.id == mealId);
    if (indexExit >= 0) {
      setState(() {
        _favoritMeals.removeAt(indexExit);
      });
    } else {
      setState(() {
        _favoritMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavorite(String id) {
    return _favoritMeals.any((meal) => meal.id == id);
  }

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
        '/': (ctx) => TabScreen(_favoritMeals),
        CategoryMeals.routeName: (ctx) => CategoryMeals(_mealData),
        MealDetail.routeName: (ctx) => MealDetail(_setFavorite, _isFavorite),
        Filters.routeName: (ctx) => Filters(_setFilters, _filters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: ((context) => Categories()));
      },
    );
  }
}
