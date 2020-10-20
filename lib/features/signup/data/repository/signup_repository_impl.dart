import 'package:way2fitlife/features/signup/data/datasource/signup_datasource.dart';
import 'package:way2fitlife/features/signup/domain/repository/signup_repository.dart';

class SignUpRepositoryImpl extends SignUpRepository {
  SignUpDataSource signUpDataSource;

  SignUpRepositoryImpl({this.signUpDataSource});

  @override
  String getSignUpData() => signUpDataSource.getSignUpData();

  @override
  String getSignUpEmailData() => signUpDataSource.getSignUpEmailData();

  @override
  String getSignUpPasswordData() => signUpDataSource.getSignUpPasswordData();

  @override
  bool getSignUpButtonStatusData() => signUpDataSource.getSignUpButtonStatusData();

  @override
  bool getSignUpGenderData() => signUpDataSource.getSignUpGenderData();
}
