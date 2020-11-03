import 'package:dio/dio.dart';
import 'package:way2fitlife/features/comment/data/datamodel/add_commmnet_model.dart';
import 'package:way2fitlife/features/comment/data/datamodel/forum_details_data_model.dart';
import 'package:way2fitlife/features/comment/data/dataresourse/comment_data_resourse.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';
import 'package:way2fitlife/utils/app_preference.dart';

class CommentDataResourseIml extends CommentDataResourse {
  ForumDetailDataModel forumDetailDataModel;
  AddCommnetModel addCommnetModel;
  Dio dio = Dio(options);

  @override
  Future<ForumDetailDataModel> getForumDetails({String id}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";
    map[forum_id] = id ?? "";

    Response response =
        await dio.post(ForumDetailsURL, data: FormData.fromMap(map));
    //print("forumDetails-->${response.data}");
    forumDetailDataModel = forumDetailDataModelFromJson(response.data);

    return forumDetailDataModel;
  }

  @override
  Future<AddCommnetModel> addComment({String commnet}) async {
    Map<String, dynamic> map = Map();
    map[user_id] = AppPreference.getString(user_id);
    map[access_token] = AppPreference.getString(access_token);
    map[lang] = "0";
    map[forum_id] = AppPreference.getString(forum_id);
    map[comment_text] = commnet ?? "";

    Response response =
        await dio.post(AddCommentURL, data: FormData.fromMap(map));
    print("commentDetails-->${response.data}");

    addCommnetModel = addCommnetModelFromJson(response.data);

    return addCommnetModel;
  }
}
