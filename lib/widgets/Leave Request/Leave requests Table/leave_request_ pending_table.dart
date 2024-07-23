import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Pages/leave_request.dart';
import '../../../common/model/common.dart';
import '../../../common/model/user.dart';
import '../../../common/provider/leave_request/leave_request.dart';
import '../../../common/utils/date_utils.dart';
import '../../../common/utils/image_res.dart';
import '../../../constants/colors.dart';
import '../paginated_widget.dart';

final userProvider = StateProvider<EmployeeDetails?>((ref) => null);

class PendingTableLeaveRequest extends ConsumerStatefulWidget {
  @override
  _PendingTableLeaveRequestState createState() =>
      _PendingTableLeaveRequestState();
}

class _PendingTableLeaveRequestState
    extends ConsumerState<PendingTableLeaveRequest> {
  Future<EmployeeLeaveRequest> _parseJson(String jsonString) async {
    final Map<String, dynamic> parsed = jsonDecode(jsonString);
    return EmployeeLeaveRequest.fromJson(parsed);
  }

  Future<String> _loadJsonFile() async {
    return await rootBundle.loadString('assets/sample.json');
  }

  Future<EmployeeLeaveRequest> _loadAndParseData() async {
    String jsonString = await _loadJsonFile();
 // Add a console message

    return _parseJson(jsonString);
  }

  bool sort = true;
  bool sortAscending = true;
  int sortColumnIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadAndParseData().then((leave) {
      final convertedData = PendingTableListForLeaveRequest(
        id: leave.id,
        userId: leave.userId,
        days: leave.days,
        type: leave.type,
        currentlyWith: leave.currentlyWith,
        appliedOn: leave.appliedOn,
        status: leave.status,
        date: leave.date,
        session: leave.session,
        reviewedBy: leave.reviewedBy,
      );
      ref.read(getPendingListForLeaveRequestEmployeeProvider.notifier).state = [
        convertedData
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final pendingList =
        ref.watch(getPendingListForLeaveRequestEmployeeProvider);
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: PaginatedDataTable(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => AppColors.mainTheme),
        rowsPerPage: 10,
        columnSpacing: 30,
        horizontalMargin: 15,
        headingRowHeight: 40,
        dataRowHeight: 45,
        columns: [
          PaginatedWidgets.dataColumnWithFilter(
            onTap: () {
              const index = 0;
              // onSortColumn(index, !sortAscending,ref);
            },
            columnName: 'Req Id',
            iconOfColumn: sortColumnIndex == 0
                ? sortAscending
                    ? ImageRes.table_down_arrowicon
                    : ImageRes.table_up_arrowicon
                : ImageRes.table_up_arrowicon,
          ),
          PaginatedWidgets.dataColumnWithFilter(
            onTap: () {
              const index = 1;
              // onSortColumn(index, !sortAscending,ref);
            },
            columnName: 'No. of Days',
            iconOfColumn: sortColumnIndex == 1
                ? sortAscending
                    ? ImageRes.table_down_arrowicon
                    : ImageRes.table_up_arrowicon
                : ImageRes.table_up_arrowicon,
          ),
          PaginatedWidgets.dataColumnWithFilter(
            onTap: () {
              const index = 2;
              // onSortColumn(index, !sortAscending,ref);
            },
            columnName: 'Leave Type',
            iconOfColumn: sortColumnIndex == 2
                ? sortAscending
                    ? ImageRes.table_down_arrowicon
                    : ImageRes.table_up_arrowicon
                : ImageRes.table_up_arrowicon,
          ),
          PaginatedWidgets.dataColumnWithFilter(
            onTap: () {
              const index = 3;
              // onSortColumn(index, !sortAscending,ref);
            },
            columnName: 'Currently With',
            iconOfColumn: sortColumnIndex == 3
                ? sortAscending
                    ? ImageRes.table_down_arrowicon
                    : ImageRes.table_up_arrowicon
                : ImageRes.table_up_arrowicon,
          ),
        ],
        source: pendingList!.isNotEmpty
            ? CustomDataSourceForPending(
                ref: ref,
                data: pendingList ?? [],
                onRowSelected: (row) {
                  setState(() {
                    ref.read(selectedReqIdProvider.notifier).state =
                        row['id'];
                    ref
                        .read(selectedLeaveRequestDaysProvider.notifier)
                        .state = row['days'];
                    ref.read(selectedLeaveTypeProvider.notifier).state =
                        row['type'];
                    ref.read(selectedCurrentlyWithProvider.notifier).state =
                        row['currentlyWith'];
                  });
                },
              )
            : ErrorDataSourceForPending(),
      ),
    );
  }
// void onSortColumn(int columnIndex, bool ascending,WidgetRef ref) {
//   if (columnIndex == 0) {
//     if (ascending) {
//       ref.read(getPendingListForLeaveRequestEmployeeProvider)?.sort((a, b) {
//         return a.requestId.toString().compareTo(b.requestId.toString());
//       });
//     } else {
//       ref.read(getPendingListForLeaveRequestEmployeeProvider)?.sort((a, b) {
//         return b.requestId.toString().compareTo(a.requestId.toString());
//       });
//     }
//   } else if (columnIndex == 1) {
//     if (ascending) {
//       ref.read(getPendingListForLeaveRequestEmployeeProvider)?.sort((a, b) {
//         return a.pendingWith
//             .trim()
//             .toLowerCase()
//             .compareTo(b.pendingWith.trim().toLowerCase());
//       });
//     } else {
//       ref.read(getPendingListForLeaveRequestEmployeeProvider)?.sort((a, b) {
//         return b.pendingWith
//             .trim()
//             .toLowerCase()
//             .compareTo(a.pendingWith.trim().toLowerCase());
//       });
//     }
//
//   } else if (columnIndex == 2) {
//     if (ascending) {
//       ref.read(getPendingListForLeaveRequestEmployeeProvider)?.sort((a, b) {
//         return a.date.trim()
//             .toLowerCase()
//             .compareTo(b.date.trim().toLowerCase());
//       });
//     } else {
//       ref.read(getPendingListForLeaveRequestEmployeeProvider)?.sort((a, b) {
//         return b.date
//             .trim()
//             .toLowerCase()
//             .compareTo(a.date.trim().toLowerCase());
//       });
//     }
//
//   }
//   else {
//     // Handle sorting for other columns
//   }
//
//   setState(() {
//     sortColumnIndex = columnIndex;
//     sortAscending = ascending;
//   });
// }
}

