import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:way2fitlife/di/dependency_injection.dart';
import 'package:way2fitlife/features/dashboard/presentation/bloc/bloc.dart';
import 'package:way2fitlife/features/dashboard/presentation/widget/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  static bool animate = false;
  final int pageNo;

  DashBoardScreen({this.pageNo});

  final bloc = getIt<DashboardBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (BuildContext context, state) {
        if (state is AnimatePageState) DashBoardScreen.animate = state.animate;
        print(DashBoardScreen.animate);
      },
      child: BlocBuilder<DashboardBloc, DashboardState>(
        cubit: bloc,
        builder: (BuildContext context, state) {
          return ScaleAnimatedWidget(
            enabled: DashBoardScreen.animate,
            // enabled: true,
            duration: Duration(milliseconds: 300),
            values: [0.7, 1],
            child: DashBoardPage(pageNo: pageNo, bloc: bloc),
          );
        },
      ),
    );
  }
}
