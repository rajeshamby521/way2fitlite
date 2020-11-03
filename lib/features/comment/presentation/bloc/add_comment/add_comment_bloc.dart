import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/validation.dart';
import 'package:way2fitlife/features/comment/domian/usecase/comment_use_case.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_commnet_event.dart';
import 'package:way2fitlife/features/comment/presentation/bloc/add_comment/add_commnet_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  AddCommnetUseCase addCommentUseCase;

  AddCommentBloc({this.addCommentUseCase}) : super(AddCommentinitState());

  @override
  Stream<AddCommentState> mapEventToState(AddCommentEvent event) async* {
    if (event is AddCommentBtnEvent) {
      String commnetMsg = emptyValidationMsg(emptyField: event.commnet);
      bool valid = isEmptyValid(emptyField: commnetMsg);

      print('commnetmsg------------${valid}');
      yield AddCommentBtnState(
        staus: valid,
        commnetMsg: commnetMsg,
      );
    }
    if (event is AddCommentClickEvent) {
      final result = await addCommentUseCase(AddCommentUseCaseParams(
        comment: event.commnet,
      ));

      yield result.fold(
          (error) => AddCommnetErrorState(msg: error.runtimeType.toString()),
          (result) => AddCommentclickState(model: result));
    }
  }
}
