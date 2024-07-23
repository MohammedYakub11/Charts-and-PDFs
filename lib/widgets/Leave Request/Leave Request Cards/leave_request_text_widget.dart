import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class LeaveRequestTextWidget extends StatelessWidget {
  const LeaveRequestTextWidget(
      {super.key, required this.title, this.value, this.maxLines = 1});

  final String title;
  final String? value;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.mainTheme,
              fontSize: 15,
              fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8), // Add some space between title and value
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 150), // Set an appropriate width

            child: Text(
              value ?? '',
              // maxLines: maxLines,
              maxLines: 3,
              overflow: TextOverflow.ellipsis, // Add this to handle overflow
              softWrap: true,
              style: const TextStyle(
                  color: AppColors.shiftTableCellColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'IBMPlexSans'),
            ),
          ),
        ],
      ),
    );
  }
}
