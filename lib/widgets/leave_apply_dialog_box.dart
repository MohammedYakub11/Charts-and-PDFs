import 'package:flutter/material.dart';
import 'package:flutter_testings/constants/colors.dart';
import 'package:flutter_testings/constants/divider.dart';
import 'package:flutter_testings/constants/text.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaveApplyDialogbox extends StatelessWidget {
  const LeaveApplyDialogbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),),
        width: 840,
        height: 784,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 800,
                  decoration: BoxDecoration(
                    color: AppColors.mainTheme,
                  ),
                  child: Center(
                    child: Text(
                      "Leave Apply",
                      style: GoogleFonts.ibmPlexSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Ink(
                  height: 45,
                  width: 40,
                  decoration: ShapeDecoration(
                    color: AppColors.mainTheme, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          0.0), // Adjust border radius as needed
                    ),

                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.highlight_off_outlined,
                      color: Colors.white,size: 25,
                    ),
                    // Change icon as needed
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 subTitleText(
                   text: "Leave Type : ",
                 ),
                  subTitleText(
                    text: "Balance : ",
                  )
                ],
              ),
            ),
            greyDivider(),



          ],
        ),
      ),
    );
  }
}
