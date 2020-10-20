import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/feedback/data/dataModel/feedback_model.dart';
import 'package:way2fitlife/features/feedback/data/dataSource/feedback_datasource.dart';
import 'package:way2fitlife/features/feedback/domain/repository/feedback_repository.dart';

class FeedbackRepositoryImpl extends FeedbackRepository {
  FeedbackDataSource feedbackDataSource;

  FeedbackRepositoryImpl({this.feedbackDataSource});

  @override
  Future<Either<Failure, FeedbackModel>> giveFeedbackData({String subject, String msg}) async {
    final result = await feedbackDataSource.giveFeedbackData(subject: subject, msg: msg);
    return Right(result);
  }

  @override
  Future<Either<Failure, ErrorStatusModel>> getFeedbackButtonStatusData(
      {bool subjectValid, bool messageValid, String subMsg, String msgMsg}) async {
    final result = await feedbackDataSource.getFeedbackButtonStatusData(
        subjectValid: subjectValid, messageValid: messageValid, subMsg: subMsg, msgMsg: msgMsg);
    return Right(result);
  }
}
