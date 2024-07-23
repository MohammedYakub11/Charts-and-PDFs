import 'dart:convert';

import 'package:intl/intl.dart';

import 'common.dart';

class EmployeeDetails {
  final int userId;
  final String displayName;
  final String jobTitle;
  final String role;
  final String mail;
  final String empId;
  final String mobilePhone;
  final String officeLocation;
  final String checkOutTime;
  final UserShiftDetails shift;
  final GetManagerDetails reportTo;
  final String department;

  EmployeeDetails(
      {required this.userId,
      required this.displayName,
      required this.jobTitle,
      required this.role,
      required this.mail,
      required this.shift,
      required this.empId,
      required this.mobilePhone,
      required this.checkOutTime,
      required this.officeLocation,
      required this.department,
      required this.reportTo});

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) {
    return EmployeeDetails(
      userId: json['userId'] ?? 0,
      displayName: json['displayName'] ?? '',
      jobTitle: json['jobTitle'] ?? '',
      role: json['role'] ?? '',
      mail: json['mail'] ?? '',
      empId: json['empId'] ?? '',
      mobilePhone: json['mobilePhone'] ?? "",
      checkOutTime: json['checkOutTime'] ?? '',
      officeLocation: json['officeLocation'] ?? '',
      shift: json['shift'] != null
          ? UserShiftDetails.fromJson(json['shift'])
          : UserShiftDetails(startTime: '', id: 0, shiftName: ''),
      department: json['department'] ?? '',
      reportTo: json['reportTo'] != null
          ? GetManagerDetails.fromJson(json['reportTo'])
          : GetManagerDetails(name: '', mail: '', designation: ''),
    );
  }

  //hkjnkj
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'displayName': displayName,
      'jobTitle': jobTitle,
      'role': role,
      'mail': mail,
      'empId': empId,
      'reportTo': reportTo.toJson(),
      'shift': shift.toJson(), // Convert the shift to JSON
    };
  }
}

class EmployeeLeaveRequest {
  final int? id;
  final int? userId;
  final double? days;
  final String currentlyWith;
  final String type;
  String userName;
  String appliedOn;
  String status;
  String date;
  String session;
  String reviewedBy;

  EmployeeLeaveRequest(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.days,
      required this.currentlyWith,
      required this.type,
      required this.appliedOn,
      required this.status,
      required this.date,
      required this.session,
      required this.reviewedBy});

  factory EmployeeLeaveRequest.fromJson(Map<String, dynamic> json) {
    return EmployeeLeaveRequest(
      id: json['id'] ?? null,
      userId: json['userId'] ?? null,
      days: json['days'] ?? null,
      currentlyWith: json['currentlyWith'] ?? '',
      userName: json['userName'] ?? '',
      type: json['type'] ?? '',
      appliedOn: json['appliedOn'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
      session: json['session'] ?? '',
      reviewedBy: json['reviewedBy'] ?? '',
    );
  }
}

class EmployeeActivity {
  final DateTime date;
  final int userId;
  final String workMode;
  final String? loginTime;
  final String? logoutTime;
  final String? totalWorkingHours;
  final String? totalBreakHours;
  final String? lateBy;
  final String? status;
  final String? shiftName;
  final int id;
  final String shiftStartTime;
  final bool isRegularized;
  final bool hasPendingOrTransferRegularization;

  EmployeeActivity(
      {required this.date,
      required this.userId,
      required this.workMode,
      required this.loginTime,
      required this.logoutTime,
      required this.totalWorkingHours,
      required this.totalBreakHours,
      required this.lateBy,
      required this.status,
      required this.shiftName,
      required this.id,
      required this.shiftStartTime,
      required this.isRegularized,
      required this.hasPendingOrTransferRegularization});

