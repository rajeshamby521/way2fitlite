import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';
import 'package:way2fitlife/features/update_user_data/data/datamodel/change_password_data_model.dart';

abstract class UpdateUserDataResourse {
  Future<LogInModel> updateUserData({RegisterDataModel registerDataModel});

  Future<ChangePasswordDataModel> changePassword(
      {String c_pass, String n_pass});
}
