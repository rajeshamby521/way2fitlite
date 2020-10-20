import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/compare/data/dataModel/compare_model.dart';
import 'package:way2fitlife/features/compare/data/dataModel/set_compare_data_model.dart';
import 'package:way2fitlife/features/compare/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/compare/presentation/widget/compare_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CompareScreen extends StatefulWidget {
  Bloc bloc;

  CompareScreen({this.bloc});

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  final bloc = getIt<CompareBloc>();
  ComparePhotoDataModel list;
  List<Datum> comparePhotoList = List<Datum>();
  Datum2 setCompareData = Datum2();
  int offSet = 0;
  bool isLoading = true;
  bool isPageLoading = false;

  @override
  void initState() {
    bloc.add(GetComparePhotoDataEvent(offSet: offSet));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (BuildContext context, state) {
        if (state is LoadingBeginHomeState) isLoading = true;
        if (state is LoadingEndHomeState) isLoading = false;
        if (state is LoadingBeginNextPageState) isPageLoading = true;
        if (state is LoadingEndNextPageState) isPageLoading = false;
        if (state is GetComparePhotoDataState || state is GetComparePhotoNextPageDataState) {
          list = state.data;
          comparePhotoList.addAll(list.data);
        }
        if (state is SetComparePhotoDataState) {
          setCompareData = state.data.data[0];
          print(" NEW PHOTO :---  ${setCompareData}");
          comparePhotoList.insert(
            0,
            Datum(
              userBeforePhoto: setCompareData.userBeforePhoto,
              userAfterPhoto: setCompareData.userAfterPhoto,
              beforeWeight: setCompareData.beforeWeight,
              afterWeight: setCompareData.afterWeight,
              beforeDate: setCompareData.beforeDate,
              afterDate: setCompareData.afterDate,
            ),
          );

          Fluttertoast.showToast(msg: state.data.msg);
        }
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: appbar(bloc: widget.bloc, context: context, title: compare),
            floatingActionButton: extendedFloatingButton(
              context: context,
              bloc: bloc,
              icon: Icons.add,
              label: add,
              backgroundColor: headerColor,
              iconLabelColor: white,
              dialogContent: AddPhotoData(bloc: bloc),
            ),
            body: isLoading || comparePhotoList.length == null
                ? circularProgressIndicator
                : SafeArea(child: _createListView()),
            bottomSheet:
                isPageLoading ? Container(height: 40, child: circularProgressIndicator) : null,
          );
        },
      ),
    );
  }

  Widget _createListView() {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        offSet = list.nextOffset;
        print("+++ $offSet");
        if (offSet != -1) {
          bloc.add(GetComparePhotoNextPageDataEvent(offSet: offSet));
        }
      }
    });
    return ListView.separated(
      controller: _scrollController,
      itemCount: comparePhotoList.length,
      itemBuilder: (context, index) {
        return listItem(
          image1: comparePhotoList[index].userBeforePhoto,
          image2: comparePhotoList[index].userAfterPhoto,
          weight1: comparePhotoList[index].beforeWeight,
          weight2: comparePhotoList[index].afterWeight,
          dateTime1: comparePhotoList[index].beforeDate,
          dateTime2: comparePhotoList[index].afterDate,
        );
      },
      separatorBuilder: (context, index) => listDivider(padding: 10),
    );
  }
}
