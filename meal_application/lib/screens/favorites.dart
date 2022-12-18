import 'package:flutter/material.dart';

// Widgets
import '../widgets/meal_item.dart';

// Modals
import '../models/meal.dart';

class Favorite extends StatelessWidget {
  final List<Meal> favorite;
  const Favorite(this.favorite);

  @override
  Widget build(BuildContext context) {
    if (favorite.isEmpty) {
      return Center(
        child: Text('Favorits'),
      );
    } else {
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: favorite[index].id,
                title: favorite[index].title,
                imgUrl: favorite[index].imageUrl,
                duration: favorite[index].duration,
                complexity: favorite[index].complexity,
                affordability: favorite[index].affordability);
          },
          itemCount: favorite.length);
    }
  }
}
