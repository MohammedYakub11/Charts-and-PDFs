import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/common.dart';
import '../model/user.dart';
import '../utils/constants.dart';

class CommonApi {
  Future<List<LeaveData>> managerTeamLeavePieChart({
    String? mail,
    required String startDate,
    required String endDate,
  }) async {
    // Construct the URL based on the presence of the email parameter
    String appUrl;
    if (mail != null) {
      appUrl =
          'http://localhost:8082/api/leave/countByRange?mail=$mail&from=$startDate&to=$endDate';
    } else {
      appUrl =
          'http://localhost:8082/api/leave/countByRange?from=$startDate&to=$endDate';
    }

    debugPrint('Fetching data from: $appUrl');

    try {
      final response = await http.get(Uri.parse(appUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        debugPrint('Data fetched: $data');
        return data.map((item) => LeaveData.fromJson(item)).toList();
      } else {
        // Handle other status codes gracefully
        debugPrint(
            'Failed to fetch Types of leave taken data. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch Types of leave taken data');
      }
    } catch (error) {
      debugPrint('Error fetching data: $error');
      throw Exception('Failed to fetch Types of leave taken data: $error');
    }
  }

  Future<List<LeaveCountCalendar>> managerTeamLeaveCalendar(
      {String? mail,
      required String startDate,
      required String endDate}) async {
    String appUrl;
    if (mail != null) {
      appUrl =
          'http://localhost:8082/api/leave/countByDate?mail=$mail&from=$startDate&to=$endDate';
    } else {
      appUrl =
          'http://localhost:8082/api/leave/countByDate?from=$startDate&to=$endDate';
    }
    debugPrint('API fetching: $appUrl');
    final response = await http.get(Uri.parse(appUrl));
    debugPrint('API response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // debugPrint('API response data: $data');

      return data.map((json) => LeaveCountCalendar.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Types of leave taken data');
    }
  }

  Future<List<YearlyLeaveDetails>> yearlyLeaveDetailsHistory({
    String? mail,
    required int year,
  }) async {
    String appUrl;
    if (mail != null) {
      appUrl =
          'http://localhost:8082/api/leave/yearlyHistory?mail=$mail&year=$year';
    } else {
      appUrl = 'http://localhost:8082/api/leave/yearlyHistory?year=$year';
    }
    debugPrint('API fetching: $appUrl');

    try {
      final response = await http.get(Uri.parse(appUrl));
      debugPrint('API response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        debugPrint('API response data: $data');

        return data.map((json) => YearlyLeaveDetails.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch Yearly Leave Details');
      }
    } catch (e) {
      debugPrint('Error fetching API: $e');
      throw Exception('Failed to fetch Yearly Leave Details');
    }
  }

  Future<UserLeaveApplyDetails?> leaveRequestById({required int requestId}) async {
    String apiUrl='${AppConstants.server_url}/leave/leaveRequestById?requestId=$requestId';
    debugPrint(apiUrl);

    try{
      final response=await http.get(Uri.parse(apiUrl));
      if(response.statusCode==200){
        final Map<String,dynamic> data = json.decode(response.body);
        return UserLeaveApplyDetails.fromJson(data);

      }else {
        throw Exception('Failed to LEaveReqBYId Details');
      }
    }catch(e){
      debugPrint('Error in LEaveReqBYId Details List : $e');
      return null;
    }
  }

}
