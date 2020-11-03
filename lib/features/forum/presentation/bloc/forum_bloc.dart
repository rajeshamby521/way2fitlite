import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/validation.dart';
import 'package:way2fitlife/features/forum/domain/usecase/forum_use_case.dart';
import 'package:way2fitlife/features/forum/presentation/bloc/bloc.dart';

class ForumBloc extends Bloc<ForumEvent, ForumState> {
  ForumfetchUseCase forumfetchUseCase;
  AddForumUseCase addForumUseCase;

  ForumBloc({this.forumfetchUseCase, this.addForumUseCase})
      : super(ForumInitialState());

  @override
  Stream<ForumState> mapEventToState(ForumEvent event) async* {
    if (event is ForumFetchEvent) {
      yield LoadingBeginHomeState();
      final result = await forumfetchUseCase(
          ForumFectDataUseCaseParams(offset: event.offset));
      yield LoadingEndHomeState();

      yield result.fold(
          (error) => ForumErrorState(msg: error.runtimeType.toString()),
          (result) => ForumFecthDataState(model: result));
    }
    if (event is ForumNextPageEvent) {
      yield LoadingBeginNextPageState();
      final result = await forumfetchUseCase(
          ForumFectDataUseCaseParams(offset: event.offset));
      yield LoadingEndNextPageState();
      yield result.fold(
          (error) => ForumErrorState(msg: error.runtimeType.toString()),
          (result) => ForumNextPageDataState(model: result));
    }
    if (event is AddForumBtnEvent) {
      String topicMsg = emptyValidationMsg(emptyField: event.topic);
      String titleMsg = emptyValidationMsg(emptyField: event.title);

      bool valid = (isEmptyValid(emptyField: topicMsg) &&
          isEmptyValid(emptyField: titleMsg));

      yield AddForumBtnState(
          status: valid, topicMsg: topicMsg, titleMsg: titleMsg);
    }
    if (event is AddForumEvent) {
      String topic = event.forum_topic;
      String title = event.forum_title;
      String dec = event.description;

      final result = await addForumUseCase(AddForumUseCaseParams(
        topic: topic,
        title: title,
        desc: dec,
      ));

      yield result.fold(
          (error) => ForumErrorState(msg: error.runtimeType.toString()),
          (result) => AddForumState(model: result));
    }
  }
}
