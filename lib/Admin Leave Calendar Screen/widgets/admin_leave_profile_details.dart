import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_testings/Admin%20Leave%20Calendar%20Screen/widgets/view_document_dialog.dart';
import 'package:flutter_testings/common/provider/leave_request/leave_request.dart';

import '../../../common/model/user.dart';
import '../../../common/utils/date_utils.dart';
import '../../../constants/colors.dart';
import '../../../constants/text.dart';
import '../../common/provider/manager/provider.dart';
import '../../common/utils/image_res.dart';
import '../../widgets/Leave Request/Leave Request Cards/leave_request_text_widget.dart';
import '../../widgets/Leave Request/Leave requests Table/leave_request_ pending_table.dart';
import 'dart:convert';

import 'admin_calendar_text_widget.dart';

class AdminLeaveEmployeeProfile extends ConsumerWidget {
  AdminLeaveEmployeeProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedReqId = ref.watch(selectedReqIdProvider);


    final details = ref.watch(getDetailsOfLeaveRequestEmployeeProvider);

    return
      // Consumer(
      // builder: (context, watch, _) {
      // final selectedLeaveDetail = ref.watch(selectedLeaveDetailProvider);
      //
      // if (selectedLeaveDetail == null) {
      //   return Center(child: Text('Select a leave to see details'));
      // }
      // // final LeaveRequestDetailsHistoryProvider = ref.watch(LeaveRequestDetailsHistoryProvider(selectedLeaveDetail.id));

      // child:
    Column(
        mainAxisAlignment: selectedReqId == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            AdminLeaveCalendarTextWidget(
                              title: 'Request Id : ',
                              value: '${details?.userId}',

                              // value: '#${details!.id}',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 35.0),
                              child: Row(
                                children: [
                                   AdminLeaveCalendarTextWidget(
                                    title: 'Status : ',
                                    value: '${details?.status}',
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 100,
                                    alignment: Alignment.center,
                                    // decoration: BoxDecoration(
                                    //   color: const Color(0xffC9DDF3),
                                    //   border: Border.all(
                                    //       color: const Color.fromRGBO(
                                    //           54, 104, 158, 0.8)),
                                    //   borderRadius: BorderRadius.circular(5.0),
                                    // ),
                                    child: Row(
                                      children: [
                                        _getIconForRowStatus(details!.status),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        text15Inter(
                                          text: "Approved",
                                          // details.status,
                                          color: _getTextColorForRowStatus(
                                              details.status),
                                          // details.status, API to be called

                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            const AdminLeaveCalendarTextWidget(
                              title: 'Reviewed By : ',
                              value: "Kathrine",

                              // value: details.currentlyWith,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.height * 0.07,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            AdminLeaveCalendarTextWidget(
                              title: 'No of Days : ',
                              value: "#2.5",

                              // value: '${details.days}',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            AdminLeaveCalendarTextWidget(
                              title: 'Leave Type : ',
                              value: 'Casual Leave',
                              // value: '${details.type}',
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  AdminLeaveCalendarTextWidget(
                    title: 'Comments :',
                    value: 'Take Care',
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AdminLeaveCalendarTextWidget(
                        title: "Duration :  ",
                        value: "",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      // ValidDatesGrid(),
                    ],
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.0225,
                  ),
                  Text(
                    "Attachments : ",
                    style: const TextStyle(
                      color: AppColors.mainTheme,
                      fontSize: 15,
                      // fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.002,
                  ),
                  SvgPicture.asset(
                    ImageRes.pdf_icon,
                    // 'assets/icons/pdf_icon.svg',
                    height: 16,
                    width: 16,
                  ),
                  // _getIconForFile(), API to be called
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.002,
                  ),
                  Text(
                    "Receipt.pdf",
                    style: const TextStyle(
                        color: AppColors.shiftTableCellColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'IBMPlexSans'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.007,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => const ViewDocumentDialog());
                    },
                    child: Text(
                      'View',
                      style: TextStyle(
                          color: AppColors.mainTheme,
                          fontSize: 13,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  AdminLeaveCalendarTextWidget(
                    title: "Reason : ",
                    value: "Out of Station",
                  ),
                ],
              ),

              SizedBox(
                height: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      thickness: 2,
                      color: Color(0x8071839B),
                    ),
                  ],
                ),
              ),

              //
            ],
          ),
        ],
      );
      // }

  }
}

class ValidDatesGrid extends ConsumerWidget {
  ValidDatesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(getDetailsOfLeaveRequestEmployeeProvider);

    return details != null
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 8,
              childAspectRatio: 2.0,
            ),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 40,
                        width: 7,
                        decoration: const BoxDecoration(
                            color: AppColors.mainTheme,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text15Normal(
                              text: '31 Mar, 2024',
                              // details.date,
                              // DateTimeUtils.changeDateFormatForShowingUI(date!.date),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0065,
                            ),
                            text15Normal(
                              text: 'Full day',
                              // details.session,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ],
              );
            },
          )
        : Center(child: Text('No details available.'));
  }
}

class text15Normal extends StatelessWidget {
  const text15Normal(
      {Key? key,
      this.text = '',
      this.color = Colors.white,
      this.fontWeight = FontWeight.w500,
      this.textAlign})
      : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: color, fontWeight: fontWeight, fontSize: 15),
    );
  }
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

Widget _getIconForFile(String status) {
  switch (status) {
    case '.pdf':
      return Image(
        image: AssetImage(ImageRes.pdf_icon),
        width: 15,
        height: 15,
      );
    case '.png':
      return Image(
        image: AssetImage(ImageRes.png_icon),
        width: 15,
        height: 15,
      );

    default:
      return SizedBox.shrink(); // Returns an empty widget
  }
}
