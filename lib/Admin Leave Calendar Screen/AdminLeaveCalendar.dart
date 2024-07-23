import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_testings/Admin%20Leave%20Calendar%20Screen/widgets/admin_leave_employee_history.dart';
import 'package:flutter_testings/Admin%20Leave%20Calendar%20Screen/widgets/admin_leave_profile_details.dart';

import 'package:flutter_testings/common/text_widgets.dart';

import '../Pages/leave_request.dart';
import '../common/model/user.dart';
import '../common/provider/leave_request/leave_request.dart';
import '../common/provider/manager/provider.dart';
import '../common/utils/image_res.dart';
import '../constants/colors.dart';
import '../constants/text.dart';
import '../widgets/Leave Request/Leave Request Cards/leave_request_history_card.dart';

final selectedUserIdProvider = StateProvider<int?>((ref) => null);

class AdminLeaveCalendar extends ConsumerStatefulWidget {

  const AdminLeaveCalendar({super.key,});

  @override
  ConsumerState<AdminLeaveCalendar> createState() => _AdminLeaveCalendarState();
}

class _AdminLeaveCalendarState extends ConsumerState<AdminLeaveCalendar> {
  final changeEntriesProvider=StateProvider.autoDispose<String>((ref) => 'See Previous Entries');

  @override
  Widget build(
    BuildContext context,
  ) {


    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          // height: MediaQuery.of(context).size.height * 0.7,

          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(
                              ImageRes.arrow_back,
                              // 'assets/icons/arrow_back.svg',
                            ),
                            iconSize: 36,
                            onPressed: () {
                              // Change as per the requirement
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LeaveRequestPage()),
                              );
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          CircleAvatar(
                            child: SvgPicture.asset(
                              ImageRes.random_profile,
                              height: 40,
                              width: 40,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text23Normal(
                                text: 'Faizal Salahudeen',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              text15Inter(
                                text: '#103',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              text14Normal(
                                text: 'Tech & Engineering',
                                color: AppColors.mainTheme,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            const Icon(
                              Icons.file_upload_outlined,
                              size: 18,
                              color: AppColors.mainTheme,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Export',
                              style: TextStyle(
                                  color: AppColors.mainTheme,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6989,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Container(
                  decoration: dashboardDecoration(),

                  child: Row(
                    children: [
                      //Leave Card
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Color(0x8071839B),
                              width: 2,
                            ),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.3485,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 14.0, top: 14, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  text15Inter(
                                    text: 'Applied On:',
                                    color: AppColors.mainTheme,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  text15Inter(
                                    text: "31 May, 2024",
                                    // API to be integrated
                                    // DateTimeUtils.formatDate(details!.appliedOn),
                                    color: AppColors.mainTheme,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: const Divider(
                                thickness: 2,
                                color: Color(0x8071839B),
                                indent: 0.0,
                                endIndent: 0.0,
                              ),
                            ),
                            Row(
                              children: [
                                AdminLeaveEmployeeProfile(),
                              ],
                            )
                          ],
                        ),
                      ),
                      //

                      //History's card
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3485,

                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 14.0, top: 16, bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'History\'s',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            const Divider(
                              thickness: 2,
                              color: Color(0x8071839B),
                            ),
                            Expanded(
                              child: AdminLeaveEmployeeHistory(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //
  // void historyTap(UserLeaveApplyDetails leaveRequest) {
  //   widget.onTileSelected(leaveRequest.toMap());
  //
  //   ref.invalidate(
  //       changeEntriesProvider); //while clicking table everytime we ll invalidate this pprovider to show current entries by Default
  //   ref
  //       .read(LeaveRequestDetailsHistoryProvider.notifier)
  //       .getYearlyLeaveDetailsHistory(
  //     requestId: leaveRequest.id,
  //
  //   );
  // }
}

class text23Normal extends StatelessWidget {
  const text23Normal(
      {Key? key,
      this.text = '',
      this.color = Colors.white,
      this.fontWeight = FontWeight.w500})
      : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: color, fontWeight: fontWeight, fontSize: 23),
    );
  }
}

class text14Normal extends StatelessWidget {
  const text14Normal(
      {Key? key,
      this.text = '',
      this.color = Colors.white,
      this.fontWeight = FontWeight.w500,
      this.textAlign,
      this.maxLines})
      : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: color, fontWeight: fontWeight, fontSize: 14),
    );
  }
}
