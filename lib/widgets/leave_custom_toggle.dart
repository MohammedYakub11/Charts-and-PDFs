import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define your custom toggle index provider
final customToggleIndexForLeaveApplyProvider = StateProvider.autoDispose<int>((ref) => 0);

class CustomToggleSwitchForLeaveApply extends ConsumerStatefulWidget {
  final List<IconData> icons;
  final Function(int) onToggle;

  const CustomToggleSwitchForLeaveApply({
    Key? key,
    required this.icons,
    required this.onToggle,
  }) : super(key: key);

  @override
  _CustomToggleSwitchForLeaveApplyState createState() => _CustomToggleSwitchForLeaveApplyState();
}

class _CustomToggleSwitchForLeaveApplyState extends ConsumerState<CustomToggleSwitchForLeaveApply> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(customToggleIndexForLeaveApplyProvider);

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
            widget.icons.length,
                (index) => GestureDetector(
              onTap: () {
                ref.read(customToggleIndexForLeaveApplyProvider.notifier).state = index;
                widget.onToggle(index);
              },
              child: Container(
                height: 40,
                width: 40, // Fixed width to accommodate the icon
                decoration: BoxDecoration(
                  color: index == selectedIndex ? Color(0xff36689E) : Colors.white,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0.2,
                  ),
                ),
                child: Icon(
                  widget.icons[index],
                  color: index == selectedIndex ? Colors.white : Color(0xff36689E) ,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

