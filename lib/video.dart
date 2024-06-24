import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Video_player extends StatefulWidget {
  @override
  _Video_playerState createState() => _Video_playerState();
}

class _Video_playerState extends State<Video_player> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // Video player ve Chewie controller'ı başlatma
    _videoPlayerController =
        VideoPlayerController.asset('lib/images/assets/video.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      autoInitialize: false,
      looping: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Video player ve Chewie controller'ı temizleme
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Debug etiketini kaldırma

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: null, // AppBar'ı kaldırma
          body: Expanded(
            child: Center(
              child: SizedBox(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
