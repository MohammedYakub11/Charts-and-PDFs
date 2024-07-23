import 'package:flutter/material.dart';

class greyDivider extends StatelessWidget {
  const greyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Color(0xff71839B).withOpacity(0.4),
      height: 2,
    );
  }
}
