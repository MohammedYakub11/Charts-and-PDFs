import 'package:flutter_testings/common/model/user.dart';

class PendingTableListForLeaveRequest {
  final int? id;
  final int? userId;
  final double? days;

  final String currentlyWith;
  final String type;
  final String appliedOn;
  final String status;
  final String date;
  final String session;
  final String reviewedBy;

  PendingTableListForLeaveRequest({
    required this.id,
    required this.days,
    required this.currentlyWith,
    required this.type,
    required this.appliedOn,
    required this.status,
    required this.userId,
    required this.date,
    required this.session,
    required this.reviewedBy,
  });

  factory PendingTableListForLeaveRequest.fromJson(Map<String, dynamic> json) {
    return PendingTableListForLeaveRequest(
      id: json['id'] ?? null,
      days: json['days'] ?? null,
      currentlyWith: json['currentlyWith'] ?? null,
      type: json['type'] ?? '',
      appliedOn: json["appliedOn"] ?? '',
      date: json["date"] ?? '',
      status: json["status"] ?? '',
      userId: json["userId"] ?? 0,
      session: json["session"] ?? '',
      reviewedBy: json["reviewedBy"] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'days': days,
      'assignToName': currentlyWith,
      'type': type,
      'userId': userId,
      'status': status,
      'appliedOn': appliedOn,
      'date': date,
      'session': session,
      'reviewedBy': reviewedBy,
    };
  }
}

class HistoryTableListForLeaveRequest {
  final int? id;
  final int? userId;
  final double? days;

  final String currentlyWith;
  final String type;
  final String appliedOn;
  final String status;
  final String date;
  final String session;
  final String reviewedBy;

  HistoryTableListForLeaveRequest({
    required this.id,
    required this.days,
    required this.currentlyWith,
    required this.type,
    required this.appliedOn,
    required this.status,
    required this.userId,
    required this.date,
    required this.session,
    required this.reviewedBy,
  });

  factory HistoryTableListForLeaveRequest.fromJson(Map<String, dynamic> json) {
    return HistoryTableListForLeaveRequest(
      id: json['id'] ?? null,
      days: json['days'] ?? null,
      currentlyWith: json['currentlyWith'] ?? null,
      type: json['type'] ?? '',
      appliedOn: json["appliedOn"] ?? '',
      date: json["date"] ?? '',
      status: json["status"] ?? '',
      userId: json["userId"] ?? 0,
      session: json["session"] ?? '',
      reviewedBy: json["reviewedBy"] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'days': days,
      'assignToName': currentlyWith,
      'type': type,
      'userId': userId,
      'status': status,
      'appliedOn': appliedOn,
      'date': date,
      'session': session,
      'reviewedBy': reviewedBy,
    };
  }
}

class LeaveRequestRecord {
  int idPk;
  int? id;
  String date;
  String? time;
  String? location;
  String workMode;
  int userId;
  bool? currStatus;
  String? remarks;
  int leaveRequestStatusIdFk;

  LeaveRequestRecord({
    required this.idPk,
    required this.id,
    required this.date,
    required this.time,
    required this.location,
    required this.workMode,
    required this.userId,
    required this.currStatus,
    required this.remarks,
    required this.leaveRequestStatusIdFk,
  });

  factory LeaveRequestRecord.fromJson(Map<String, dynamic> json) {
    return LeaveRequestRecord(
      idPk: json['id_pk'],
      id: json['id'],
      date: json['date'] ?? '',
      time: json['time'],
      location: json['location'] ?? '',
      workMode: json['workMode'],
      userId: json['userId'] ?? 0,
      currStatus: json['currStatus'],
      remarks: json['remarks'],
      // Handle null remarks
      leaveRequestStatusIdFk: json['leaveRequestStatusIdFk'],
    );
  }
}

class LeaveRequest {
  int requestId;
  String leaveRequestDate;
  int userId;
  String status;
  String? remarks;
  int? approvedBy;
  String? approvedByName;
  List<LeaveRequestRecord> leaveRequestRecords;
  String appliedOn;
  String mailId;
  String type;
  String name;
  bool allowed;
  String? transferBy;
  String? transferTo;

  LeaveRequest(
      {required this.requestId,
      required this.leaveRequestDate,
      required this.userId,
      required this.status,
      this.remarks,
      this.approvedBy,
      this.approvedByName,
      required this.leaveRequestRecords,
      required this.appliedOn,
      required this.mailId,
      required this.name,
      required this.type,
      required this.allowed,
      required this.transferBy,
      required this.transferTo});

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    var leaveRequestRecordsJson = json['leaveRequestRecords'] as List<dynamic>;
    List<LeaveRequestRecord> leaveRequestRecords = leaveRequestRecordsJson
        .map((recordJson) => LeaveRequestRecord.fromJson(recordJson))
        .toList();

