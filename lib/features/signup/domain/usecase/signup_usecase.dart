import 'package:way2fitlife/features/signup/domain/repository/signup_repository.dart';

class SignUpUseCase {
  SignUpRepository signUpRepository;

  SignUpUseCase({this.signUpRepository});

  String call() => signUpRepository.getSignUpData();
}

class SignUpEmailUseCase {
  SignUpRepository signUpRepository;

  SignUpEmailUseCase({this.signUpRepository});

  String call() => signUpRepository.getSignUpEmailData();
}

class SignUpPasswordUseCase {
  SignUpRepository signUpRepository;

  SignUpPasswordUseCase({this.signUpRepository});

  String call() => signUpRepository.getSignUpPasswordData();
}
class SignUpGenderUseCase {
  SignUpRepository signUpRepository;

  SignUpGenderUseCase({this.signUpRepository});

  bool call() => signUpRepository.getSignUpGenderData();
}

class SignUpButtonStatusUseCase {
  SignUpRepository signUpRepository;

  SignUpButtonStatusUseCase({this.signUpRepository});

  bool call() => signUpRepository.getSignUpButtonStatusData();
}
