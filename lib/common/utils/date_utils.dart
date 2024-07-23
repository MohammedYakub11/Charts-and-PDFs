import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
class DateUtilsOfWeek {
  DateTime? _startOfWeek;
  DateTime? _endOfWeek;

  // Constructor to initialize the current week to the current week's dates
  DateUtilsOfWeek() {
    updateWeek(DateTime.now());
  }

  void moveToNextWeek() {
    _startOfWeek = _startOfWeek?.add(const Duration(days: 7));
    _endOfWeek = _endOfWeek?.add(const Duration(days: 7));

  }

  void moveToPreviousWeek() {

    _startOfWeek = _startOfWeek?.subtract(const Duration(days: 7));
    _endOfWeek = _endOfWeek?.subtract(const Duration(days: 7));
    debugPrint('Startof week:$_startOfWeek,end:$_endOfWeek');
  }

  Map<String, DateTime> getCurrentWeek() {
    return {'start': _startOfWeek!, 'end': _endOfWeek!};
  }

  // Method to update the current week based on a given date
  void updateWeek(DateTime date) {
    final currentWeekday = date.weekday;
    _startOfWeek = date.subtract(Duration(days: currentWeekday - 1));
    _endOfWeek = date.add(Duration(days: 7 - currentWeekday));
  }

}

class DateTimeUtils {
  static DateTime dateTime = DateTime.now();
  static String? currentDateWithMonth =
  DateFormat.yMMMEd().format(DateTime.now()).toString();
  static String currentDay = DateFormat('EEEE').format(dateTime).toString();
  final formatter = DateFormat('d-MM-yyyy');
  final apiFormat = DateFormat('yyyy-MM-dd');

  static  String getTimer() {
    return "${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour} : "
        "${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} :"
        "${DateTime.now().second < 10 ? "0${DateTime.now().second}" : DateTime.now().second} ";
  }

  //for showing UI
  static String formatTime12Hour(String time24Hour) {
    try {
      final inputFormat = DateFormat('HH:mm:ss');
      final outputFormat = DateFormat('h:mm a');
      final dateTime = inputFormat.parse(time24Hour);
      return outputFormat.format(dateTime);
    } catch (e) {
      print('Error formatting time: $e');
      return '';
    }
  }
  static String formatTime12HourWithSeconds(String time24Hour) {
    try {
      final inputFormat = DateFormat('HH:mm:ss');
      final outputFormat = DateFormat('h:mm:ss');
      final dateTime = inputFormat.parse(time24Hour);
      return outputFormat.format(dateTime);
    } catch (e) {
      print('Error formatting time: $e');
      return '';
    }
  }
  //for api call format
  static String formatTo24Hour(String time12Hour) {
    try {
      final inputFormat = DateFormat('h:mm a');
      final outputFormat = DateFormat('HH:mm:ss');
      final dateTime = inputFormat.parse(time12Hour);
      return outputFormat.format(dateTime);
    } catch (e) {
      print('Error formatting time: $e');
      return '';
    }
  }
  static String? addFormat(String time12Hour,BuildContext context) {
    try {
      final inputFormat = DateFormat('HH:mm');
      final outputFormat = DateFormat('HH:mm:ss');
      final dateTime = inputFormat.parse(time12Hour);
      return outputFormat.format(dateTime);
    } catch (e) {
      print('Error formatting time: $e');
      // showToast(context,titleText: 'Invalid Time',contentText:'');
      return null;
    }
  }
  static String formatDate(String dateString) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date using DateFormat
    String formattedDate = DateFormat('dd MMM, yyyy').format(dateTime);
    debugPrint("Dates:$formattedDate");
    return formattedDate;
  }
  static String formatDateWithYearMonth(String dateString) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date using DateFormat
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }
  static String formatDateWithDay(String dateString) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateString);

    // Format the date using DateFormat
    String formattedDate = DateFormat('d E,MMM,yyyy').format(dateTime);
    return formattedDate;
  }
  static String changeDateFormatForApi(String dateString) {
    // Parse the input date string with the current format
    DateTime dateTime = DateFormat('dd-MM-yyyy').parse(dateString);

    // Format the date with the desired format
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return formattedDate;
  }
  static String changeDateFormatForShowingUI(String dateString) {
    // Parse the input date string with the current format
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateString);

    // Format the date with the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return formattedDate;
  }
  DateFormat getNormalFormat() {
    return formatter;
  }

  DateFormat getApiFormat() {
    return apiFormat;
  }


}
