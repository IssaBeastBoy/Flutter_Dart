import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import './providers/places_provider.dart';

// Screens
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlaceProvider(),
      child: MaterialApp(
          title: 'Great Places',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          home: PlacesList(),
          routes: {
            AddPlace.routeName: (ctx) => AddPlace(),
          }),
    );
  }
}
