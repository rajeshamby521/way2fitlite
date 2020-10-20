import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/feedback/data/dataModel/feedback_model.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, FeedbackModel>> giveFeedbackData({String subject, String msg});

  Future<Either<Failure, ErrorStatusModel>> getFeedbackButtonStatusData(
      {bool subjectValid, bool messageValid, String subMsg, String msgMsg});
}
