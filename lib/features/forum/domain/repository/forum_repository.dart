import 'package:dartz/dartz.dart';
import 'package:way2fitlife/constants/status_objects.dart';
import 'package:way2fitlife/features/forum/data/datamodel/add_forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/datamodel/forum_data_model.dart';

abstract class ForumRepository {
  Future<Either<Failure, ForumDataModel>> getForumData({int offset});

  Future<Either<Failure, AddForumDataModel>> addForumData(
      {String topic, String title, String desc});
}
