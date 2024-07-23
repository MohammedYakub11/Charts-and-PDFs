import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/common.dart';
import '../../model/user.dart';

final selectedYearForLeaveRequestProvider =
    StateProvider.autoDispose<int>((ref) => DateTime.now().year);

final getDetailsOfLeaveRequestEmployeeProvider = StateNotifierProvider<
    GetDetailsOfLeaveRequestEmployee,
    EmployeeLeaveRequest?>((ref) => GetDetailsOfLeaveRequestEmployee());



final getDetailsOfLeaveCalendarAdminProvider = StateNotifierProvider<
    GetDetailsOfLeaveRequestEmployee,
    EmployeeLeaveRequest?>((ref) => GetDetailsOfLeaveRequestEmployee());

class GetDetailsOfLeaveRequestEmployee
    extends StateNotifier<EmployeeLeaveRequest?> {
  GetDetailsOfLeaveRequestEmployee()
      : super(EmployeeLeaveRequest(
          id: 0,
          days: 0,
          currentlyWith: "",
          type: "",
          appliedOn: '',
          status: '',
          userId: 0,
          date: "",
          session: "",
          reviewedBy: "",
          userName: "",
        ));

  Future<void> getDetailsOfLeaveRequest({
    required int id,
    required int userId,
    required double days,
    required String currentlyWith,
    required String type,
    required String appliedOn,
    required String status,
    required String date,
    required String session,
    required String reviewedBy,
  }) async {
    try {
      final String response = await rootBundle.loadString('assets/sample.json');
      final Map<String, dynamic> data = jsonDecode(response);
      final EmployeeLeaveRequest leaveRequest =
          EmployeeLeaveRequest.fromJson(data);
      state = leaveRequest;
    } catch (e) {
      debugPrint('Error while loading leave requests: $e');
    }
  }
}

final getPendingListForLeaveRequestEmployeeProvider = StateNotifierProvider<
        GetPendingListForLeaveRequestEmployeeTable,
        List<PendingTableListForLeaveRequest>?>(
    (ref) => GetPendingListForLeaveRequestEmployeeTable());

class GetPendingListForLeaveRequestEmployeeTable
    extends StateNotifier<List<PendingTableListForLeaveRequest>?> {
  // final CommonApi commonApi = CommonApi();
  GetPendingListForLeaveRequestEmployeeTable() : super([]);

  Future<void> getPendingList({required int userId, required int year}) async {
    // try {
    //   final pendingList = await commonApi.getPendingListForEmployeeTable(userId: userId,year: year);
    //   state=pendingList;
    // } catch (e) {
    //   debugPrint('Error while calling HistoryList In provider:$e');
    //
    // }
  }
}

final getHistoryListForLeaveRequestEmployeeProvider = StateNotifierProvider<
        GetHistoryListForLeaveRequestEmployeeTable,
        List<HistoryTableListForLeaveRequest>?>(
    (ref) => GetHistoryListForLeaveRequestEmployeeTable());

class GetHistoryListForLeaveRequestEmployeeTable
    extends StateNotifier<List<HistoryTableListForLeaveRequest>?> {
  // final CommonApi commonApi = CommonApi();
  GetHistoryListForLeaveRequestEmployeeTable() : super([]);

  Future<void> getHistoryList({required int userId, required int year}) async {
    // try {
    //   final pendingList = await commonApi.getPendingListForEmployeeTable(userId: userId,year: year);
    //   state=pendingList;
    // } catch (e) {
    //   debugPrint('Error while calling HistoryList In provider:$e');
    //
    // }
  }
}


// Step 1: StateNotifierProvider for managing leave history details
// final getDetailsOfLeaveHistoryEmployeeProvider = StateNotifierProvider<
//     GetDetailsOfLeaveHistoryEmployee,
//     EmployeeLeaveRequest?>((ref) => GetDetailsOfLeaveHistoryEmployee());
//
// // Step 2: StateNotifier class for fetching and managing leave history details
// class GetDetailsOfLeaveHistoryEmployee
//     extends StateNotifier<EmployeeLeaveRequest?> {
//   GetDetailsOfLeaveHistoryEmployee()
//       : super(null); // Start with null state
//
//   Future<void> getDetailsOfLeaveHistory({
//     required int id,
//     required List<LeaveDay> days,
//     required String currentlyWith,
//     required String type,
//     required String appliedOn,
//     required String status,
//     required int session,
//     required String reviewByName,
//     required double? noOfDays,
//     required String remarks,
//     required String attachmentType,
//     required String attachmentName,
//     required String reason,
//
//
//   }) async {
//     try {
//       // Simulating API call or JSON loading
//       final String response = await rootBundle.loadString('assets/sample.json');
//       final Map<String, dynamic> data = jsonDecode(response);
//       final EmployeeLeaveRequest leaveHistory =
//       EmployeeLeaveRequest.fromJson(data);
//       state = leaveHistory;
//     } catch (e) {
//       debugPrint('Error while loading leave history: $e');
//     }
//   }
// }