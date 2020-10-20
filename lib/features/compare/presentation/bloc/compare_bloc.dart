import 'package:way2fitlife/features/compare/domain/usecase/compare_usecase.dart';
import 'package:way2fitlife/features/compare/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompareBloc extends Bloc<CompareEvent, CompareState> {
  GetCompareDataUseCase getCompareDataUseCase;
  SetCompareDataUseCase setCompareDataUseCase;
  CompareWeightUseCase weightUseCase;
  ComparePhotoUseCase photoUseCase;
  CompareDateUseCase dateUseCase;

  CompareBloc({
    this.getCompareDataUseCase,
    this.setCompareDataUseCase,
    this.dateUseCase,
    this.photoUseCase,
    this.weightUseCase,
  }) : super(InitialCompareState());

  @override
  Stream<CompareState> mapEventToState(CompareEvent event) async* {
    if (event is GetComparePhotoDataEvent) {
      yield LoadingBeginHomeState();
      final result = await getCompareDataUseCase(GetCompareDataParmas(offSet: event.offSet));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetComparePhotoDataState(data: success),
      );
    }
    if (event is GetComparePhotoNextPageDataEvent) {
      yield LoadingBeginNextPageState();
      final result = await getCompareDataUseCase(GetCompareDataParmas(offSet: event.offSet));
      yield LoadingEndNextPageState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetComparePhotoDataState(data: success),
      );
    }

    if (event is SetCompareDataEvent) {
      final result = await setCompareDataUseCase(SetCompareDataParams(
        beforeImage: event.beforeImage,
        afterImage: event.afterImage,
        beforeDate: event.beforeDate,
        afterDate: event.afterDate,
        beforeWeight: event.beforeWeight,
        afterWeight: event.afterWeight,
      ));
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => SetComparePhotoDataState(data: success),
      );
    }

    if (event is GetComparePhotoEvent) {
      yield LoadingBeginHomeState();
      final result = await photoUseCase(CompareImageParams(
        image: event.image,
        pic: event.pic,
      ));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetComparePhotoState(imageModel: success),
      );
    }
    if (event is GetCompareWeightEvent) {
      yield LoadingBeginHomeState();
      final result = await weightUseCase(CompareWeightParams(
        weight: event.weight,
        pic: event.pic,
      ));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetCompareWeightState(weightModel: success),
      );
    }
    if (event is GetCompareDateEvent) {
      yield LoadingBeginHomeState();
      final result = await dateUseCase(CompareDateParams(
        dateTime: event.dateTime,
        pic: event.pic,
      ));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetCompareDateState(dateTimeModel: success),
      );
    }
  }
}
