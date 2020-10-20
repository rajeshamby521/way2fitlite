import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/chart/data/dataModel/chart_model.dart';
import 'package:way2fitlife/features/chart/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/chart/presentation/widget/chart_widget.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartScreen extends StatefulWidget {
  final Bloc bloc;

  ChartScreen({Key key, this.bloc});

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final bloc = getIt<ChartBloc>();
  ChartModel chartData;
  bool isLoading = true;

  @override
  void initState() {
    bloc.add(GetChartDataEvent(month: "", dateType: "1"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocListener(
        cubit: bloc,
        listener: (BuildContext context, state) {
          if (state is LoadingBeginChartState) isLoading = true;
          if (state is LoadingEndChartState) isLoading = false;
          if (state is GetChartDataState) {
            chartData = state.data;
            print(chartData.toMap().toString());
          }
        },
        child: BlocBuilder(
          cubit: bloc,
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: appbar(bloc: widget.bloc, context: context, title: chart),
              body: SafeArea(
                child: Container(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      verticalSpace(height * 0.02),
                      Selection(bloc: bloc),
                      Expanded(
                        child: isLoading
                            ? circularProgressIndicator
                            : weightChart(
                                data: chartData.data,
                                monthly: chartData.monthName != null ? true : false,
                                bloc: bloc,
                              ),
                      ),
                    ],
                  ),
                ),
                // child: sample1(context),
              ),
            );
          },
        ),
      ),
    );
  }
}
