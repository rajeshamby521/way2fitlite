import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general/date_time_format.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/photo_gallery_model.dart';
import 'package:way2fitlife/features/photo_gallery/data/dataModel/set_photo_gallery_data_model.dart';
import 'package:way2fitlife/features/photo_gallery/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/photo_gallery/presentation/widget/photo_gallery_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class PhotoGalleryScreen extends StatefulWidget {
  Bloc bloc;

  PhotoGalleryScreen({this.bloc});

  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final bloc = getIt<PhotoGalleryBloc>();
  PhotoGalleryModel list = PhotoGalleryModel();
  SetPhotoGalleryDataModel setPhotoGalleryData;
  double weight;
  DateTime dateTime;
  bool isLoading = true;
  bool isPageLoading = false;
  int offSet = 0;
  List<Datum> photoList = List<Datum>();

  @override
  void initState() {
    bloc.add(GetPhotoGalleryDataEvent(offSet: offSet));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (BuildContext context, state) {
        if (state is GetPhotoGalleryDataState ||
            state is GetPhotoGalleryNextPageDataState) {
          list = state.data;
          photoList.addAll(state.data.data);
        }
        if (state is LoadingBeginHomeState) isLoading = true;
        if (state is LoadingEndHomeState) isLoading = false;
        if (state is LoadingBeginNextPageState) isPageLoading = true;
        if (state is LoadingEndNextPageState) isPageLoading = false;
        if (state is GetPhotoGalleryWeightState) weight = state.weight;
        if (state is GetPhotoGalleryDateState) dateTime = state.dateTime;
        if (state is SetPhotoGalleryDataState) {
          setPhotoGalleryData = state.data;
          String img = setPhotoGalleryData.data.userPhoto;
          String weight = setPhotoGalleryData.data.weight;
          DateTime date = DateFormat('yyyy-M-d', 'en_US')
              .parse(setPhotoGalleryData.data.date.toString());
          photoList.insert(
            0,
            Datum(
              userPhoto: img,
              weight: weight + " kg",
              date: dateFormat(
                dateTime: date,
                format: 'd MMMM, yyyy',
              ),
            ),
          );
          Fluttertoast.showToast(msg: setPhotoGalleryData.msg);
        }
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: appbar(
                bloc: widget.bloc, context: context, title: photoGallery),
            floatingActionButton: extendedFloatingButton(
              context: context,
              bloc: bloc,
              icon: Icons.add,
              label: add,
              backgroundColor: headerColor,
              iconLabelColor: white,
              dialogContent: AddPhotoData(bloc: bloc),
            ),
            body: SafeArea(
              child: Container(
                decoration: boxDecoration(
                  image: bg_home_screen,
                  colorFilter: ColorFilter.mode(
                      black.withOpacity(0.8), BlendMode.dstATop),
                ),
                child:
                    isLoading ? circularProgressIndicator : _createListView(),
              ),
            ),
            bottomSheet: isPageLoading
                ? Container(height: 40, child: circularProgressIndicator)
                : null,
          );
        },
      ),
    );
  }

  Widget _createListView() {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        offSet = list.nextOffset;
        if (offSet != -1) {
          bloc.add(GetPhotoGalleryNextPageDataEvent(offSet: offSet));
        }
      }
    });
    return GridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      children: List.generate(
        photoList.length,
        (index) => listItem(
          date: photoList[index].date,
          weight: photoList[index].weight,
          image: photoList[index].userPhoto,
        ),
      ),
    );
  }
}
