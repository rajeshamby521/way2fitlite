import 'package:way2fitlife/features/chart/presentation/pages/chart_screen.dart';
import 'package:way2fitlife/features/compare/presentation/pages/compare_screen.dart';
import 'package:way2fitlife/features/current_bmi/presentation/pages/current_bmi_screen.dart';
import 'package:way2fitlife/features/current_bmr/presentation/pages/current_bmr_screen.dart';
import 'package:way2fitlife/features/feedback/presentation/pages/feedback_screen.dart';
import 'package:way2fitlife/features/food_directory/presentation/pages/food_directory_home_screen.dart';
import 'package:way2fitlife/features/food_instructions/presentation/pages/food_instruction.dart';
import 'package:way2fitlife/features/home/presentation/pages/home_screen.dart';
import 'package:way2fitlife/features/photo_gallery/presentation/pages/photo_gallery_screen.dart';
import 'package:way2fitlife/features/video_play_list/video_play_list_screen.dart';
import 'package:way2fitlife/features/weight_sheet/presentation/pages/weight_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget DashBoardPage({int pageNo, Bloc bloc}) {
  switch (pageNo) {
    // Home
    case 0:
      return CurrentBMIScreen(bloc: bloc);
      break;
    // BMI
    case 1:
      return CurrentBMIScreen(bloc:bloc);
      break;
    // BMR
    case 2:
      return CurrentBMRScreen(bloc: bloc);
      break;
    // Weight Sheet
    case 3:
      return WeightSheetScreen(bloc: bloc);
      break;
    // Food Directory
    case 4:
      return FoodDirectory(bloc: bloc);
      break;
    // Food Instruction
    case 5:
      return FoodInstruction(bloc: bloc);
      break;
    // Chat with Krira
    case 6:
      return VideoPlayListScreen(bloc: bloc);
      break;
    // Photo Gallery
    case 7:
      return PhotoGalleryScreen(bloc: bloc);
      break;
    // Chart
    case 8:
      return ChartScreen(bloc: bloc);
      break;
    //Compare
    case 9:
      return CompareScreen(bloc: bloc);
      break;
    // Forum
    case 10:
      return HomePage(bloc: bloc);
      break;
    // FeedBack
    case 11:
      return FeedbackScreen(bloc: bloc);
      break;
    // Default
    default:
      return HomePage(bloc: bloc);
      break;
  }
}