    return LeaveRequest(
        allowed: json['allowed'] ?? false,
        requestId: json['requestId'] ?? 0,
        leaveRequestDate: json['leaveRequestDate'] ?? '',
        userId: json['userId'] ?? 0,
        status: json['status'] ?? '',
        remarks: json['remarks'] ?? '',
        approvedBy: json['approvedBy'] ?? 0,
        approvedByName: json['approvedByName'] ?? "",
        leaveRequestRecords: leaveRequestRecords,
        appliedOn: json['appliedOn'] ?? '',
        mailId: json['mailId'] ?? '',
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        transferTo: json['transferTo'] ?? null,
        transferBy: json['transferBy'] ?? null);
  }


}

class ManagerTeamAttendance {
  final int userId;
  final String name;
  final String jobTitle;
  final int present;
  final int absent;
  final int late;
  final int leave;
  final String totalHours;
  final String empId;
  final String shiftName;

  ManagerTeamAttendance(
      {required this.userId,
      required this.name,
      required this.jobTitle,
      required this.present,
      required this.absent,
      required this.late,
      required this.leave,
      required this.totalHours,
      required this.empId,
      required this.shiftName});

  factory ManagerTeamAttendance.fromJson(Map<String, dynamic> json) {
    return ManagerTeamAttendance(
        userId: json['userId'] ?? 0,
        name: json['name'] ?? '',
        present: json['present'] ?? 0,
        absent: json['absent'] ?? 0,
        late: json['late'] ?? 0,
        leave: json['leave'] ?? 0,
        totalHours: json['totalHours'] ?? '',
        jobTitle: json['jobTitle'] ?? '',
        empId: json['empId'] ?? '',
        shiftName: json['shiftName'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'jobTitle': jobTitle,
      'present': present,
      'absent': absent,
      'late': late,
      'leave': leave,
      'totalHours': totalHours,
      'empId': empId,
      'shiftName': shiftName,
    };
  }
}

class GetManagerDetails {
  final String name;
  final String mail;
  final String designation;

  GetManagerDetails(
      {required this.name, required this.mail, required this.designation});

  factory GetManagerDetails.fromJson(Map<String, dynamic> json) {
    return GetManagerDetails(
        name: json['name'] ?? '',
        mail: json['mail'] ?? '',
        designation: json['designation'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      name: name,
      mail: mail,
      designation: designation,
    };
  }
}

class UserShiftDetails {
  final int id;
  final String shiftName;
  final String startTime;

  UserShiftDetails({
    required this.id,
    required this.shiftName,
    required this.startTime,
  });

  factory UserShiftDetails.fromJson(Map<String, dynamic> json) {
    return UserShiftDetails(
      id: json['id'] ?? 0,
      shiftName: json['shiftName'] ?? "",
      startTime: json['startTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shiftName': shiftName,
      'startTime': startTime,
    };
  }
}

class LeaveData {
  final String type;
  final double value;

  LeaveData({required this.type, required this.value});

  factory LeaveData.fromJson(Map<String, dynamic> json) {

    final String leaveType = json.keys.first;
    final double leaveValue = json.values.first;
    return LeaveData(type: leaveType, value: leaveValue);

  }
}

class TypesOfLeaveTaken {
  final double casualLeave;
  final double earnedLeave;
  final double paternityLeave;
  final double sickLeave;
  final double lossOfPay;
  final double workFromHome;
  final double total;

  TypesOfLeaveTaken({
    required this.casualLeave,
    required this.earnedLeave,
    required this.paternityLeave,
    required this.sickLeave,
    required this.lossOfPay,
    required this.workFromHome,
    required this.total,
  });

  factory TypesOfLeaveTaken.fromJson(Map<String, dynamic> json) {
    print("Parsing JSON data: $json");

    return TypesOfLeaveTaken(
      casualLeave: json['Casual Leave'] ?? 0.0,
      earnedLeave: json['Earned Leave'] ?? 0.0,
      paternityLeave: json['Paternity Leave'] ?? 0.0,
      sickLeave: json['Sick Leave'] ?? 0.0,
      lossOfPay: json['Loss Of Pay'] ?? 0.0,
      workFromHome: json['Work From Home'] ?? 0.0,
      total: json['total'] ?? 0.0,
    );
  }
}

class LeaveCountCalendar {
  final String date;
  final int count;

  LeaveCountCalendar({
    required this.date,
    required this.count,
  });

  factory LeaveCountCalendar.fromJson(Map<String, dynamic> json) {
    return LeaveCountCalendar(
      date: json['date'] ?? '',
      count: json['count'] ?? 0,
    );
  }

  @override
  String toString() {
    return '$count';
  }
}


