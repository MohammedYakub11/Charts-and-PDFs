import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testings/Admin%20Shift%20Roster%20Table/search_box.dart';
import '../Admin Leave Calendar Screen/widgets/attendance_provider.dart';
import '../constants/colors.dart';

class PaginatedTableForRoster extends ConsumerStatefulWidget {
  const PaginatedTableForRoster({super.key});

  @override
  ConsumerState<PaginatedTableForRoster> createState() =>
      _PaginatedTableForRosterState();

}

class _PaginatedTableForRosterState
    extends ConsumerState<PaginatedTableForRoster> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Container(
      height: MediaQuery.of(context).size.height * 0.595,
      width: MediaQuery.of(context).size.width * 0.7104023,


      // decoration: containerDecoration(),
      child: PaginatedDataTable(
              key: UniqueKey(),

              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              arrowHeadColor: AppColors.greyDarkColor,
              dataRowHeight: 60,
              columnSpacing: 0,
              horizontalMargin: 0,
              headingRowHeight: 60,
              dragStartBehavior: DragStartBehavior.start,
              showCheckboxColumn: true,
              columns: [
                DataColumn(
                  label: BorderedCell(
                    child: Center(
                      child: SearchBoxForRoster(
                        controller: searchController,
                        onSearch: (query) {
                          ref.read(filterQueryProvider.notifier).state = query;
                        },
                      ),
                    ),
                    width: 250,
                    height: 60,
                  ),
                ),
                DataColumn(
                  label: BorderedCell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Sunday'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '01/01/2024',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.62 / 8,
                      height: 60),
                ),
                DataColumn(
                  label: BorderedCell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Monday'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '01/01/2024',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.62 / 8,
                      height: 60),
                ),
                DataColumn(
                  label: BorderedCell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tuesday',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '01/01/2024',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.62 / 8,
                      height: 60),
                ),
                DataColumn(
                  label: BorderedCell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Wednesday'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '01/01/2024',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.62 / 8,
                      height: 60),
                ),
                DataColumn(
                  label: BorderedCell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Thursday'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '01/01/2024',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.62 / 8,
                      height: 60),
                ),
                DataColumn(
                  label: BorderedCell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Friday'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '01/01/2024',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.62 / 8,
                      height: 60),
                ),
                DataColumn(
                  label: BorderedCell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Saturday'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '01/01/2024',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.62 / 8,
                      height: 60),
                ),
              ],
              source: MyData(

                  searchQuery: '',
                  cellWidth: MediaQuery.of(context).size.width * 0.62 / 8,
                  cellHeight: 60),
              rowsPerPage: 5, // Number of rows per page
            )

    );
  }
}

class MyData extends DataTableSource {
  final String searchQuery;
  final double cellWidth;
  final double cellHeight;

  MyData(
      {required this.searchQuery,
      required this.cellWidth,
      required this.cellHeight});

  final List<Map<String, dynamic>> _data = [
    // Example data
    {
      "name": "John",
      "Sunday": "Week Off",
      "Monday": "Week Off",
      "Tuesday": "Office Bay",
      "Wednesday": "ITS",
      "Thursday": "Holiday",
      "Friday": "IITT",
      "Saturday": "Week Off",
    },
    {
      "name": "Jane",
      "Sunday": "Week Off",
      "Monday": "Week Off",
      "Tuesday": "Office Bay",
      "Wednesday": "ITS",
      "Thursday": "Holiday",
      "Friday": "",
      "Saturday": "Week Off",
    },
    {
      "name": "adsf",
      "Sunday": "Week Off",
      "Monday": "WFH",
      "Tuesday": "Office Bay",
      "Wednesday": "ITS",
      "Thursday": "Leave",
      "Friday": "",
      "Saturday": "Week Off",
    },
    {
      "name": "dfgdfg",
      "Sunday": "Week Off",
      "Monday": "Week Off",
      "Tuesday": "Office Bay",
      "Wednesday": "",
      "Thursday": "Holiday",
      "Friday": "IITT",
      "Saturday": "WFH",
    },
    {
      "name": "bzxcxb",
      "Sunday": "Week Off",
      "Monday": "",
      "Tuesday": "Office Bay",
      "Wednesday": "WFH",
      "Thursday": "Holiday",
      "Friday": "IITT",
      "Saturday": "Week Off",
    },
    {
      "name": "ewerwer",
      "Sunday": "Week Off",
      "Monday": "WFH",
      "Tuesday": "Office Bay",
      "Wednesday": "ITS",
      "Thursday": "Holiday",
      "Friday": "IITT",
      "Saturday": "Week Off",
    },
    // Add more data
  ];
  bool isChecked = false; // State variable to track checkbox state
  Color? getColor(String value) {
    switch (value) {
      case 'Office Bay':
        return Color(0xFF966376);
      case 'ITS':
        return Color(0xFF5FA447);
      case 'IITT':
        return Color(0xFFB06D08);
      case 'WFH':
        return Color(0xFF42A5AB);
      case 'Leave':
        return Color(0xFFF3AF00);
      case 'Holiday':
        return Color(0xFF9F4CAC);
      default:
        return null;
    }
  }

  bool _hovered = false;

