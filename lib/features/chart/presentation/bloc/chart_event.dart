abstract class ChartEvent {}

class GetChartDataEvent extends ChartEvent {
  String dateType;
  String month;

  GetChartDataEvent({this.month, this.dateType});
}
