import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../common/text_widgets.dart';

class YearDropdownButton extends StatelessWidget {
  final int selectedYear ;
  final List<int> years;
  final Function(int) onYearSelected;

  const YearDropdownButton({
    Key? key,
    required this.selectedYear,
    required this.years,
    required this.onYearSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final adjustedSelectedYear = selectedYear < years.first ? years[0] : selectedYear;

    // Check if selectedYear is in the years list
    assert(years.contains(selectedYear), "selectedYear must be in the years list");

    // Check for duplicate values in the years list
    assert(years.toSet().length == years.length, "years list contains duplicate values");
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: SizedBox(
        width: 80,
        child: DropdownButtonHideUnderline(

          child: DropdownButton2<int>(
            dropdownStyleData: DropdownStyleData(

              maxHeight: 100,
              width: 103,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(30),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 40,
              padding: const EdgeInsets.only(left: 14, right: 14),
              selectedMenuItemBuilder: (BuildContext context, Widget? item) {
                return Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.grey.shade300,
                  child: item,
                );
              },
            ),

            value: adjustedSelectedYear ,
            onChanged: (int? newYear) {
              if (newYear != null) {
                onYearSelected(newYear);
              }
            },

            items: years.map((int year) {
              return DropdownMenuItem<int>(
                value: year,
                child: Center(
                  child: text15Normal(
                    text: year.toString(),
                    color: const Color(0xff585757),// Customize the text color for selected year
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
