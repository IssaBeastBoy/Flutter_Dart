import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'dart:io';

class ImageIput extends StatefulWidget {
  final Function onSelectedImage;

  ImageIput(this.onSelectedImage);

  @override
  State<ImageIput> createState() => _ImageIputState();
}

class _ImageIputState extends State<ImageIput> {
  File? _currImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageSource =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageSource == null) {
      return;
    }
    setState(() {
      _currImage = File(imageSource!.path);
    });
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final fileName = path.basename(imageSource!.path);
    final saveLocation = await imageSource.saveTo('${appDocPath}/${fileName}');
    widget.onSelectedImage(File('${appDocPath}/${fileName}'));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _currImage != null
              ? Image.file(
                  _currImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('Take Image'),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
              onPressed: _takePicture,
              label: Text('Open Camera'),
              icon: Icon(Icons.camera),
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                      TextStyle(color: Theme.of(context).primaryColor)))),
        ),
      ],
    );
  }
}
