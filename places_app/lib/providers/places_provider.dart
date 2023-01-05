import 'dart:io';

import 'package:flutter/foundation.dart';

// Modal
import '../models/place.dart';
import '../models/place_location.dart';

// Helpers
import '../helpers/db_helper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  void addPlace(String title, File image) {
    final String id = DateTime.now().toString();
    _items.add(Place(id: id, title: title, location: null, image: image));
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': id,
      'title': title,
      'image': image.path,
    });
  }

  Future<void> fetchPlaces() async {
    final data = await DBHelper.getData('user_places');
    _items = data
        .map((item) => Place(
            id: item['id'] as String,
            title: item['title'] as String,
            location: null,
            image: File(item['image'] as String)))
        .toList();
    notifyListeners();
  }
}
