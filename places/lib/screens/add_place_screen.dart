import 'dart:io';

// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Widgets
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

// Providers
import '../providers/places_provider.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectedImage(File imageFile) {
    _pickedImage = imageFile;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<PlaceProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(label: Text('Title')),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageIput(_selectedImage),
                  SizedBox(
                    height: 10,
                  ),
                  LocationInput(),
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('Add place'),
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(10),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          )
        ],
      ),
    );
  }
}
