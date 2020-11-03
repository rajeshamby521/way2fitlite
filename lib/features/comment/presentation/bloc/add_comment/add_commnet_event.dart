abstract class AddCommentEvent {}

class AddCommentBtnEvent extends AddCommentEvent {
  String commnet;

  AddCommentBtnEvent({this.commnet});
}

class AddCommentClickEvent extends AddCommentEvent {
  String commnet;

  AddCommentClickEvent({this.commnet});
}
