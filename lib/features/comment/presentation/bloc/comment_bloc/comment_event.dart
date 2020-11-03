abstract class CommnetEvent {}

class ForumDetailEvent extends CommnetEvent {
  String forum_id;

  ForumDetailEvent({this.forum_id});
}
