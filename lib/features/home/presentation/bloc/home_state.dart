import 'package:meta/meta.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingBeginHomeState extends HomeState {}

class LoadingEndHomeState extends HomeState {}

class ErrorState extends HomeState {
  final String message;

  ErrorState(this.message);
}

class FetchHomeDataState extends HomeState {
  final List<String> modelData;

  FetchHomeDataState({@required this.modelData});
}
