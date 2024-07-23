import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';


final customToggleIndexForLeaveRequestProvider=StateProvider.autoDispose<int>((ref) => 0);

class CustomToggleSwitchForLeaveRequest extends ConsumerStatefulWidget {
  final List<String> labels;
  final Function(int) onToggle;

  const CustomToggleSwitchForLeaveRequest({
    super.key,
    required this.labels,
    required this.onToggle,
  });

  @override
  ConsumerState<CustomToggleSwitchForLeaveRequest> createState() => _CustomToggleSwitchForLeaveRequestState();
}

class _CustomToggleSwitchForLeaveRequestState extends ConsumerState<CustomToggleSwitchForLeaveRequest> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex=ref.watch(customToggleIndexForLeaveRequestProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
              spreadRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: const Color(0xffD5D6D9),
            width: 1,
          ),
        ),
        child: Row(
          children: List.generate(
            widget.labels.length,
            (index) => GestureDetector(
              onTap: () {
                ref
                    .read(customToggleIndexForLeaveRequestProvider.notifier)
                    .state = index;
                widget.onToggle(index);
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: index == selectedIndex
                      ? AppColors.mainTheme
                      : Colors.white,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0.5,
                  ),
                ),
                child: text14Normal(
                  text: widget.labels[index],
                  textAlign: TextAlign.center,
                  color: index == selectedIndex ?   Colors.white:Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class text14Normal extends StatelessWidget {
  const text14Normal({Key? key,this.text='',this.color=Colors.white,this.fontWeight=FontWeight.w500,this.textAlign,this.maxLines}) : super(key: key);
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
          ?.copyWith(
          color:color,
          fontWeight:fontWeight,
          fontSize: 14),

    );
  }
}