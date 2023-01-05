import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SetProfilePicture extends StatefulWidget {
  final void Function(File pickedImage) imagePicked;

  SetProfilePicture(this.imagePicked);

  @override
  State<SetProfilePicture> createState() => _SetProfilePictureState();
}

class _SetProfilePictureState extends State<SetProfilePicture> {
  XFile? _pickedImage;
  void _setImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxHeight: 150);
    setState(() {
      _pickedImage = pickedImage;
    });
    widget.imagePicked(File(_pickedImage!.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              _pickedImage != null ? FileImage(File(_pickedImage!.path)) : null,
        ),
        TextButton.icon(
            onPressed: _setImage,
            icon: Icon(Icons.image),
            label: Text('Add Picture')),
      ],
    );
  }
}
