abstract class ForumEvent {}

class ForumFetchEvent extends ForumEvent {
  int offset;

  ForumFetchEvent({this.offset});
}

class ForumNextPageEvent extends ForumEvent {
  int offset;

  ForumNextPageEvent({this.offset});
}

class AddForumBtnEvent extends ForumEvent {
  String topic;
  String title;

  AddForumBtnEvent({this.topic, this.title});
}

class AddForumEvent extends ForumEvent {
  String forum_topic;
  String forum_title;
  String description;

  AddForumEvent({this.forum_topic, this.forum_title, this.description});
}
