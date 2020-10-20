abstract class FeedbackEvent {}

class GiveFeedbackEvent extends FeedbackEvent {
  String subject;
  String msg;

  GiveFeedbackEvent({this.subject, this.msg});
}

class GetFeedbackButtonStatusEvent extends FeedbackEvent {
  String subject;
  String message;

  GetFeedbackButtonStatusEvent({this.subject, this.message});
}
