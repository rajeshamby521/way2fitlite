class HomeDataModel {
  List<String> _homeDataList;

  getData(List<String> data) {
    _homeDataList = data;
  }

  List<String> get homeData => _homeDataList;
}
