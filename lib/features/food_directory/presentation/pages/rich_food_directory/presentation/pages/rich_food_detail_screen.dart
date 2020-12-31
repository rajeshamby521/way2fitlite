import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/data/data_model/rich_food_detail_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/presentation/widget/rich_food_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:way2fitlife/utils/screen_utils.dart';

import '../../../../../../../common/general_widget.dart';

class RichFoodDetailScreen extends StatefulWidget {
  final String foodId;
  final Bloc bloc;
  final String img;
  final String name;
  final int n;

  RichFoodDetailScreen({this.bloc, this.foodId, this.img, this.name, this.n});

  @override
  _RichFoodDetailScreenState createState() => _RichFoodDetailScreenState();
}

class _RichFoodDetailScreenState extends State<RichFoodDetailScreen> {
  bool isLoading = true;
  RichFoodDetailDataModel richFoodDetailData;
  List<Widget> detailsData;

  @override
  void initState() {
    widget.bloc.add(FetchRichFoodDetailDataEvent(foodId: widget.foodId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: widget.bloc,
      listener: (BuildContext context, state) {
        if (state is LoadingBeginRichFoodDetailState) isLoading = true;
        if (state is LoadingEndRichFoodDetailState) isLoading = false;
        if (state is FetchRichFoodDetailDataState) {
          richFoodDetailData = state.data;

          detailsData = [
            rowData(
                label: servingSize, data: richFoodDetailData.data.serviceSize),
            rowData(label: calories, data: richFoodDetailData.data.calories),
            rowData(
                label: "Total $fat", data: richFoodDetailData.data.totalFat),
            rowData(
                label: saturatedFat,
                data: richFoodDetailData.data.saturatedFat),
            rowData(
                label: polyUnsaturatedFat,
                data: richFoodDetailData.data.polyunsaturatedFat),
            rowData(
                label: monoUnsaturatedFat,
                data: richFoodDetailData.data.monounsaturatedFat),
            rowData(
                label: "Total $carbs",
                data: richFoodDetailData.data.totalCarbohydrate),
            rowData(
                label: dietaryFiber,
                data: richFoodDetailData.data.dietaryFiber),
            rowData(label: sugar, data: richFoodDetailData.data.sugar),
            rowData(label: protein, data: richFoodDetailData.data.protein),
            rowData(
                label: cholesterol, data: richFoodDetailData.data.cholesterol),
            rowData(label: sodium, data: richFoodDetailData.data.sodium),
            rowData(label: potassium, data: richFoodDetailData.data.potassium),
          ];
        }
      },
      child: BlocBuilder(
        cubit: widget.bloc,
        builder: (BuildContext context, state) {
          return widget.n == 0 ? newPage() : bottomSheet();
        },
      ),
    );
  }

  Widget newPage() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: headerColor,
          title: labels(text: details),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: widget.img,
                child: imageNetwork(img: widget.img, height: height * 0.3),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: imageNetwork(
            //       img: richFoodDetailData.data.foodImage, height: height * 0.3),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: labels(
                text: widget.name.toUpperCase(),
                color: theme,
                size: 20,
              ),
            ),
            listDivider(padding: 20),
            isLoading
                ? circularProgressIndicator
                : Expanded(
                    child: ListView(
                      itemExtent: 20,
                      children: detailsData,
                    ),
                  ),
            verticalSpace(100),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: widget.img,
            child: imageNetwork(img: widget.img, height: height * 0.2),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: imageNetwork(
        //       img: richFoodDetailData.data.foodImage, height: height * 0.3),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: labels(
            text: widget.name.toUpperCase(),
            color: theme,
            size: 20,
          ),
        ),
        listDivider(padding: 20),
        isLoading
            ? circularProgressIndicator
            : Expanded(
                child: ListView(
                  itemExtent: 20,
                  children: detailsData,
                ),
              ),
        verticalSpace(50),
      ],
    );
  }
}
