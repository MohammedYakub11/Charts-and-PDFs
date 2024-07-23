import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/model/common.dart';
import '../../../common/model/user.dart';
import '../../../common/provider/leave_request/leave_request.dart';
import '../../../common/utils/image_res.dart';
import '../../../constants/colors.dart';
import '../paginated_widget.dart';

final selectedReqIdProvider = StateProvider<int?>((ref) => null);
final selectedLeaveRequestDaysProvider = StateProvider<double?>((ref) => null);
final selectedReviewedByProvider = StateProvider<String?>((ref) => null);
final selectedStatusProvider = StateProvider<String?>((ref) => null);
final selectedLeaveTypeProvider = StateProvider<String?>((ref) => null);

class HistoryTableLeaveRequest extends ConsumerStatefulWidget {
  @override
  _HistoryTableLeaveRequestState createState() =>
      _HistoryTableLeaveRequestState();
}

class _HistoryTableLeaveRequestState
    extends ConsumerState<HistoryTableLeaveRequest> {
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
      final convertedData = HistoryTableListForLeaveRequest(
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
      ref.read(getHistoryListForLeaveRequestEmployeeProvider.notifier).state = [
        convertedData
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyList =
    ref.watch(getHistoryListForLeaveRequestEmployeeProvider);
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: PaginatedDataTable(
        headingRowColor:
        MaterialStateColor.resolveWith((states) => AppColors.mainTheme),
        rowsPerPage: 10,
        columnSpacing: 22,
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
            columnName: 'Reviewed By',
            iconOfColumn: sortColumnIndex == 3
                ? sortAscending
                ? ImageRes.table_down_arrowicon
                : ImageRes.table_up_arrowicon
                : ImageRes.table_up_arrowicon,
          ),
          PaginatedWidgets.dataColumnWithFilter(
            onTap: () {
              const index = 4;
              // onSortColumn(index, !sortAscending,ref);
            },
            columnName: 'Status',
            iconOfColumn: sortColumnIndex == 3
                ? sortAscending
                ? ImageRes.table_down_arrowicon
                : ImageRes.table_up_arrowicon
                : ImageRes.table_up_arrowicon,
          ),
        ],
        source: historyList!.isNotEmpty
            ? CustomDataSourceForHistory(
          ref: ref,
          data: historyList ?? [],
          onRowSelected: (row) {
            setState(() {
              ref.read(selectedReqIdProvider.notifier).state =
              row['id'];
              ref
                  .read(selectedLeaveRequestDaysProvider.notifier)
                  .state = row['days'];
              ref.read(selectedLeaveTypeProvider.notifier).state =
              row['type'];
              ref.read(selectedReviewedByProvider.notifier).state = row['reviewedBy'];
              ref.read(selectedStatusProvider.notifier).state = row['status'];
            });
          },
        )
            : ErrorDataSourceForHistory(),
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

class CustomDataSourceForHistory extends DataTableSource {
  final Function(Map<String, dynamic> row) onRowSelected;

  CustomDataSourceForHistory(
      {required this.onRowSelected, required this.data, required this.ref});

  final List<HistoryTableListForLeaveRequest> data;
  final WidgetRef ref;

  @override
  DataRow getRow(int index) {
    final historyData = data[index];
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
                profileTap(historyData);
              },
              child: text15Normal(
                text: '#${historyData.id}',
                color: AppColors.shiftTableCellColor,
              )),
        )),
        DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                profileTap(historyData);
              },
              child: text15Normal(
                text: '#${historyData.days}',
                color: AppColors.shiftTableCellColor,
              )),
        )),
        DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                profileTap(historyData);
              },
              child: text15Normal(
                text: historyData.type.toString(),
                color: AppColors.shiftTableCellColor,
              )),
        )),
        DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                profileTap(historyData);
              },
              child: text15Normal(
                text: historyData.reviewedBy.toString(),
                color: AppColors.shiftTableCellColor,
              )),
        )),
        DataCell(MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                profileTap(historyData);
              },
              child: Row(
                children: [
                  _getIconForRowStatus(historyData.status),
                  const SizedBox(
                    width: 8,
                  ),
                  text15Normal(
                    text:  historyData.status.toString(),
                    color: _getTextColorForRowStatus(
                        historyData.status),
                  ),
                ],
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

  void profileTap(HistoryTableListForLeaveRequest historyData) {
    onRowSelected(historyData.toMap());
    ref
        .read(getDetailsOfLeaveRequestEmployeeProvider.notifier)
        .getDetailsOfLeaveRequest(
        id: historyData.id!,
        days: historyData.days!,
        currentlyWith: historyData.currentlyWith,
        type: historyData.type,
        appliedOn: historyData.appliedOn,
        userId: historyData.userId!,
        status: historyData.status,
        date: historyData.date,
        session: historyData.session,
        reviewedBy: historyData.reviewedBy,);
  }
}





class ErrorDataSourceForHistory extends DataTableSource {
  ErrorDataSourceForHistory();

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

Color _getTextColorForRowStatus(String status) {
  switch (status) {
    case 'Approved':
      return const Color(0xff4CAC56); // White text color for Approved status
    case 'Rejected':
      return const Color.fromRGBO(
          243, 0, 0, 0.5); // White text color for Rejected status
    case 'Withdraw':
      return const Color.fromRGBO(
          173, 35, 109, 0.6); // Black text color for Withdraw status
    default:
      return AppColors
          .tableCellColor; // Default text color if status doesn't match
  }
}

Widget _getIconForRowStatus(String status) {
  switch (status) {
    case 'Approved':
      return Icon(
        Icons.check_circle_outline,
        color: Color(0xff4CAC56),
        size: 18,
      );
    case 'Rejected':
      return Icon(
        Icons.highlight_off_outlined,
        color: Color.fromRGBO(243, 0, 0, 0.5),
        size: 18,

      );
    case 'Withdraw':
      return Icon(
        Icons.remove_circle_outline,
        color: Color.fromRGBO(173, 35, 109, 0.6),
        size: 18,

      );
    case 'Auto Reject':
      return Icon(
        Icons.highlight_off_outlined,
        color: Color.fromRGBO(243, 0, 0, 0.5),
        size: 18,

      );
    default:
      return SizedBox.shrink(); // Returns an empty widget
  }
}