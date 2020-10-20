import 'package:way2fitlife/common/general/appbar_widget.dart';
import 'package:way2fitlife/common/general/circular_progress_indicator.dart';
import 'package:way2fitlife/common/general_widget.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/food_directory/data/dataModel/food_directory_model.dart';
import 'package:way2fitlife/features/food_directory/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/rich_food_directory/presentation/pages/rich_food_screen.dart';
import 'package:way2fitlife/features/food_directory/presentation/widget/food_directory_home_widget.dart';
import 'package:way2fitlife/ui_helper/images.dart';
import 'package:way2fitlife/ui_helper/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodDirectory extends StatefulWidget {
  final Bloc bloc;

  FoodDirectory({this.bloc});

  @override
  _FoodDirectoryState createState() => _FoodDirectoryState();
}

class _FoodDirectoryState extends State<FoodDirectory> {
  FoodCategoryModel foodDirectoryList;
  bool isLoading = true;

  Bloc bloc = getIt<FoodDirectoryBloc>();

  @override
  void initState() {
    bloc.add(FetchFoodDirectoryDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(
          bloc: widget.bloc,
          title: foodDirectory,
          context: context,
        ),
        body: Container(
          decoration: boxDecoration(image: bg_bmi_screen),
          child: BlocListener(
            cubit: bloc,
            listener: (BuildContext context, state) {
              if (state is LoadingBeginHomeState)
                isLoading = true;
              else if (state is LoadingEndHomeState)
                isLoading = false;
              else if (state is FetchFoodDirectoryDataState) foodDirectoryList = state.data;
            },
            child: BlocBuilder(
              cubit: bloc,
              builder: (BuildContext context, state) {
                return Padding(
                  padding: verticalPadding(padding: 10),
                  child: isLoading
                      ? circularProgressIndicator
                      : ListView.separated(
                          itemCount: foodDirectoryList.data.length,
                          itemBuilder: (context, index) => listTile(
                            label: foodDirectoryList.data[index].categoryName,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RichFoodScreen(
                                  categoryId: foodDirectoryList.data[index].categoryId,
                                  foodType: foodDirectoryList.data[index].categoryName,
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => listDivider(padding: 10),
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
