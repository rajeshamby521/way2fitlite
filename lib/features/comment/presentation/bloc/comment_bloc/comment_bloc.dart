import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/features/comment/domian/usecase/comment_use_case.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/comment_bloc/comment_event.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/comment_bloc/comment_state.dart';

class CommentBloc extends Bloc<CommnetEvent, CommentState> {
  ForumDetailsUseCase forumDetailsUseCase;

  CommentBloc({this.forumDetailsUseCase}) : super(CommentIntialState());

  @override
  Stream<CommentState> mapEventToState(CommnetEvent event) async* {
    if (event is ForumDetailEvent) {
      String id = event.forum_id;

      yield CommentLoadingBeginState();

      final result =
          await forumDetailsUseCase(ForumDetailsUseCaseParams(forum_id: id));

      yield CommentLoadingEndState();

      yield result.fold(
          (error) => CommentErrorState(msg: error.runtimeType.toString()),
          (result) => ForumDetaislState(model: result));
    }
  }
}
