import 'package:dio/dio.dart';
import 'package:way2fitlife/features/forum/data/datamodel/add_forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/datamodel/forum_data_model.dart';
import 'package:way2fitlife/features/forum/data/dataresourse/forum_data_resourse.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference_util.dart';class ForumDataResouseIml extends ForumDataResourse {
  Dio dio = Dio(options);
  ForumDataModel forumDataModel;
  AddForumDataModel addForumDataModel;

  @override
  Future<ForumDataModel> getData({int offSet}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreferenceUtil().readString(user_id);
    map[access_token] = AppPreferenceUtil().readString(access_token);
    map[lang] = "0";
    map[offset] = offSet.toString();

    Response response =
        await dio.post(ForumListURL, data: FormData.fromMap(map));
    print("ForumDatamodel---->${response.data}");
    forumDataModel = forumDataModelFromJson(response.data);

    return forumDataModel;
  }

  @override
  Future<AddForumDataModel> addForumData(
      {String topic, String title, String desc}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreferenceUtil().readString(user_id);
    map[access_token] = AppPreferenceUtil().readString(access_token);
    map[lang] = "0";
    map[forum_topic] = topic ?? " ";
    map[forum_title] = title ?? " ";
    map[description] = desc ?? " ";

    Response response =
        await dio.post(AddForumURL, data: FormData.fromMap(map));
    print("add forum--->${response.data}");
    addForumDataModel = addForumDataModelFromJson(response.data);

    return addForumDataModel;
  }
}
