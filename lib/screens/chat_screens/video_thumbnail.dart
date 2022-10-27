import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDesignScreen extends StatefulWidget {
  final String url;
  const VideoDesignScreen({Key key, this.url}) : super(key: key);

  @override
  _VideoDesignScreenState createState() => _VideoDesignScreenState();
}

class _VideoDesignScreenState extends State<VideoDesignScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});  //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
          aspectRatio: 3/4,
          child: Stack(
            children: [
              VideoPlayer(_controller),
              Container(
                color: Colors.black.withOpacity(0.5),
                  child: Center(child: Image.asset("assets/images/play-button.png",width: 80,color: Colors.white,)))
            ],
          )
        ): AspectRatio(
          aspectRatio: 3/4,
          child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(child: Image.asset("assets/images/play-button.png",width: 80,color: Colors.white,))),
              Center(child: CircularProgressIndicator(backgroundColor: Colors.green,valueColor:AlwaysStoppedAnimation<Color>(Colors.blue))),
      ],
    ),
        );
  }
}