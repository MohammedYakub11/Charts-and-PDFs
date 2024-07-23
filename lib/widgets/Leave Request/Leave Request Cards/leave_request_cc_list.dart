import 'package:flutter/material.dart';
import 'package:flutter_testings/constants/colors.dart';

import 'leave_request_text_widget.dart';

class LeaveRequestCCList extends StatefulWidget {
  const LeaveRequestCCList({super.key});

  @override
  State<LeaveRequestCCList> createState() => _LeaveRequestCCListState();
}

class _LeaveRequestCCListState extends State<LeaveRequestCCList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeaveRequestTextWidget(
          title: 'CC : ',
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.075,
          width: MediaQuery.of(context).size.width * 0.150,
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 180 ? 2 : 3;
              double fontSize = constraints.maxWidth > 250
                  ? 12
                  : (constraints.maxWidth > 150 ? 13 : 14);

              // Add some padding

              // double width = constraints.maxWidth
              return Wrap(
                spacing: 7.0, // horizontal space between chips
                runSpacing: 6.0, // vertical space between rows of chips
                children: List.generate(
                  6, // or more as needed
                  (index) => Chip(
                    backgroundColor: AppColors.mainTheme,
                    label: Text(
                      'Refaydeen',
                      // Replace 'Hannah' with your dynamic text
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: fontSize),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
