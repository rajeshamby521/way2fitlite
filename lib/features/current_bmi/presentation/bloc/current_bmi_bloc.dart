import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/current_bmi_usecase.dart';
import 'current_bmi_event.dart';
import 'current_bmi_state.dart';

bool enabel;

class CurrentBMIBloc extends Bloc<BmiEvent, BmiState> {
  CalculateBMIUseCase useCase;

  CurrentBMIBloc({this.useCase}) : super(null);
  @override
  Stream<BmiState> mapEventToState(BmiEvent event) async* {
    if (event is BmiDataFetchEvent) {
      double w = event.weight;
      double h = event.height;

      double result = useCase.calculateBMR(w, h);
      yield BmiDataState(result, enabel);
    } else {
      yield BmiErrorState(runtimeType.toString());
    }
  }
}
