abstract class DashboardEvent {}

class AnimatePageEvent extends DashboardEvent {
  bool animate;
  AnimatePageEvent({this.animate});
}
