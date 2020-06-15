import 'package:camera/camera.dart';
import 'package:actualappdontdelete/display_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;
import 'dart:io';
import 'package:actualappdontdelete/display_video_screen.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  final cameras;

  const TakePictureScreen({
    Key key,
    @required this.camera,
    @required this.cameras
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool _isRecording = false;
  String filePath;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Take a Picture'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
                child: Icon(Icons.camera_alt),
                onPressed: () async {
                  try{
                    await _initializeControllerFuture;

                    final path = join(
                        (await getTemporaryDirectory()).path,
                        '${DateTime.now()}.png'
                    );

                    await _controller.takePicture(path);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(imagePath: path,)
                        )
                    );
                  } catch (e) {
                    print(e);
                  }
                }),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.switch_camera),
              onPressed: _onCameraSwitch,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: FloatingActionButton(
              child: Icon(Icons.videocam),
              onPressed: startVideoRecording,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: stopVideoRecording,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.radio_button_checked),
          )
        ],

      ),
    );
  }

  Future<void> _onCameraSwitch() async {
    final CameraDescription cameraDescription = (_controller.description == widget.cameras[0]) ? widget.cameras[1] : widget.cameras[0];
    if (_controller != null) {
      await _controller.dispose();
    }
    _controller = CameraController(cameraDescription, ResolutionPreset.medium);

    _controller.addListener(() {
      if (mounted) setState(() {});
      if (_controller.value.hasError) {
        print('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> startVideoRecording() async {
    print('startVideoRecording');
    if (!_controller.value.isInitialized) {
      return null;
    }
    setState(() {
      _isRecording = true;
    });

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    await Directory(dirPath).create(recursive: true);
    filePath = '$dirPath/${_timestamp()}.mp4';

    if (_controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      await _controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return null;
    }
    setState(() {
      _isRecording = false;
    });

    try {
      await _controller.stopVideoRecording();
    } on CameraException catch (e) {
      print(e);
      return null;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayVideoScreen(videoPath: filePath,)
        )
    );
  }
}