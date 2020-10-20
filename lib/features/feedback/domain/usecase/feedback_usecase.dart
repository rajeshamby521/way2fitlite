import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/feedback/data/dataModel/feedback_model.dart';
import 'package:way2fitlife/features/feedback/domain/repository/feedback_repository.dart';
import 'package:way2fitlife/usecase/usecase.dart';

class FeedbackDataUseCase extends UseCase<FeedbackModel, FeedbackDataParams> {
  FeedbackRepository feedbackRepository;

  FeedbackDataUseCase({this.feedbackRepository});

  @override
  Future<Either<Failure, FeedbackModel>> call(FeedbackDataParams params) async =>
      feedbackRepository.giveFeedbackData(subject: params.subject, msg: params.msg);
}

class FeedbackDataParams extends Equatable {
  final String subject;
  final String msg;

  FeedbackDataParams({this.subject, this.msg});

  @override
  List<Object> get props => [subject, msg];
}

class FeedbackButtonStatusUseCase extends UseCase<ErrorStatusModel, FeedbackButtonStatusParams> {
  FeedbackRepository feedbackRepository;

  FeedbackButtonStatusUseCase({this.feedbackRepository});

  @override
  Future<Either<Failure, ErrorStatusModel>> call(FeedbackButtonStatusParams params) async {
    return await feedbackRepository.getFeedbackButtonStatusData(
      subjectValid: params.subjectValid,
      messageValid: params.messageValid,
      subMsg: params.subMsg,
      msgMsg: params.msgMsg,
    );
  }
}

class FeedbackButtonStatusParams extends Equatable {
  final bool subjectValid;
  final bool messageValid;
  final String subMsg;
  final String msgMsg;

  FeedbackButtonStatusParams({this.subjectValid, this.messageValid, this.subMsg, this.msgMsg});

  @override
  List<Object> get props => [subjectValid, messageValid, subMsg, msgMsg];
}
