import 'package:flutter/material.dart';
import 'package:flutter_testings/common/utils/image_res.dart';

Widget _getIconForFile(String status) {
  switch (status) {
    case '.pdf':
      return Image(
        image: AssetImage(ImageRes.pdf_icon),
        width: 15,
        height: 15,
      );
    case '.png':
      return Image(
        image: AssetImage(ImageRes.png_icon),
        width: 15,
        height: 15,
      );

    default:
      return SizedBox.shrink(); // Returns an empty widget
  }
}
