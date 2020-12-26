import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general/date_time_format.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/set_weight_data_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/weight_sheet_model.dart';
import 'package:way2fitlife/features/weight_sheet/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/weight_sheet/presentation/widget/weight_sheet_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';

class WeightSheetScreen extends StatefulWidget {
  Bloc bloc;

  WeightSheetScreen({this.bloc});

  @override
  _WeightSheetScreenState createState() => _WeightSheetScreenState();
}

class _WeightSheetScreenState extends State<WeightSheetScreen> {
  final bloc = getIt<WeightSheetBloc>();
  WeightSheetModel weightSheetDataList;
  SetWeightDataModel setWeightDataModel;
  bool isLoading = true;
  bool isPageLoading = false;
  int offSet = 0;
  List<Datum> weightList = List<Datum>();

  @override
  void initState() {
    bloc.add(GetWeightSheetEvent(offSet: offSet));

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
        if (state is GetWeightSheetState ||
            state is GetWeightSheetNextPageState) {
          weightSheetDataList = state.data;
          weightList.addAll(weightSheetDataList.data);
        }
        if (state is SetWeightSheetState) {
          setWeightDataModel = state.data;
          String day = state.data.data.date.day < 10
              ? "0${state.data.data.date.day.toString()}"
              : state.data.data.date.day.toString();
          String month = state.data.data.date.month < 10
              ? "0${state.data.data.date.month.toString()}"
              : state.data.data.date.month.toString();
          String year = state.data.data.date.year.toString();
          String weight = state.data.data.weight != "0"
              ? state.data.data.weight + " kg"
              : "60 kg";

          bool isAlready = false;

          weightList.forEach((element) {
            if (DateFormat('MMMM , yyyy', 'en_US')
                        .parse(element.createDate)
                        .month ==
                    state.data.data.date.month &&
                DateFormat('MMMM , yyyy', 'en_US')
                        .parse(element.createDate)
                        .year ==
                    state.data.data.date.year) isAlready = true;
          });

          weightList.forEach((element) {
            if (DateFormat('MMMM , yyyy', 'en_US')
                        .parse(element.createDate)
                        .month ==
                    state.data.data.date.month &&
                DateFormat('MMMM , yyyy', 'en_US')
                        .parse(element.createDate)
                        .year ==
                    state.data.data.date.year) {
              weightList[weightList.indexOf(element)].weightData.add(
                  WeightDatum(
                      weight: weight,
                      date: day + "-" + month + "-" + year,
                      weightId: state.data.data.weightId));
            }
          });

          if (!isAlready) {
            weightList.insert(
              0,
              Datum(
                weightData: [
                  WeightDatum(
                    weight: weight,
                    date: day + "-" + month + "-" + year,
                    weightId: state.data.data.weightId,
                  ),
                ],
                createDate: dateFormat(
                    dateTime: state.data.data.date, format: 'MMMM , yyyy'),
              ),
            );
          }

          Fluttertoast.showToast(msg: setWeightDataModel.msg);
        }
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (BuildContext context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: appbar(
                  bloc: widget.bloc, title: weightSheet, context: context),
              body: Container(
                  // decoration: boxDecoration(
                  //   image: bg_bmi_screen,
                  //   color: veryLightTheme,
                  //   colorFilter: ColorFilter.mode(black.withOpacity(1), BlendMode.dstATop),
                  // ),
                  child: isLoading
                      ? circularProgressIndicator
                      : _createListView()),
              floatingActionButton: extendedFloatingButton(
                context: context,
                bloc: bloc,
                icon: Icons.add,
                label: add,
                iconLabelColor: white,
                backgroundColor: headerColor,
                dialogContent: AddWeightData(bloc: bloc),
              ),
              bottomSheet: isPageLoading
                  ? Container(height: 40, child: circularProgressIndicator)
                  : null,
            ),
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
        offSet = weightSheetDataList.nextOffset;
        if (offSet != -1) {
          bloc.add(GetWeightSheetNextPageEvent(offSet: offSet));
        }
      }
    });
    return ListView.builder(
      controller: _scrollController,
      itemCount: weightList.length,
      itemBuilder: (BuildContext context, int index) {
        return weightSheetListItem(
          dateTime: weightList[index].createDate,
          weightList: weightList[index].weightData,
        );
      },
    );
  }
}
