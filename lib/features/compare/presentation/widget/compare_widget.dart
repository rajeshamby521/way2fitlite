import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/date_time_format.dart';
import 'package:way2fitlife/common/general/view_image.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/compare/presentation/bloc/bloc.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

Widget dateLabel({String label}) => labels(text: label, color: theme);

Widget weightLabel({String label}) =>
    labels(text: "$weight_kg $label", color: green800);

Widget listItem({
  String dateTime1,
  String dateTime2,
  String weight1,
  String weight2,
  String image1,
  String image2,
}) =>
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: item(image: image1, dateTime: dateTime1, weight: weight1)),
        Expanded(
            child: item(image: image2, dateTime: dateTime2, weight: weight2)),
      ],
    );

class item extends StatelessWidget {
  String dateTime;
  String weight;
  String image;

  item({this.dateTime, this.weight, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.3,
      child: Card(
        color: white,
        elevation: 20,
        shadowColor: iconColor,
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  child: image != null
                      ? GestureDetector(
                          child: Image.network(image, fit: BoxFit.fill),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ViewImage(
                                      image: image,
                                    )));
                          },
                        )
                      : imageAsset(img: bg_food_eat),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: dateLabel(label: dateTime),
              ),
              weightLabel(label: weight),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPhotoData extends StatelessWidget {
  Bloc bloc;

  AddPhotoData({this.bloc});

  DateTime dateTime1 = DateTime.now();
  DateTime dateTime2 = DateTime.now();
  File image1;
  File image2;
  double weight1 = 60;
  double weight2 = 60;
  bool img1 = false;
  bool img2 = false;
  final picker = ImagePicker();

  Future _imgFromGallery(int i) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (i == 1) {
        image1 = File(pickedFile.path);
        bloc.add(GetComparePhotoEvent(image: image1, pic: i));
      } else {
        image2 = File(pickedFile.path);
        bloc.add(GetComparePhotoEvent(image: image2, pic: i));
      }
    } else {
      Fluttertoast.showToast(msg: 'errororr');
    }
  }

  Future _imgFromCamera(int i) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      if (i == 1) {
        image1 = File(pickedFile.path);
        bloc.add(GetComparePhotoEvent(image: image1, pic: i));
      } else {
        image2 = File(pickedFile.path);
        bloc.add(GetComparePhotoEvent(image: image2, pic: i));
      }
    } else {
      Fluttertoast.showToast(msg: 'errororr');
    }
  }

  void _showPicker(context, int pos) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () async {
                        pos == 1
                            ? await _imgFromGallery(pos)
                            : await _imgFromGallery(pos);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () async {
                      pos == 1
                          ? await _imgFromCamera(pos)
                          : await _imgFromCamera(pos);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (BuildContext context, state) {
        // if (state is GetCompareWeight1State) weight1 = state.weight;
        if (state is GetCompareWeightState) {
          state.weightModel.pic == 1
              ? weight1 = state.weightModel.weight
              : weight2 = state.weightModel.weight;
        }
        // if (state is GetCompareDate1State) dateTime1 = state.dateTime;
        if (state is GetCompareDateState) {
          state.dateTimeModel.pic == 1
              ? dateTime1 = state.dateTimeModel.dateTime
              : dateTime2 = state.dateTimeModel.dateTime;
        }
        // if (state is GetComparePhoto1State) image1 = state.image;
        if (state is GetComparePhotoState) {
          state.imageModel.pic == 1
              ? image1 = state.imageModel.image
              : image2 = state.imageModel.image;
        }
        if (image1 != null) img1 = true;
        if (image2 != null) img2 = true;
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (BuildContext context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              labels(text: addPhoto, color: theme, size: 22),
              verticalSpace(height * 0.01),
              Row(
                children: [
                  Expanded(
                    child: selection(
                      context: context,
                      weight: weight1,
                      dateTime: dateTime1,
                      image: image1,
                      select: 1,
                    ),
                  ),
                  Container(
                    child: VerticalDivider(
                      color: lightTheme,
                      thickness: 2,
                    ),
                    height: height * 0.4,
                  ),
                  Expanded(
                    child: selection(
                      context: context,
                      weight: weight2,
                      dateTime: dateTime2,
                      image: image2,
                      select: 2,
                    ),
                  ),
                ],
              ),
              submitButton(
                text: submit,
                textColor: white,
                disable: false,
                onPressed: () {
                  if (img1 && img2) {
                    print('img1-->${image1.toString()}');
                    print('img2-->${image2.toString()}');
                    bloc.add(SetCompareDataEvent(
                      beforeDate: dateTime1.toString(),
                      beforeWeight: weight1.toString(),
                      beforeImage: image1,
                      afterDate: dateTime2.toString(),
                      afterWeight: weight2.toString(),
                      afterImage: image2,
                    ));
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget selection({
    BuildContext context,
    File image,
    DateTime dateTime,
    double weight,
    int select,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: decoratedContainer(
            child: Container(
              height: height * 0.17,
              width: height * 0.14,
              child: image != null
                  ? imageFile(img: image)
                  : icons(
                      size: height * 0.1, icon: Icons.camera_alt, color: grey),
            ),
          ),
          onTap: () {
            _showPicker(context, select);
          },
        ),
        verticalSpace(height * 0.01),
        image == null
            ? Padding(
                padding: EdgeInsets.all(height * 0.005),
                child: labels(text: selectImage, color: red, size: 10))
            : Container(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: InkWell(
            child: decoratedContainer(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.08, vertical: height * 0.01),
                child: labels(
                  text: dateFormat(dateTime: dateTime, format: 'dd MMM yyyy'),
                  color: theme,
                  size: height * 0.015,
                ),
              ),
            ),
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980, 1),
                lastDate: DateTime.now(),
              ).then((value) {
                bloc.add(
                  GetCompareDateEvent(
                      dateTime: value == null ? DateTime.now() : value,
                      pic: select),
                );
              });
            },
          ),
        ),
        pickerWithLabel(
          labelText: weight_kg,
          measure: kg,
          startValue: 10,
          endValue: 150,
          initialItem: 50,
          onItemChanged: (val) {
            double weight = double.parse((val + 10).toString());
            bloc.add(
              GetCompareWeightEvent(weight: weight, pic: select),
            );
          },
        ),
        verticalSpace(height * 0.01),
      ],
    );
  }
}
