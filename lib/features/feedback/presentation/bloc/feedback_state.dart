import 'package:way2fitlife/features/feedback/data/dataModel/feedback_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeedbackState {}

class InitialFeedbackState extends FeedbackState {}

class LoadingBeginFeedbackState extends FeedbackState {}

class LoadingEndFeedbackState extends FeedbackState {}

class ErrorState extends FeedbackState {
  final String message;

  ErrorState(this.message);
}

class GiveFeedbackState extends FeedbackState {
  final FeedbackModel data;

  GiveFeedbackState({this.data});
}

class GetFeedbackButtonStatusState extends FeedbackState {
  final ErrorStatusModel errorStatusModel;

  GetFeedbackButtonStatusState({this.errorStatusModel});
}
