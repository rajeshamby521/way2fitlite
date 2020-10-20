import 'package:way2fitlife/features/weight_sheet/data/datamodel/set_weight_data_model.dart';
import 'package:way2fitlife/features/weight_sheet/data/datamodel/weight_sheet_model.dart';

abstract class WeightSheetDataSource {
  Future<WeightSheetModel> getWeightSheetData({int offSet});

  Future<SetWeightDataModel> setWeightSheetData({String date, String weight});

  Future<double> getWeight({double weight});

  Future<DateTime> getDate({DateTime dateTime});
}
