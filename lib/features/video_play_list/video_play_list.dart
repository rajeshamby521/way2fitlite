import 'package:youtube_player_flutter/youtube_player_flutter.dart';

List<String> videoList = [
  "https://www.youtube.com/watch?v=qnIkPRkuEQM&ab_channel=ShreddedBeast",
  "https://www.youtube.com/watch?v=Q8jdWSOiyzc&ab_channel=JustJanvi",
  "https://www.youtube.com/watch?v=DZ2Gkzvndwk&ab_channel=GymLeague",
  "https://www.youtube.com/watch?v=cVRnZa3_ing&ab_channel=ShilpaShettyKundra",
  "https://www.youtube.com/watch?v=GgNPTGOmD3A&ab_channel=TsMadaan",
  "https://www.youtube.com/watch?v=TKEgCMyU65Q&ab_channel=SanjeevKapoorKhazana",
];

List<String> VideoIdList() {
  List<String> list = [];
  videoList.forEach((element) {
    list.add(YoutubePlayer.convertUrlToId(element));
  });
  return list;
}
