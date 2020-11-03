import 'package:way2fitlife/features/forget_password/data/datamodel/forogt_password_data_model.dart';

abstract class ForgotPasswordDataResourse {
  Future<ForgotPasswordDataModel> fotgotPassword({String email});
}
