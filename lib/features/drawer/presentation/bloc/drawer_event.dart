abstract class DrawerEvent {}

class FetchSelectPageEvent extends DrawerEvent {
  final int pageNo;

  FetchSelectPageEvent({this.pageNo});
}