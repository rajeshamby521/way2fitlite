import 'package:way2fitlife/common/validation.dart';
import 'package:way2fitlife/features/feedback/domain/usecase/feedback_usecase.dart';
import 'package:way2fitlife/features/feedback/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackDataUseCase feedbackDataUseCase;
  FeedbackButtonStatusUseCase feedbackButtonStatusUseCase;

  FeedbackBloc({this.feedbackDataUseCase, this.feedbackButtonStatusUseCase})
      : super(InitialFeedbackState());

  @override
  Stream<FeedbackState> mapEventToState(FeedbackEvent event) async* {
    if (event is GiveFeedbackEvent) {
      yield LoadingBeginFeedbackState();
      final result = await feedbackDataUseCase(FeedbackDataParams(
        subject: event.subject,
        msg: event.msg,
      ));
      yield LoadingEndFeedbackState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GiveFeedbackState(data: success),
      );
    }
    if (event is GetFeedbackButtonStatusEvent) {
      String subMsg = feedbackValidationMsg(value: event.subject);
      String msgMsg = feedbackValidationMsg(value: event.message);

      bool subjectValid = isFeedbackValid(value: subMsg);
      bool messageValid = isFeedbackValid(value: msgMsg);

      print("-*-*-  $subMsg ++ $msgMsg ++ $subjectValid ++ $messageValid");
      final result = await feedbackButtonStatusUseCase(FeedbackButtonStatusParams(
        subjectValid: subjectValid,
        messageValid: messageValid,
        subMsg: subMsg,
        msgMsg: msgMsg,
      ));
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetFeedbackButtonStatusState(errorStatusModel: success),
      );
    }
  }
}
