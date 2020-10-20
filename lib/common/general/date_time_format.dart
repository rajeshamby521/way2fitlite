
import 'package:intl/intl.dart';

String dateFormat({DateTime dateTime, String format}) =>
    DateFormat(format ?? 'dd MMMM, yyyy').format(dateTime);

DateTime stringToDate(String date) => DateTime.parse(date);