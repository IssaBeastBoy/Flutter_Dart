import 'package:flutter/material.dart';

//Widgets
import '../widgets/categoryItem.dart';

//Data
import '../data/dummy_data.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(15),
      children: DUMMY_CATEGORIES
          .map((data) => (CategoryItem(data.id, data.title, data.color)))
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
    );
  }
}
