import 'package:way2fitlife/features/home/data/datasource/home_data_source.dart';

class HomeDataSourceImpl extends HomeDataSource {
  @override
  Future<List<String>> getData() async {
    List<String> introList = [
      'way2fitlife is developed By Krira Fitness with aim to spread awareness about physical fitness.',
      'way2fitlife has many features which help to track the fitness.',
      'By knowing BMI, you can know that how healthy you are.',
      'By knowing BMR, you can know your daily calorie intake based on your goal.',
      'You can add your weight daily and see on the chart to see that how is your goal performing.',
      'You can post your question on the Forum and get answers. There will be tips for weight loss, weight gain in the forum.',
      'Send us your Feedback for any kind of your idea to improve the app.',
    ];
    // Future.delayed(const Duration(seconds: 3));
    return introList;
  }
}
