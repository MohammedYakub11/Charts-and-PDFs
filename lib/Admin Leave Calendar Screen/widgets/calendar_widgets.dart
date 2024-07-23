
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/text_widgets.dart';
import '../../constants/colors.dart';
const commonTextStyle = TextStyle(
  color: Color(0xff5F5F5F), // Adjust the color as needed
  fontSize:15,
  fontWeight: FontWeight.bold,
);

class CalendarDecorations {
  static Widget? dowBuilder(BuildContext context, DateTime day){
    if (day.weekday == DateTime.sunday ||
        day.weekday == DateTime.monday ||
        day.weekday == DateTime.tuesday ||
        day.weekday == DateTime.wednesday ||
        day.weekday == DateTime.thursday ||
        day.weekday == DateTime.friday ||
        day.weekday == DateTime.saturday) {
      final text = DateFormat.E()
          .format(day)
          .toUpperCase();

      return Container(
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: Color(0xffE8E8E8), width: 0.5),
          ),
          color: AppColors.mainTheme,
          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    // Return a default Widget in case the condition is not met
    return null; // You can customize this default Widget
  }

  static Widget defaultBuilder(BuildContext context, DateTime date, Map<DateTime,String?> staticData) {
    final status = staticData[DateTime(date.year, date.month, date.day)];
    BoxDecoration? boxDecoration;
    if (status == 'Present') {
      boxDecoration = const BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.presentLightColor,
        border: Border(
          left: BorderSide(color:AppColors.presentStatusColor, width: 5),
        ),
      );
    } else if (status == 'Absent') {
      boxDecoration = const BoxDecoration(
        border: Border(
          left: BorderSide(color:AppColors.absentStatusColor, width: 5),
        ),

        shape: BoxShape.rectangle,
        color: AppColors.absentLightColor,
      );
    } else if (status == 'Late') {
      boxDecoration = const BoxDecoration(
        border: Border(
          left: BorderSide(color:AppColors.lateStatusColor, width: 5),
        ),
        shape: BoxShape.rectangle,
        color:AppColors.lateLightColor,
      );

    } else if (status == 'Holiday') {
      boxDecoration =  const BoxDecoration(
        shape: BoxShape.rectangle,
        border:  Border(
          left: BorderSide(color:AppColors.holidayStatusColor, width:5),
        ),

        color:AppColors.holidayLightColor,
      );

    } else if (status == 'Leave') {
      boxDecoration = const BoxDecoration(
        border:  Border(
          left: BorderSide(color:AppColors.leaveStatusColor, width:5),
        ),
        shape: BoxShape.rectangle,
        color:AppColors.leaveLightColor,
      );}else {
      boxDecoration = const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
      );

    }

    return Container(
      decoration: boxDecoration,
      child: Center(
        child:text15Normal(text: date.day.toString(),color: const Color(0xff5F5F5F),),
      ),
    );
  }

}

