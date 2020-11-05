import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/video_play_list/video_play_list.dart';
import 'package:way2fitlife/features/video_play_list/widget/my_video_player.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayListScreen extends StatefulWidget {
  final Bloc bloc;

  VideoPlayListScreen({Key key, this.bloc});

  @override
  _VideoPlayListScreenState createState() => _VideoPlayListScreenState();
}

class _VideoPlayListScreenState extends State<VideoPlayListScreen> {
  String videoId;
  List<String> videoImages = [];

  @override
  void initState() {
    videoId = YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=BBAyRBTfsOU");

    VideoIdList().forEach((element) {
      videoImages.add(YoutubePlayer.getThumbnail(videoId: element, quality: ThumbnailQuality.standard, webp: false));
    });
    super.initState();
  }


/*  List<YoutubePlayerController> _controller = VideoIdList()
      .map<YoutubePlayerController>(
        (videoId) => YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        ),
      )
      .toList();*/

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      appBar: appbar(title: video_play_list, bloc: widget.bloc),
      body:  ListView.separated(
          itemBuilder: (context, index) => GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.network(videoImages[index]),
            ),
            onTap: () => navigateToVideoPlayer(videoList[index]),
          ) , separatorBuilder:(context, index) => verticalSpace(5) ,
          itemCount: videoImages.length)
      /*ListView.separated(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: YoutubePlayer(
            aspectRatio: 1.5,
            controller: _controller[index],
            showVideoProgressIndicator: true,
            progressIndicatorColor: red,
            progressColors: ProgressBarColors(
                backgroundColor: white,
                bufferedColor: Colors.grey,
                playedColor: red,
                handleColor: red),
            onReady: () {
              // _controller.addListener(listener);
            },
          ),
        ),
        separatorBuilder: (context, index) => verticalSpace(5),
        itemCount: _controller.length,
      ),*/
    );
  }

  void navigateToVideoPlayer(String url){
      // launch(url);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MyVideoPlayer(url))
    );
  }
}
