import 'package:way2fitlife/features/forum/data/datamodel/add_forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/datamodel/forum_data_model.dart';

abstract class ForumDataResourse {
  Future<ForumDataModel> getData({int offSet});
  Future<AddForumDataModel> addForumData(
      {String topic, String title, String desc});
}
