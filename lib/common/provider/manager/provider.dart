import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/common.dart';
import '../../model/user.dart';
import '../../services/common_api.dart';
import '../leave_request/leave_request.dart';

final managerTeamLeavePieChartProvider =
    StateNotifierProvider<ManagerTeamLeavePieChart, List<LeaveData>>(
        (ref) => ManagerTeamLeavePieChart());

class ManagerTeamLeavePieChart extends StateNotifier<List<LeaveData>> {
  final CommonApi commonApi = CommonApi();

  ManagerTeamLeavePieChart() : super([]);

  Future<dynamic> getManagerTeamLeavePieChart({
    String? mail,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final leaveDataList = await commonApi.managerTeamLeavePieChart(
          mail: mail, startDate: startDate, endDate: endDate);
      debugPrint('Fetched leave data: $leaveDataList');

      state = leaveDataList;
    } catch (e) {
      debugPrint(
          'Error while calling manager team leave pie chart in provider: $e');
    }
  }
}

final managerSelectedDateProvider =
    StateProvider.autoDispose<DateTime?>((ref) => DateTime.now());

final managerTeamLeaveCalendarProvider =
    StateNotifierProvider<ManagerTeamLeaveCalendar, List<LeaveCountCalendar>>(
        (ref) => ManagerTeamLeaveCalendar());

class ManagerTeamLeaveCalendar extends StateNotifier<List<LeaveCountCalendar>> {
  final CommonApi commonApi = CommonApi();

  ManagerTeamLeaveCalendar() : super([]);

  Future<void> getManagerTeamLeaveCalendar(
      {String? mail,
      required String startDate,
      required String endDate}) async {
    try {
      List<LeaveCountCalendar> managerTeamLeaveCalendar;

      if (mail != null) {
        managerTeamLeaveCalendar = await commonApi.managerTeamLeaveCalendar(
            mail: mail, startDate: startDate, endDate: endDate);
      } else {
        managerTeamLeaveCalendar = await commonApi.managerTeamLeaveCalendar(
            startDate: startDate, endDate: endDate);
      }

      if (managerTeamLeaveCalendar.isNotEmpty) {
        state = managerTeamLeaveCalendar;
      }
    } catch (e) {
      debugPrint(
          'Error while calling manager team Leave Calendar In provider:$e');
    }
  }
}

final managerTeamDetailsProvider =
    StateProvider<ManagerTeamAttendance?>((ref) => null);







//History data
final yearlyLeaveDetailsHistoryProvider =
    StateNotifierProvider<YearlyLeaveDetailsHistory, List<YearlyLeaveDetails>>(
        (ref) => YearlyLeaveDetailsHistory());

class YearlyLeaveDetailsHistory
    extends StateNotifier<List<YearlyLeaveDetails>> {
  final CommonApi commonApi = CommonApi();

  YearlyLeaveDetailsHistory() : super([]);

  Future<void> getYearlyLeaveDetailsHistory({
    String? mail,
    required int year,
  }) async {
    try {
      List<YearlyLeaveDetails> yearlyLeaveDetailsHistory;

      if (mail != null) {
        yearlyLeaveDetailsHistory = await commonApi.yearlyLeaveDetailsHistory(
          mail: mail,
          year: year,
        );
      } else {
        yearlyLeaveDetailsHistory = await commonApi.yearlyLeaveDetailsHistory(
          year: year,
        );
      }

      if (yearlyLeaveDetailsHistory.isNotEmpty) {
        state = yearlyLeaveDetailsHistory;
      }
    } catch (e) {
      debugPrint(
          'Error while calling Yearly Leave Details History In provider:$e');
    }
  }
}

final selectedLeaveDetailProvider = StateNotifierProvider<SelectedLeaveDetailNotifier, YearlyLeaveDetails?>(
      (ref) => SelectedLeaveDetailNotifier(),
);

class SelectedLeaveDetailNotifier extends StateNotifier<YearlyLeaveDetails?> {
  SelectedLeaveDetailNotifier() : super(null);

  void selectLeaveDetail(YearlyLeaveDetails leaveDetail) {
    state = leaveDetail;
  }
}


  final LeaveRequestDetailsHistoryProvider =
  StateNotifierProvider<UserLeaveApplyDetailsNotifier, List<UserLeaveApplyDetails>>(
          (ref) => UserLeaveApplyDetailsNotifier());
  class UserLeaveApplyDetailsNotifier
      extends StateNotifier<List<UserLeaveApplyDetails>> {
    final CommonApi commonApi = CommonApi();

    UserLeaveApplyDetailsNotifier() : super([]);

    Future<void> getYearlyLeaveDetailsHistory({
      required int requestId  }) async {
      try {
        List<UserLeaveApplyDetails> userLeaveApplyDetails = [];
        final details = await commonApi.leaveRequestById(requestId: requestId);

        if (details != null) {
          userLeaveApplyDetails.add(details);
        }

        if (userLeaveApplyDetails.isNotEmpty) {
          state = userLeaveApplyDetails;
        }
      } catch (e) {
        debugPrint(
            'Error while calling Yearly Leave Details History In provider:$e');
      }
    }




}


