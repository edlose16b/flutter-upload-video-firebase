import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:retofamosos/constants.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({
    Key key,
    @required this.origin,
    @required this.urlFile,
  }) : super(key: key);

  final String urlFile;
  final VideoOrigin origin;
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController videoPlayerController;

  ChewieController chewieController;

  @override
  void initState() {
    print('Mostrando video:  ${widget.urlFile}');

    if (widget.origin == VideoOrigin.network) {
      videoPlayerController = VideoPlayerController.network(widget.urlFile);
    } else {
      videoPlayerController = VideoPlayerController.file(File(widget.urlFile));
    }

    this.chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      // aspectRatio: 3 / 2,
      aspectRatio: 1,
      autoPlay: true,
      looping: false,
    );

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: this.chewieController,
    );
  }
}