  factory EmployeeActivity.fromJson(Map<String, dynamic> json) {
    return EmployeeActivity(
      userId: json['userId'] ?? 0,
      date: DateFormat('yyyy-MM-dd').parse(json['date']),
      workMode: json['workMode'] ?? '----',
      loginTime: json['loginTime'] ?? '--:--:--',
      logoutTime: json['logoutTime'] ?? '--:--:--',
      lateBy: json['lateBy'],
      totalWorkingHours: json['totalWorkingHours'] ?? '--:--:--',
      totalBreakHours: json['totalBreaksHours'] ?? '--:--:--',
      status: json['status'] ?? '',
      shiftName: json['shiftName'] ?? '----',
      id: json['id'] ?? 0,
      shiftStartTime: json['shiftStartTime'] ?? '',
      isRegularized: json['isRegularized'] ?? false,
      hasPendingOrTransferRegularization:
          json['hasPendingOrTransferRegularization'] ?? false,
    );
  }
}

  class UserLeaveApplyDetails {
    final int id;
    final String? status;
    final String? type;
    final double? noOfDays;
    final String? userName;
    final String? userMail;
    final int? reviewBy;
    final String? reviewByName;
    final String? reviewByMail;
    final List<String>? cc;
    final String? reason;
    final String? remarks;
    final List<LeaveDay>? days;
    final String? attachmentType;
    final String? attachmentName;
    final String? appliedOn;

    UserLeaveApplyDetails({
      required this.id,
      this.status,
      this.type,
      this.noOfDays,
      this.userName,
      this.userMail,
      this.reviewBy,
      this.reviewByName,
      this.reviewByMail,
      this.cc,
      this.reason,
      this.remarks,
      this.days,
      this.attachmentType,
      this.attachmentName,
      this.appliedOn,
    });

    factory UserLeaveApplyDetails.fromJson(Map<String, dynamic> json) {
      var daysList = json['days'] as List<dynamic>?;
      List<LeaveDay>? leaveDays;
      if (daysList != null) {
        leaveDays = daysList.map((day) => LeaveDay.fromJson(day)).toList();
      }

      var ccList = json['cc'] as List<dynamic>?;
      List<String>? ccEmails;
      if (ccList != null) {
        ccEmails = ccList.cast<String>();
      }

      return UserLeaveApplyDetails(
        id: json['id'],
        status: json['status'],
        type: json['type'],
        noOfDays: json['noOfDays'],
        userName: json['userName'],
        userMail: json['userMail'],
        reviewBy: json['reviewBy'],
        reviewByName: json['reviewByName'],
        reviewByMail: json['reviewByMail'],
        cc: ccEmails,
        reason: json['reason'],
        remarks: json['remarks'],
        days: leaveDays,
        attachmentType: json['attachmentType'],
        attachmentName: json['attachmentName'],
        appliedOn: json['appliedOn'],
      );
    }

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'status': status,
        'noOfDays': noOfDays,
        'userName': userName,
        'userMail': userMail,
        'reviewBy': reviewBy,
        'reviewByName': reviewByName,
        'reviewByMail': reviewByMail,
        'reason': reason,
        'remarks': remarks,
        'days': days?.map((day) => day.toMap()).toList(),
        'cc': cc,
        'attachmentType': attachmentType,
        'attachmentName': attachmentName,
        'appliedOn': appliedOn,
      };
    }
  }

class LeaveDay {
  final String? date;
  final String? session;

  LeaveDay({this.date, this.session});

  factory LeaveDay.fromJson(Map<String, dynamic> json) {
    return LeaveDay(
      date: json['date'],
      session: json['session'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'session': session,
    };
  }
}

class YearlyLeaveDetails {
  final int id;
  final double noOfDays;
  final String leaveType;
  final String startDate;
  final String endDate;

  YearlyLeaveDetails({
    required this.id,
    required this.noOfDays,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
  });

  factory YearlyLeaveDetails.fromJson(Map<String, dynamic> json) {
    return YearlyLeaveDetails(
      id: json['id'],
      noOfDays: json['noOfDays'].toDouble(),
      leaveType: json['leaveType'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}
