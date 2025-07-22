import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String youtubeUrl;
  const YoutubeVideoPlayer({super.key, required this.youtubeUrl});

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  late String _currentVideoId;

  @override
  void initState() {
    super.initState();
    _currentVideoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: _currentVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: false,
        controlsVisibleAtStart: true,
        forceHD: false,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant YoutubeVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newVideoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '';
    if (newVideoId != _currentVideoId) {
      _currentVideoId = newVideoId;
      _controller.load(_currentVideoId);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        // Custom controls tanpa tombol fullscreen
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
        ],
      ),
    );
  }
}