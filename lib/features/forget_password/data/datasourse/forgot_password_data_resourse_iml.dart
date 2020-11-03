import 'package:dio/dio.dart';
import 'package:way2fitlife/features/forget_password/data/datamodel/forogt_password_data_model.dart';
import 'package:way2fitlife/features/forget_password/data/datasourse/forgot_password_data_resourse.dart';
import 'package:way2fitlife/network/api_provider.dart';
import 'package:way2fitlife/network/api_strings.dart';

class ForgotPasswordDataResourseIml extends ForgotPasswordDataResourse {
  Dio dio = Dio(options);
  ForgotPasswordDataModel forgotPasswordDataModel;

  @override
  Future<ForgotPasswordDataModel> fotgotPassword({String email}) async {
    Map<String, dynamic> map = Map();
    map[lang] = "0";
    map[emailID] = email ?? "";

    Response response =
        await dio.post(ForgotPasswordURL, data: FormData.fromMap(map));

    print("ForogotPassword--->${response.data}");
    forgotPasswordDataModel = forgotPasswordDataModelFromJson(response.data);
    //print("ForogotPassword--->${forgotPasswordDataModel.msg}");

    return forgotPasswordDataModel;
  }
}
