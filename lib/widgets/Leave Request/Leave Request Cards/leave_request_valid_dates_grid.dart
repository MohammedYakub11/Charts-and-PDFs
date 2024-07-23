import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../Admin Leave Calendar Screen/widgets/admin_leave_profile_details.dart';
import '../../../common/provider/leave_request/leave_request.dart';
import '../../../constants/colors.dart';

class ValidDatesGrid extends ConsumerWidget {
  ValidDatesGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(getDetailsOfLeaveRequestEmployeeProvider);

    return SizedBox(
        height: 95,
        width: 480,
        child: details != null
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.0,
                ),
                itemCount: 4,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text15Normal(
                                  text: details.date,
                                  // DateTimeUtils.changeDateFormatForShowingUI(date!.date),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.0065,
                                ),
                                text15Normal(
                                  text: details.session,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  );
                },
              )
            : Center(child: Text('No details available.')));
  }
}
