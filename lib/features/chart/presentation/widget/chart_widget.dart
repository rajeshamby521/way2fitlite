import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/common_data.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/chart/data/dataModel/chart_model.dart';
import 'package:way2fitlife/features/chart/presentation/bloc/bloc.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/ui_helper/text_style.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

List<Color> gradientColors = [
  gradientStart,
  gradientEnd,
];

Widget weightChart({List<Datum> data, bool monthly, Bloc bloc}) {
  return Center(
    child: Container(
      height: height * 0.7,
      width: width,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: LineChart(mainData(data, monthly)),
      ),
    ),
  );
}

LineChartData mainData(List<Datum> data, monthly) {
  List<double> weightList = List<double>();
  data.forEach((element) => weightList.add(double.parse(element.weight)));
  weightList.sort();
  return LineChartData(
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        getTitles: (value) => (value.toInt() * 3 + 1).toString(),
        getTextStyles: (value) => defaultHomeTextStyle(color: theme),
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => defaultHomeTextStyle(color: theme),
        getTitles: (value) => (value.toInt() * 10).toString(),
      ),
    ),
    maxX: monthly ? data.length.toDouble() / 3 : data.length.toDouble() - 1,
    maxY: (weightList.last + 10) / 10,
    lineBarsData: [
      LineChartBarData(
        spots: [
          for (int i = 0; i < data.length; i++)
            FlSpot(monthly ? i.toDouble() / 3 : i.toDouble(),
                double.parse(data[i].weight) / 10)
        ],
        colors: gradientColors,
        // dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.5)).toList()),
      ),
    ],
    axisTitleData: FlAxisTitleData(
        bottomTitle: axisTitle(month), leftTitle: axisTitle(weight)),
  );
}

AxisTitle axisTitle(String data) => AxisTitle(
    showTitle: true,
    titleText: data,
    textStyle: defaultHomeTextStyle(color: theme, size: 20));

class Selection extends StatefulWidget {
  final Bloc bloc;

  const Selection({Key key, this.bloc}) : super(key: key);

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  int tabValue = 0;
  bool showMonthSelector = true;
  int select = DateTime.now().month - 1;

  @override
  void initState() {
    super.initState();
    widget.bloc
        .add(GetChartDataEvent(month: (select + 1).toString(), dateType: "2"));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoSlidingSegmentedControl(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          groupValue: tabValue,
          backgroundColor: headerColor,
          onValueChanged: (int value) {
            setState(() {
              tabValue = value;
              showMonthSelector = value == 0 ? true : false;
            });
            value == 0
                ? widget.bloc.add(GetChartDataEvent(
                    month: (select + 1).toString(), dateType: "2"))
                : widget.bloc.add(GetChartDataEvent(month: "", dateType: "1"));
          },
          children: {
            0: labels(text: month, color: tabValue != 0 ? white : theme),
            1: labels(text: year, color: tabValue != 1 ? white : theme),
          },
        ),
        verticalSpace(5),
        divider(color: theme, thickness: 1),
        _getMonthSelector(),
      ],
    );
  }

  _getMonthSelector() {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      opacity: showMonthSelector ? 1 : 0,
      child: showMonthSelector
          ? Wrap(children: [
              for (int i = 0; i < monthsList.length; i++)
                button(label: monthsList[i], index: i)
            ])
          : Container(),
    );
  }

  Widget button({String label, int index}) => RaisedButton(
        elevation: 5,
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            select = index;
            widget.bloc.add(GetChartDataEvent(
                month: (select + 1).toString(), dateType: "2"));
          });
        },
        color: select == index ? headerColor : white,
        shape:
            roundedRectangleBorder(radius: 10, side: BorderSide(color: theme)),
        child: labels(text: label, color: select == index ? white : theme),
      );
}
