import 'dart:io';

import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/date_time_format.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/photo_gallery/presentation/bloc/bloc.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

Widget dateLabel({String label}) => labels(text: label, color: theme);

Widget weightLabel({String label}) => labels(text: "$weight_kg $label", color: green800);

Widget listItem({String date, String weight, String image}) {
  return Card(
    color: white,
    elevation: 20,
    shadowColor: green,
    margin: EdgeInsets.all(15),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              child: image != null && image.isNotEmpty
                  ? imageNetwork(img: image)
                  : imageAsset(img: bg_food_eat),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: dateLabel(label: date),
          ),
          weightLabel(label: weight.toString()),
        ],
      ),
    ),
  );
}

class AddPhotoData extends StatelessWidget {
  Bloc bloc;

  AddPhotoData({this.bloc});

  DateTime dateTime = DateTime.now();
  File image;
  double weight;
  bool img = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) image = File(pickedFile.path);
    bloc.add(GetPhotoGalleryPhotoEvent(image: image));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (BuildContext context, state) {
        if (state is GetPhotoGalleryWeightState) weight = state.weight;
        if (state is GetPhotoGalleryDateState) dateTime = state.dateTime;
        if (state is GetPhotoGalleryPhotoState) image = state.image;
        img = image == null ? false : true;
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
              InkWell(
                child: decoratedContainer(
                  child: Container(
                    height: height * 0.2,
                    width: height * 0.17,
                    child: img
                        ? imageFile(img: image)
                        : icons(size: height * 0.1, icon: Icons.camera_alt, color: grey),
                  ),
                ),
                onTap: getImage,
              ),
              verticalSpace(height * 0.01),
              !img
                  ? Padding(
                      padding: EdgeInsets.all(height * 0.005),
                      child: labels(text: selectImage, color: red))
                  : Container(),
              verticalSpace(height * 0.01),
              InkWell(
                child: decoratedContainer(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: width * 0.08, vertical: height * 0.01),
                    child: labels(
                      text: dateFormat(dateTime: dateTime),
                      color: theme,
                      size: height * 0.02,
                    ),
                  ),
                ),
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2050),
                  ).then((value) => bloc.add(GetPhotoGalleryDateEvent(dateTime: value)));
                },
              ),
              verticalSpace(height * 0.01),
              pickerWithLabel(
                labelText: weight_kg,
                measure: kg,
                startValue: 10,
                endValue: 150,
                initialItem: 50,
                onItemChanged: (val) {
                  bloc.add(GetPhotoGalleryWeightEvent(weight: double.parse((val + 10).toString())));
                },
              ),
              verticalSpace(height * 0.01),
              submitButton(
                text: submit,
                textColor: white,
                disable: false,
                onPressed: () {
                  if (img) {
                    bloc.add(
                      SetPhotoGalleryDataEvent(
                        date: dateTime.toString(),
                        weight: weight != null ? weight.toString() : "60",
                        image: image,
                      ),
                    );
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
}
