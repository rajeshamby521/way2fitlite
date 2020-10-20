import 'package:way2fitlife/features/dashboard/data/datasource/dashboard_data_source.dart';

class DashboardSourceImpl extends DashboardSource {
  @override
  Future<bool> getAnimateData({bool animate}) async => animate;

}
