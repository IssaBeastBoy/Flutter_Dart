import 'package:flutter/material.dart';

//Screens
import 'package:meal_application/screens/category_meals.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMeals.routeName,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              color.withOpacity(0.7),
              this.color,
            ], begin: Alignment.topLeft),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
