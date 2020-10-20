import 'package:way2fitlife/features/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:way2fitlife/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:way2fitlife/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardAnimateUseCase dashboardAnimateUseCase;

  DashboardBloc({this.dashboardAnimateUseCase}) : super(InitialDashboardState());

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is AnimatePageEvent) {
      yield LoadingBeginHomeState();
      final result = await dashboardAnimateUseCase(DashboardAnimateParams(animate: event.animate));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => AnimatePageState(animate: success),
      );
    }
  }
}
