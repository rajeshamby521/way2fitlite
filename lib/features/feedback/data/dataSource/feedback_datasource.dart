import 'package:way2fitlife/features/feedback/data/dataModel/feedback_model.dart';

abstract class FeedbackDataSource {
  Future<FeedbackModel> giveFeedbackData({String subject, String msg});

  Future<ErrorStatusModel> getFeedbackButtonStatusData(
      {bool subjectValid, bool messageValid, String subMsg, String msgMsg});
}