class CustomDataSourceForPending extends DataTableSource {
  final Function(Map<String, dynamic> row) onRowSelected;

  CustomDataSourceForPending(
      {required this.onRowSelected, required this.data, required this.ref});

  final List<PendingTableListForLeaveRequest> data;
  final WidgetRef ref;

  @override
  DataRow getRow(int index) {
    final pendingData = data[index];
    return DataRow.byIndex(
      index: index,
      color: MaterialStateColor.resolveWith((states) => index % 2 == 0
          ? const Color(0xffE3F2FD).withOpacity(0.8)
          : Colors.white),
      cells: [
        DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                profileTap(pendingData);
              },
              child: text15Normal(
                text: '#${pendingData.id}',
                color: AppColors.shiftTableCellColor,
              )),
        )),
        DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                profileTap(pendingData);
              },
              child: text15Normal(
                text: '#${pendingData.days}',
                color: AppColors.shiftTableCellColor,
              )),
        )),
        DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                profileTap(pendingData);
              },
              child: text15Normal(
                text: pendingData.type.toString(),
                color: AppColors.shiftTableCellColor,
              )),
        )),
        DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                profileTap(pendingData);
              },
              child: text15Normal(
                text: pendingData.currentlyWith.toString(),
                color: AppColors.shiftTableCellColor,
              )),
        )),
      ],
      selected: false, // Set selected to false to remove checkboxes
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  void profileTap(PendingTableListForLeaveRequest pendingData) {
    onRowSelected(pendingData.toMap());
    ref
        .read(getDetailsOfLeaveRequestEmployeeProvider.notifier)
        .getDetailsOfLeaveRequest(
            id: pendingData.id!,
            days: pendingData.days!,
            currentlyWith: pendingData.currentlyWith,
            type: pendingData.type,
            appliedOn: pendingData.appliedOn,
            userId: pendingData.userId!,
            status: pendingData.status,
            date: pendingData.date,
            session: pendingData.session,
            reviewedBy: pendingData.reviewedBy,
    );
  }
}

final selectedReqIdProvider = StateProvider<int?>((ref) => null);
final selectedLeaveRequestDaysProvider = StateProvider<double?>((ref) => null);
final selectedCurrentlyWithProvider = StateProvider<String?>((ref) => null);
final selectedLeaveTypeProvider = StateProvider<String?>((ref) => null);

class ErrorDataSourceForPending extends DataTableSource {
  ErrorDataSourceForPending();

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      color: MaterialStateColor.resolveWith((states) => index % 2 == 0
          ? const Color(0xffE3F2FD).withOpacity(0.8)
          : Colors.white),
      cells: const [
        DataCell(Text('')),
        DataCell(text15Normal(
          text: 'No Data Available',
          color: Colors.red,
        )),
        DataCell(Text('')),
        DataCell(Text('')),
      ],
      selected: false, // Set selected to false to remove checkboxes
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 1;

  @override
  int get selectedRowCount => 0;
}
