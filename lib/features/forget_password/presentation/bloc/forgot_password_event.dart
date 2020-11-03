abstract class ForgotPasswordEvent {}

class ForgotPasswordBtnEvent extends ForgotPasswordEvent {
  String email;

  ForgotPasswordBtnEvent({this.email});
}

class ForgotPasswordCompleteEvent extends ForgotPasswordEvent {
  String email;

  ForgotPasswordCompleteEvent({this.email});
}
