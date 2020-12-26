import 'package:way2fitlife/features/drawer/domain/usecases/drawer_usecase.dart';
import 'package:way2fitlife/features/drawer/presentation/bloc/drawer_event.dart';
import 'package:way2fitlife/features/drawer/presentation/bloc/drawer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerUseCase drawerUseCase;

  DrawerBloc({this.drawerUseCase}) : super(InitialDrawerState());

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    if (event is FetchSelectPageEvent) {
      yield LoadingBeginHomeState();
      final result = await drawerUseCase(DrawerParams(pageNo: event.pageNo));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => FetchSelectPageState(pageNo: success),
      );
    }else if(event is ShowAdEvent){
      yield ShowAdState();
    }
  }
}
