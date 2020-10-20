abstract class LogInEvent {}

class GetLogInButtonStatusEvent extends LogInEvent {
  String email;
  String password;

  GetLogInButtonStatusEvent({this.email, this.password});
}

class GetLogInEvent extends LogInEvent {
  String email;
  String password;

  GetLogInEvent({this.email, this.password});
}
