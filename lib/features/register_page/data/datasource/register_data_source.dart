import 'package:way2fitlife/features/login/data/datamodel/login_model.dart';
import 'package:way2fitlife/features/register_page/data/datamodel/register_data_model.dart';

abstract class RegisterDataSource {
  Future<RegisterDataModel> getRegisterData();
  Future<LogInModel> sendRegisterData({
    RegisterDataModel registermodel,
  });
}
