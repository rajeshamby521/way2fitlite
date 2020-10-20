import 'package:meta/meta.dart';

@immutable
abstract class DrawerState {}

class InitialDrawerState extends DrawerState {}

class LoadingBeginHomeState extends DrawerState {}

class LoadingEndHomeState extends DrawerState {}

class ErrorState extends DrawerState {
  final String message;

  ErrorState(this.message);
}

class FetchSelectPageState extends DrawerState {
  int pageNo;

  FetchSelectPageState({this.pageNo});
}
