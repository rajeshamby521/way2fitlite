import 'dart:io';

abstract class CompareEvent {}

class SetCompareDataEvent extends CompareEvent {
  File beforeImage;
  File afterImage;
  String beforeWeight;
  String afterWeight;
  String beforeDate;
  String afterDate;

  SetCompareDataEvent({
    this.beforeImage,
    this.afterImage,
    this.beforeWeight,
    this.afterWeight,
    this.beforeDate,
    this.afterDate,
  });
}

class GetComparePhotoDataEvent extends CompareEvent {
  int offSet;

  GetComparePhotoDataEvent({this.offSet});
}
class GetComparePhotoNextPageDataEvent extends CompareEvent {
  int offSet;

  GetComparePhotoNextPageDataEvent({this.offSet});
}

class GetComparePhotoEvent extends CompareEvent {
  File image;
  int pic;

  GetComparePhotoEvent({this.image, this.pic});
}

class GetCompareWeightEvent extends CompareEvent {
  double weight;
  int pic;

  GetCompareWeightEvent({this.weight, this.pic});
}

class GetCompareDateEvent extends CompareEvent {
  DateTime dateTime;
  int pic;

  GetCompareDateEvent({this.dateTime, this.pic});
}
