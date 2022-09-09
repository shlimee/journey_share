import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadContentScreen extends StatefulWidget {
  UploadContentScreen({Key? key}) : super(key: key);

  @override
  State<UploadContentScreen> createState() => _UploadContentScreenState();
}

class _UploadContentScreenState extends State<UploadContentScreen> {
  File? imageUploaded;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      children: [
        if (imageUploaded != null)
          Container(
            height: 496,
            child: Image.file(imageUploaded!, fit: BoxFit.cover),
          ),
        Row(
          children: [
            OutlinedButton(
              onPressed: () async {
                pickImage(ImageSource.gallery);
              },
              child: Text('SELECT IMAGE'),
            ),
            ElevatedButton(
              onPressed: () async {
                pickImage(ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(Icons.publish),
                  Text('Publish'),
                ],
              ),
            ),
          ],
        ),
      ],
    )));
  }

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;

      setState(() {
        imageUploaded = File(image.path);
      });
    } catch (e) {
      throw e;
    }
  }
}
