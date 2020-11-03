abstract class ChangePasswordEvent {}

class ChangePasswordBtnStatus extends ChangePasswordEvent {
  final String current_password;
  final String new_password;
  final String confirm_password;

  ChangePasswordBtnStatus(
      {this.current_password, this.new_password, this.confirm_password});
}

class ChangePasswordCompleteEvent extends ChangePasswordEvent {
  final String current_password;
  final String new_password;

  ChangePasswordCompleteEvent({this.current_password, this.new_password});
}
