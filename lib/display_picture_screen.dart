import 'package:flutter/material.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({
    Key key,
    this.imagePath
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    uploadCloud()
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Display the Picture"
        ),
      ),
      body: Image.file(File(imagePath)),
    );
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void uploadCloud() async {
    final StorageReference storageRef = FirebaseStorage.instance.ref().child(_timestamp());
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(imagePath),
      StorageMetadata(
        contentType: "image" + '/' + "png",
      ),
    );
    final StorageTaskSnapshot downloadUrl =
    (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print('URL Is $url');
  }
}