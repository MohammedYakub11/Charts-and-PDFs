import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testings/common/provider/leave_request/leave_request.dart';

import '../../../Admin Leave Calendar Screen/widgets/admin_leave_profile_details.dart';
import '../../../common/model/user.dart';
import '../../../common/utils/date_utils.dart';
import '../../../constants/colors.dart';
import '../../../constants/text.dart';
import '../Leave requests Table/leave_request_ pending_table.dart';
import '../paginated_widget.dart';
import 'dart:convert';

import 'leave_request_cc_list.dart';
import 'leave_request_text_widget.dart';
import 'leave_request_withdraw_dialog.dart';

class HistoryDetailsCard extends ConsumerWidget {
  HistoryDetailsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedReqId = ref.watch(selectedReqIdProvider);
    final selectedCurrentlyWith = ref.watch(selectedCurrentlyWithProvider);
    final selectedLeaveRequestDays =
        ref.watch(selectedLeaveRequestDaysProvider);
    final selectedLeaveType = ref.watch(selectedLeaveTypeProvider);

    final details = ref.watch(getDetailsOfLeaveRequestEmployeeProvider);
    // final todayDetails=ref.watch(todaysActivityProvider);
    // final previousDetails=ref.watch(getPreviousEntriesProvider);
    // final changeDetails=ref.watch(changeEntriesProvider);

    return Column(
      mainAxisAlignment: selectedReqId == null
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        //default text
        if (selectedReqId == null)
          Center(
              child: text15Inter(
            text: 'Click on a person from the table to view their full details',
            color: Color(0xff9AB3CE),
            fontWeight: FontWeight.w600,
          )),
        if (selectedReqId != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 35.0,
                          ),
                          child: text15Inter(
                            text: 'Applied On:',
                            color: AppColors.mainTheme,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        text15Inter(
                          text: "31 May, 2024", // API to be integrated
                          // DateTimeUtils.formatDate(details!.appliedOn),
                          color: AppColors.mainTheme,
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 12.0),
                  //   child: IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //         Icons.mode_edit_outline_outlined,
                  //         color: AppColors.mainTheme,
                  //         size: 20,
                  //       )),
                  // )
                ],
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.02,
              // ),
              const Divider(
                thickness: 2,
                color: Color(0x8071839B),

              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.56,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.035,
                              ),
                              LeaveRequestTextWidget(
                                title: 'Request Id :',
                                value: '#${details!.id}',
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.035,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Row(
                                  children: [
                                    const text15Inter(
                                      text: 'Status : ',
                                      color: AppColors.mainTheme,
                                      fontWeight: FontWeight.w600,
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
                                          _getIconForRowStatus(details.status),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          text15Inter(
                                            text: details.status,
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
                                height: MediaQuery.of(context).size.height * 0.035,
                              ),
                              LeaveRequestTextWidget(
                                title: 'Reviewed By :',
                                value: details.currentlyWith,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.035,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.035,
                              ),
                              LeaveRequestTextWidget(
                                title: 'No of Days :',
                                value: '${details.days}',
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.035,
                              ),
                              LeaveRequestTextWidget(
                                title: 'Leave Type :',
                                value: '${details.type}',

                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.045,
                              ),
                              LeaveRequestCCList(),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          LeaveRequestTextWidget(
                            title: 'Comments :',
                            value: '',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LeaveRequestTextWidget(
                                title: "Duration :  ",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.015,
                              ),
                              SizedBox(
                                width: 350,
                                child: ValidDatesGrid(),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        children: [
                          LeaveRequestTextWidget(
                            title: "Attachments :  ",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        children: [
                          LeaveRequestTextWidget(
                            title: "Reason :  ",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