  Widget buildDecoratedCell(String value) {
    Color? color = getColor(value);

    if (value == 'Office Bay' ||
        value == 'ITS' ||
        value == 'IITT' ||
        value == 'WFH') {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: Container(
              width: 60,
              height: 23,
              decoration: BoxDecoration(
                color: color?.withOpacity(0.02),
                border: Border.all(color: color!),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(color: color, fontSize: 11),
                ),
              ),
            ),
          ),
          IconButton(
            constraints: BoxConstraints(maxWidth: 20.97),
            focusColor: color,
            onPressed: () {},
            icon: Icon(
              size: 15,
              Icons.edit_outlined,
              color: Color(0xffFE6A6A),
            ),
            splashRadius: 10,
          )
        ],
      );
    } else if (value == 'Week Off') {
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: HoverableCell(
          value: value,
          builder: (hovered) {
            if (hovered) {
              return Container(
                width: 300,
                height: 150,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle,
                    color: AppColors.mainTheme,
                    size: 24,
                  ),
                  splashRadius: 0.1,
                ),
              );
            } else {
              return Center(
                child: Text(
                  value,
                  style: TextStyle(color: Colors.black, fontSize: 11),
                ),
              );
            }
          },
        ),
      );
    } else if (value == 'Leave' || value == 'Holiday') {
      return Text(
        value,
        style: TextStyle(color: getColor(value), fontSize: 11),
      );
    } else {
      // Handle empty or null values
      return Container(
        width: 300,
        height: 150,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_circle,
            color: AppColors.mainTheme,
            size: 24,
          ),
          splashRadius: 0.1,
        ),
      );
    }
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final row = _data[index];
    if (searchQuery.isNotEmpty && !row['name'].contains(searchQuery)) {
      return null;
    }
    return DataRow(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          // Alternate colors: even rows grey, odd rows white
          return index.isEven ? Color(0xffEDF6FF) : Colors.white;
        }),
        cells: [
          DataCell(BorderedCell(
            child: UserDetailsWidget(
              name: row['name'],
              shift: 'General',
              date: '01/01/2024 to 01/01/2024',
              // Replace with your date logic
              userImage: AssetImage('images/default_profile.png'),
              checkBox:
                  Container(height: 14, width: 12, child: CheckboxExample()),
            ),
            width: 250,
            height: cellHeight,
          )),
          DataCell(BorderedCell(
            child: Container(
                width: cellWidth / 1.26,
                height: cellHeight / 1.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0x8071839B), width: 0.25),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: buildDecoratedCell(row['Sunday'])),
            width: cellWidth,
            height: cellHeight,
          )),
          DataCell(BorderedCell(
            child: Container(
                width: cellWidth / 1.26,
                height: cellHeight / 1.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0x8071839B), width: 0.25),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(child: buildDecoratedCell(row['Monday']))),
            width: cellWidth,
            height: cellHeight,
          )),
          DataCell(BorderedCell(
            child: Container(
                width: cellWidth / 1.26,
                height: cellHeight / 1.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0x8071839B), width: 0.25),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(child: buildDecoratedCell(row['Tuesday']))),
            width: cellWidth,
            height: cellHeight,
          )),
          DataCell(BorderedCell(
            child: Container(
                width: cellWidth / 1.26,
                height: cellHeight / 1.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0x8071839B), width: 0.25),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(child: buildDecoratedCell(row['Wednesday']))),
            width: cellWidth,
            height: cellHeight,
          )),
          DataCell(BorderedCell(
            child: Container(
                width: cellWidth / 1.26,
                height: cellHeight / 1.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0x8071839B), width: 0.25),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(child: buildDecoratedCell(row['Thursday']))),
            width: cellWidth,
            height: cellHeight,
          )),
          DataCell(BorderedCell(
            child: Container(
                width: cellWidth / 1.26,
                height: cellHeight / 1.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0x8071839B), width: 0.25),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(child: buildDecoratedCell(row['Friday']))),
            width: cellWidth,
            height: cellHeight,
          )),
          DataCell(BorderedCell(
            child: Container(
                width: cellWidth / 1.26,
                height: cellHeight / 1.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0x8071839B), width: 0.25),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(child: buildDecoratedCell(row['Saturday']))),
            width: cellWidth,
            height: cellHeight,
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}

class BorderedCell extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  BorderedCell(
      {required this.child, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0x8071839B), width: 0.25),
      ),
      child: Center(child: child),
    );
  }
}

class UserDetailsWidget extends StatelessWidget {
  final String name;
  final String date;
  final ImageProvider<Object>? userImage; // Optional user image widget
  final Widget checkBox;
  final String shift;

  UserDetailsWidget({
    required this.name,
    required this.date,
    required this.userImage,
    required this.checkBox,
    required this.shift,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 8),
        checkBox,
        SizedBox(width: 8),
        CircleAvatar(
          radius: 16,
          backgroundImage:
              userImage, // Replace with correct AssetImage or ImageProvider
        ),
        SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            Text(
              shift,
              style: TextStyle(
                  fontSize: 11,
                  color: AppColors.mainTheme,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                size: 18,
                Icons.edit_outlined,
                color: Colors.grey,
              ),
              splashRadius: 0.1,
            ),
          ],
        )
      ],
    );
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          unselectedWidgetColor: AppColors.mainTheme,
          visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5)),
      child: Transform.scale(
        scale: 0.8, // Adjust this value to scale the checkbox size

        child: Checkbox(
          splashRadius: 0.1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          activeColor: AppColors.mainTheme,
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
      ),
    );
  }
}

class HoverableCell extends StatefulWidget {
  final String value;
  final Widget Function(bool) builder;

  HoverableCell({required this.value, required this.builder});

  @override
  _HoverableCellState createState() => _HoverableCellState();
}

class _HoverableCellState extends State<HoverableCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _hovered = true),
      onExit: (event) => setState(() => _hovered = false),
      child: widget.builder(_hovered),
      cursor: MouseCursor.defer,
    );
  }
}
