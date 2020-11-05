import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/general/buttons.dart';
import 'package:way2fitlife/common/general/date_time_format.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/weight_sheet_model.dart';
import 'package:way2fitlife/features/weight_sheet/presentation/bloc/bloc.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

Widget weightSheetListItem({String dateTime, List<WeightDatum> weightList}) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: labels(text: dateTime),
        ),
        weightDataList(weightList),
      ],
    ),
  );
}

Widget weightDataList(List<WeightDatum> list) {
  list.sort((a, b) => a.date.compareTo(b.date));
  return ListView.builder(
    shrinkWrap: true,
    itemCount: list.length,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 3)],
            color: white,
            // gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Align(
              child: labels(text: list[index].date),
              alignment: Alignment.centerLeft,
            ),
            dense: true,
            trailing: labels(text: "$weight_kg ${list[index].weight}"),
          ),
        ),
      );
    },
  );
}

class AddWeightData extends StatelessWidget {
  Bloc bloc;

  AddWeightData({this.bloc});

  DateTime dateTime = DateTime.now();
  double weight;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (BuildContext context, state) {
        if (state is LoadingBeginHomeState)
          isLoading = true;
        else if (state is LoadingEndHomeState)
          isLoading = false;
        else if (state is GetWeightState)
          weight = state.weight;
        else if (state is GetDateState) dateTime = state.dateTime;
      },
      child: BlocBuilder(
        cubit: bloc,
        builder: (BuildContext context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                  ).then((value) {
                    bloc.add(GetDateEvent(
                        dateTime: value == null ? DateTime.now() : value));
                  });
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
                  bloc.add(GetWeightEvent(
                      weight: double.parse((val + 10).toString())));
                },
              ),
              verticalSpace(height * 0.01),
              submitButton(
                text: submit,
                textColor: white,
                disable: false,
                onPressed: () {
                  bloc.add(SetWeightSheetEvent(
                      date: dateTime.toString(),
                      weight: weight.toString() ?? 60));
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
