import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  const VideoPlayerScreen({Key key,this.url}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  var videoPlayerController;
  var chewieController;
  @override
  void initState() {
    super.initState();
    _loadintailize();
  }

  _loadintailize()async{
    videoPlayerController = VideoPlayerController.network(widget.url);
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      allowMuting: true,
      showControls: true,
      showOptions: true,
      fullScreenByDefault: true,
      allowPlaybackSpeedChanging: true,
    );
    setState(() {});
  }


  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body: Stack(
        children: [
          chewieController==null?Container(child: Center(child: CircularProgressIndicator())):Chewie(
            controller: chewieController,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 10),
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close,color: Colors.white,size: 30,)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
