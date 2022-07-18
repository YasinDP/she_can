import 'package:flutter/material.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/models/chapter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  static const String routeName = "/video-player";
  const VideoScreen({Key? key}) : super(key: key);

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  late Chapter chapter;
  YoutubePlayerController? _controller;

  @override
  void didChangeDependencies() {
    chapter = ModalRoute.of(context)!.settings.arguments as Chapter;
    String? videoId = YoutubePlayer.convertUrlToId(chapter.url);
    if (videoId != null) {
      _controller = YoutubePlayerController(
          initialVideoId: videoId, // id youtube video
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Video Player"),
        backgroundColor: Colors.white,
        foregroundColor: ColorsRes.appcolor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _controller != null
                ? YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: ColorsRes.appcolor,
                  )
                : const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator())),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(height: 1, width: width, color: Colors.grey),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(chapter.description ?? "___________"),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
