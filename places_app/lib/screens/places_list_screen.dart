import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import './add_place_screen.dart';

// Providera
import '../providers/places_provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlace.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<PlaceProvider>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) => Consumer<PlaceProvider>(
          child: Center(child: Text("Add your favorite places")),
          builder: (ctx, places, ch) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : places.items.length <= 0
                  ? ch as Widget
                  : ListView.builder(
                      itemBuilder: (ctx, i) => ListTile(
                        leading: CircleAvatar(
                            backgroundImage: FileImage(places.items[i].image)),
                        title: Text(places.items[i].title),
                        onTap: () {},
                      ),
                      itemCount: places.items.length,
                    ),
        ),
      ),
    );
  }
}
