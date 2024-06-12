import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kidsy_tv/links_display_page.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller with the video asset
    _controller = VideoPlayerController.asset('assets/Videos/intro.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true); // Set looping if required
    _controller.setVolume(1.0); // Set volume if required
    _controller.play(); // Start playing the video

    // Schedule navigation to LinksDisplayPage after 10 seconds
    _timer = Timer(const Duration(milliseconds: 11000), () {
      _navigateToLinksDisplayPage();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel(); // Cancel the timer if the widget is disposed
    super.dispose();
  }

  void _navigateToLinksDisplayPage() {
    _controller.pause();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LinksDisplayPage()),
    );
  }

  void _skipVideo() {
    _timer.cancel(); // Cancel the timer if the user skips the video
    _navigateToLinksDisplayPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return Text('Error loading video: ${snapshot.error}');
            }
          },
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: _skipVideo,
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: const Text(
          'S K I P',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}