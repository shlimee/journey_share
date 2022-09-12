import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_share/presentation/bloc/post/post.bloc.dart';
import 'package:journey_share/presentation/bloc/post/post.events.dart';
import 'package:journey_share/presentation/bloc/post/post.state.dart';

class UploadContentScreen extends StatefulWidget {
  UploadContentScreen({Key? key}) : super(key: key);

  @override
  State<UploadContentScreen> createState() => _UploadContentScreenState();
}

class _UploadContentScreenState extends State<UploadContentScreen> {
  File? imageUploaded;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PostBloc>(context);

    return Container(
        child: Center(
            child: Column(
      children: [
        if (imageUploaded != null)
          SizedBox(
            height: 496,
            child: Image.file(imageUploaded!, fit: BoxFit.cover),
          ),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // use whichever suits your need
          children: [
            OutlinedButton(
              onPressed: () async {
                pickImage(ImageSource.gallery);
              },
              child: const Text('SELECT IMAGE'),
            ),
            if (imageUploaded != null)
              ElevatedButton(
                onPressed: () async {
                  bloc.add(OnCreate(fileToUpload: imageUploaded!));
                  Navigator.of(context).pushNamed('/upload/details');
                },
                child: Row(
                  children: const [
                    Icon(Icons.navigate_next),
                    Text('NEXT'),
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
