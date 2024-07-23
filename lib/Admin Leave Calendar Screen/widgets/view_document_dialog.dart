import 'package:flutter/material.dart';

class ViewDocumentDialog extends StatelessWidget {
  const ViewDocumentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),),

        width: 700,
        height: 730,

      ),
    );
  }
}


