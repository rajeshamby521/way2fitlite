class DashboardModel {
  int _pageNo;

  getData(int no) {
    _pageNo = no;
  }

  int get pageNo => _pageNo;
}
