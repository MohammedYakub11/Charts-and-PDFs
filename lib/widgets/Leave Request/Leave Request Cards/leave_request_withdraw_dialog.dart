import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../constants/text.dart';

class LeaveRequestWithdrawDialog extends ConsumerWidget {
  const LeaveRequestWithdrawDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onTap});

  final String title;
  final String content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.33,
        height: 180,
        child: Column(
          children: [
            Container(
              color: AppColors.mainTheme,
              child: Row(
                children: [
                  const SizedBox(
                    width: 160,
                  ),
                  text17Normal(
                    text: title,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.cancel_rounded,
                            color: Colors.white,
                            size: 24,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: text17Normal(
                      text: content,
                      color: AppColors.mainTheme,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(
              thickness: 2,
              color: Color(0x4071839B),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CancelButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                OKButton(
                  onTap: onTap,
                ),
                const Divider(
                  indent: 10,
                  thickness: 20,
                  color: Colors.transparent,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 760;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (isDesktop(context)) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (isTablet(context)) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 130,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          primary: const Color(0xFFCE3636), // Text (foreground) color
          backgroundColor: Theme.of(context)
              .scaffoldBackgroundColor, // Scaffold background color
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFCE3636), width: 2),
            // Border color
            borderRadius: BorderRadius.circular(5.0), // Border radius
          ),
        ),
        child: const text15Normal(
          text: 'Cancel',
          color: Colors.red,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class OKButton extends StatelessWidget {
  OKButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  // final bool isAdding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainTheme,
        // White text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0), // Border radius of 5
        ),
        minimumSize: const Size(125, 42), // Width and height
      ),
      child: const text15Normal(
        text: 'OK',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
