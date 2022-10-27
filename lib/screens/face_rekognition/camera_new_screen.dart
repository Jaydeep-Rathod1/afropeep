import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_screen.dart';

class CameraNewScreen extends StatefulWidget {

  @override
  State<CameraNewScreen> createState() => _CameraNewScreenState();
}

class _CameraNewScreenState extends State<CameraNewScreen> {
  List<CameraDescription> _cameras;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    acccessCaemra();
  }
  acccessCaemra()async{
    _cameras = await availableCameras();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: SafeArea(
        child: Center(
            child: ElevatedButton(
              onPressed: () async {
                await availableCameras().then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CameraScreen(cameras: value))));
              },
              child: const Text("Take a Picture"),
            )),
      ),
    );
  }
}
