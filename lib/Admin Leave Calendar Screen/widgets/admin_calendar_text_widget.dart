import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';

class AdminLeaveCalendarTextWidget extends StatelessWidget {
  const AdminLeaveCalendarTextWidget({super.key, required this.title, this.value, this.maxLines =1});

  final String title;
  final String? value;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.mainTheme,
              fontSize: 15,
              // fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8), // Add some space between title and value
          Text(
            value ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis, // Add this to handle overflow

            style: const TextStyle(
                color: AppColors.shiftTableCellColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'IBMPlexSans'),
          ),


        ],
      ),
    );
  }
}
