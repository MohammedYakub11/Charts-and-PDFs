import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class LeaveCardTextWidget extends StatelessWidget {
  const LeaveCardTextWidget({
    super.key,
    required this.title,
    this.value,
    this.maxLines = 1,
    // required this.color,
  });

  final String title;
  final String? value;
  final int? maxLines;

  // final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.shiftTableCellColor,
              fontSize: 14,
              fontFamily: 'IBMPlexSans',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 4), // Add some space between title and value
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 150),
            // Set an appropriate width

            child: Text(
              value ?? '()',
              // maxLines: maxLines,
              maxLines: 3,
              overflow: TextOverflow.ellipsis, // Add this to handle overflow
              softWrap: true,
              style: const TextStyle(
                  color: AppColors.shiftTableCellColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'IBMPlexSans'),
            ),
          ),
        ],
      ),
    );
  }
}
