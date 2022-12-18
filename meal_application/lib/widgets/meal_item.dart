import 'dart:ffi';

import 'package:flutter/material.dart';

// Screens
import '../screens/meal_details.dart';

// Models
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem(
      {required this.id,
      required this.title,
      required this.imgUrl,
      required this.duration,
      required this.complexity,
      required this.affordability});

  String get complexityOutput {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return "ERROR";
    }
  }

  String get affordabilityOutput {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Expensive';
        break;
      default:
        return "ERROR";
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetail.routeName, arguments: id)
        .then((value) => {
              if (value != null)
                {
                  //removeItem(value)
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(
                  imgUrl,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  width: 300,
                  color: Colors.black54,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('$duration min')
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.work,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(complexityOutput),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.money,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(affordabilityOutput),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
