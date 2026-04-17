import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// A dedicated screen for video playback within the application.
/// It wraps [VideoPlayerController] with [Chewie] to provide advanced playback controls.
class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.videoTitle,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  /// Initializes the video player and configures the Chewie controller.
  Future<void> _initializePlayer() async {
    //* Step 1: Initialize the core video player with the network URL.
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await _videoPlayerController.initialize();

    //* Step 2: Set up Chewie for advanced UI and playback options.
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      //_ Dynamically adjust aspect ratio based on the video source.
      aspectRatio: _videoPlayerController.value.aspectRatio,

      //* Error Handling: Displays a message if the video fails to load.
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    // Refresh UI to display the player once initialized.
    setState(() {});
  }

  @override
  void dispose() {
    //* Critical: Dispose of both controllers to prevent memory leaks.
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Dark background for an immersive cinema experience.
      appBar: AppBar(
        title: Text(widget.videoTitle),
      ),
      body:
          _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController!)
          //* Loading State: Shown while the video metadata is being fetched.
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
