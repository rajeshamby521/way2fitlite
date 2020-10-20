import 'package:meta/meta.dart';

@immutable
abstract class DashboardState {}

class InitialDashboardState extends DashboardState {}

class LoadingBeginHomeState extends DashboardState {}

class LoadingEndHomeState extends DashboardState {}

class ErrorState extends DashboardState {
  final String message;

  ErrorState(this.message);
}


class FetchPageState extends DashboardState {
  final int pageNo;

  FetchPageState({@required this.pageNo});
}
class AnimatePageState extends DashboardState {
  final bool animate;

  AnimatePageState({@required this.animate});
}
