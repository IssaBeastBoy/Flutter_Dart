import 'package:flutter/material.dart';

// Widgets
import '../widgets/meal_item.dart';

// Models
import '../models/meal.dart';

class CategoryMeals extends StatefulWidget {
  static const routeName = '/categories';

  final List<Meal> mealsData;

  CategoryMeals(this.mealsData);

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  bool _isLoadedInit = false;

  @override
  void initState() {
    //....
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isLoadedInit) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'] as String;
      displayedMeals = widget.mealsData.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _isLoadedInit = true;
    }
  }

  void _removeItem(String mealID) {
    setState(() {
      displayedMeals.removeWhere((element) => mealID == element.id);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: displayedMeals[index].id,
                title: displayedMeals[index].title,
                imgUrl: displayedMeals[index].imageUrl,
                duration: displayedMeals[index].duration,
                complexity: displayedMeals[index].complexity,
                affordability: displayedMeals[index].affordability);
          },
          itemCount: displayedMeals.length),
    );
  }
}
