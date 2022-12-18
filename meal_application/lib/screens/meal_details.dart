import 'package:flutter/material.dart';
import 'package:meal_application/models/meal.dart';

import '../data/dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = './mealDetails';
  final Function setFavorite;
  final Function isFavorite;

  MealDetail(this.setFavorite, this.isFavorite);

  Widget _buildSectionTitle(BuildContext contexr, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed'),
      ),
    );
  }

  Widget _buildSectionBody(BuildContext context, Meal meal, String type) {
    if (type == "ingredients") {
      return Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: ListView.builder(
          itemBuilder: ((ctx, index) => Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('${index + 1}. ${meal.ingredients[index]}')),
              )),
          itemCount: meal.ingredients.length,
        ),
      );
    } else {
      return Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: ListView.builder(
          itemBuilder: ((ctx, index) => Card(
                child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                            backgroundColor: Colors.cyan,
                          ),
                          title: Text(
                            '${meal.steps[index]}',
                          ),
                        ),
                        Divider(),
                      ],
                    )),
              )),
          itemCount: meal.steps.length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => mealId == meal.id);
    return Scaffold(
        appBar: AppBar(
          title: Text('${selectedMeal.title}'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: (Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                )),
              ),
              _buildSectionTitle(context, 'Ingedients:'),
              _buildSectionBody(context, selectedMeal, 'ingredients'),
              _buildSectionTitle(context, 'Steps:'),
              _buildSectionBody(context, selectedMeal, 'steps'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
          onPressed: () => setFavorite(mealId),
        ));
  }
}
