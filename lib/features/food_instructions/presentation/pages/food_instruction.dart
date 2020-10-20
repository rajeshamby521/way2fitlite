import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/food_instructions/data/datamodel/food_instruction_datamodel.dart';
import 'package:way2fitlife/features/food_instructions/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/food_instructions/presentation/widget/food_instructiopn_widget.dart';
import 'package:way2fitlife/ui_helper/colors.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodInstruction extends StatefulWidget {
  Bloc bloc;

  FoodInstruction({this.bloc});

  @override
  _FoodInstructionState createState() => _FoodInstructionState();
}

class _FoodInstructionState extends State<FoodInstruction> {
  final bloc = getIt<FoodInstructionBloc>();
  bool isLoading = true;
  FoodInstructionDataModel dataModel;
  int tabValue = 0;

  @override
  void initState() {
    bloc.add(GetFoodInstructionDataEvent(foodAvoidId: "1"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(bloc: widget.bloc, context: context, title: foodInstruction),
      body: BlocListener(
        cubit: bloc,
        listener: (BuildContext context, state) {
          if (state is LoadingBeginFoodInstructionState) isLoading = true;
          if (state is LoadingEndFoodInstructionState) isLoading = false;
          if (state is GetFoodInstructionDataState) dataModel = state.data;
        },
        child: BlocBuilder(
          cubit: bloc,
          builder: (BuildContext context, state) {
            return isLoading
                ? circularProgressIndicator
                : DefaultTabController(
                    length: 2,
                    child: Container(
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //     colors: [white,white],
                      //     begin: Alignment.topCenter,
                      //     end: Alignment.bottomCenter,
                      //   ),
                      // ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoSlidingSegmentedControl(
                              groupValue: tabValue,
                              backgroundColor: headerColor,
                              onValueChanged: (int value) {
                                setState(() {
                                  tabValue = value;
                                });
                              },
                              children: {
                                0: labels(text: toAvoid, color: tabValue != 0 ? white : theme),
                                1: labels(text: toEat, color: tabValue != 1 ? white : theme),
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: tabValue == 0
                                  ? FoodAvoidDataList(data: dataModel.data.foodStrictlyText)
                                  : FoodEatDataList(data: dataModel.data.foodEatText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
