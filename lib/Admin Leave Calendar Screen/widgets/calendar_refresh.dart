import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';

class Refresh_CalendarButton extends ConsumerWidget {
  const Refresh_CalendarButton({
    super.key,
    required this.onTap
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed:onTap,

            icon: const Icon(Icons.refresh,color: AppColors.mainTheme,)
        ),
      ],
    );
  }
}
