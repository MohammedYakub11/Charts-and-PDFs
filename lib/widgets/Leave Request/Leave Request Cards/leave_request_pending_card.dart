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
import 'dart:convert';

import 'leave_request_cc_list.dart';
import 'leave_request_text_widget.dart';
import 'leave_request_withdraw_dialog.dart';

class PendingDetailsCard extends ConsumerWidget {
  PendingDetailsCard({super.key});

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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 35.0),
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
                        text: "31 May, 2024",
                        // API to be called
                        // DateTimeUtils.formatDate(details!.appliedOn),
                        color: AppColors.mainTheme,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mode_edit_outline_outlined,
                          color: AppColors.mainTheme,
                          size: 20,
                        )),
                  )
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035,
                                  ),
                                  LeaveRequestTextWidget(
                                    title: 'Request Id :',
                                    value: '#${details!.id}',
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
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
                                              _getIconForRowStatus(
                                                  details.status),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              text15Inter(
                                                text: details.status,
                                                color:
                                                    _getTextColorForRowStatus(
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
                                    height: MediaQuery.of(context).size.height *
                                        0.035,
                                  ),
                                  LeaveRequestTextWidget(
                                    title: 'Currently with :',
                                    value: '${details.currentlyWith}',
                                    maxLines: 3,
                                  ),
                                  // SizedBox(
                                  //   height:
                                  //       MediaQuery.of(context).size.height *
                                  //           0.035,
                                  // ),
                                ],
                              ),

                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035,
                                  ),
                                  LeaveRequestTextWidget(
                                    title: 'No of Days :',
                                    value: '${details.days}',
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035,
                                  ),
                                  LeaveRequestTextWidget(
                                    title: 'Leave Type :',
                                    value: '${details.type}',
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.045,
                                  ),
                                  LeaveRequestCCList(),
                                ],
                              ),
                            ],
                          ),
                        ],
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
                                width:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                              SizedBox(
                                width: 350,
                                child: ValidDatesGrid(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      LeaveRequestTextWidget(
                        title: "Attachments :  ",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      LeaveRequestTextWidget(
                        title: "Reason :  ",
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.0375,
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      thickness: 2,
                      color: Color(0x8071839B),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          WithdrawButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LeaveRequestWithdrawDialog(
                                    title: 'Withdraw Confirmation',
                                    content:
                                        'Are you sure want to withdraw this ?',
                                    onTap: () {
                                      // WithdrawRegularization()
                                      //     .withdrawRegularization(
                                      //         requestId: details?.userId,
                                      //         context: context,
                                      //         ref: ref);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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

class WithdrawButton extends StatelessWidget {
  const WithdrawButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          gradient: const LinearGradient(colors: [
            Color(0xffCE3636),
            Colors.red,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: TextButton(
        onPressed: onTap,
        child: const text15Normal(
          text: 'Withdraw',
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
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
