import 'package:way2fitlife/features/photo_gallery/domain/usecase/photo_gallery_usecase.dart';
import 'package:way2fitlife/features/photo_gallery/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoGalleryBloc extends Bloc<PhotoGalleryEvent, PhotoGalleryState> {
  PhotoGalleryDataUseCase photoGalleryDataUseCase;
  SetPhotoGalleryDataUseCase setPhotoGalleryDataUseCase;
  PhotoGalleryWeightUseCase weightUseCase;
  PhotoGalleryPhotoUseCase photoUseCase;
  PhotoGalleryDateUseCase dateUseCase;

  PhotoGalleryBloc({
    this.photoGalleryDataUseCase,
    this.setPhotoGalleryDataUseCase,
    this.dateUseCase,
    this.weightUseCase,
    this.photoUseCase,
  }) : super(InitialPhotoGalleryState());

  @override
  Stream<PhotoGalleryState> mapEventToState(PhotoGalleryEvent event) async* {
    if (event is GetPhotoGalleryDataEvent) {
      yield LoadingBeginHomeState();
      final result = await photoGalleryDataUseCase(PhotoGalleryDataParams(offSet: event.offSet));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetPhotoGalleryDataState(data: success),
      );
    }
    if (event is GetPhotoGalleryNextPageDataEvent) {
      yield LoadingBeginNextPageState();
      final result = await photoGalleryDataUseCase(PhotoGalleryDataParams(offSet: event.offSet));
      yield LoadingEndNextPageState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetPhotoGalleryNextPageDataState(data: success),
      );
    }
    if (event is SetPhotoGalleryDataEvent) {
      final result = await setPhotoGalleryDataUseCase(SetPhotoGalleryDataParams(
        date: event.date,
        weight: event.weight,
        image: event.image,
      ));
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => SetPhotoGalleryDataState(data: success),
      );
    }

    if (event is GetPhotoGalleryPhotoEvent) {
      yield LoadingBeginHomeState();
      final result = await photoUseCase(PhotoGalleryPhotoParams(image: event.image));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetPhotoGalleryPhotoState(image: success),
      );
    }
    if (event is GetPhotoGalleryWeightEvent) {
      yield LoadingBeginHomeState();
      final result = await weightUseCase(PhotoGalleryWeightParams(weight: event.weight));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetPhotoGalleryWeightState(weight: success),
      );
    }
    if (event is GetPhotoGalleryDateEvent) {
      yield LoadingBeginHomeState();
      final result = await dateUseCase(PhotoGalleryDateParams(dateTime: event.dateTime));
      yield LoadingEndHomeState();
      yield result.fold(
        (error) => ErrorState(error.message),
        (success) => GetPhotoGalleryDateState(dateTime: success),
      );
    }
  }
}
