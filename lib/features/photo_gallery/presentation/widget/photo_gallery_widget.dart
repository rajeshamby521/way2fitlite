import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/date_time_format.dart';
import 'package:way2fitlife/common/general/view_image.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/photo_gallery/presentation/bloc/bloc.dart';
import 'package:way2fitlife/main.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

Widget dateLabel({String label}) => labels(text: label, color: theme);

Widget weightLabel({String label}) =>
    labels(text: "$weight_kg $label", color: green800);

class listItem extends StatelessWidget {
  String date;
  String weight;
  String image;

  listItem({this.date, this.weight, this.image});

  @override
  Widget build(BuildContext context) {
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
                    ? GestureDetector(
                        child: imageNetwork(img: image),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ViewImage(
                                    image: image,
                                  )));
                        },
                      )
                    : Container(),
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
}

class AddPhotoData extends StatefulWidget {
  Bloc bloc;

  AddPhotoData({this.bloc});

  @override
  _AddPhotoDataState createState() => _AddPhotoDataState();
}

class _AddPhotoDataState extends State<AddPhotoData> {
  DateTime dateTime = DateTime.now();

  File image;

  double weight;

  bool img = false;

  final picker = ImagePicker();

  final _controller = NativeAdmobController();

  Future _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) image = File(pickedFile.path);
    widget.bloc.add(GetPhotoGalleryPhotoEvent(image: image));
  }

  Future _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) image = File(pickedFile.path);
    widget.bloc.add(GetPhotoGalleryPhotoEvent(image: image));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () async {
                      image = await _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () async {
                      image = await _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    FacebookAudienceNetwork.init(
      testingId: "b9f2908b-1a6b-4a5b-b862-ded7ce289e41",
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: widget.bloc,
      listener: (BuildContext context, state) {
        if (state is GetPhotoGalleryWeightState) weight = state.weight;
        if (state is GetPhotoGalleryDateState) dateTime = state.dateTime;
        if (state is GetPhotoGalleryPhotoState) image = state.image;
        img = image == null ? false : true;
      },
      child: BlocBuilder(
        cubit: widget.bloc,
        builder: (BuildContext context, state) {
          return SingleChildScrollView(
            child: Column(
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
                          : icons(
                              size: height * 0.1,
                              icon: Icons.camera_alt,
                              color: grey),
                    ),
                  ),
                  onTap: () {
                    _showPicker(context);
                  },
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
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.08, vertical: height * 0.01),
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
                      firstDate: DateTime(1980, 1),
                      lastDate: DateTime.now(),
                    ).then((value) => widget.bloc.add(GetPhotoGalleryDateEvent(
                        dateTime: value == null ? DateTime.now() : value)));
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
                    widget.bloc.add(GetPhotoGalleryWeightEvent(
                        weight: double.parse((val + 10).toString())));
                  },
                ),
                verticalSpace(height * 0.01),
                submitButton(
                  text: submit,
                  textColor: white,
                  disable: false,
                  onPressed: () {
                    if (img) {
                      widget.bloc.add(
                        SetPhotoGalleryDataEvent(
                          date: dateTime.toString(),
                          weight: weight != null ? weight.toString() : "60",
                          image: image,
                        ),
                      );
                      if (isInterstitialReady) interstitialAd.show();
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
