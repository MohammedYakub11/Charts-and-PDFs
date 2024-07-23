import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/model/common.dart';
import '../../common/utils/image_res.dart';
import '../../constants/colors.dart';

class PaginatedWidgets {
  static DataColumn dataColumnWithFilter({
    required VoidCallback onTap,
    required String columnName,
    required String iconOfColumn,
  }) {
    return DataColumn(
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 5,
          ),
          text15Normal(
            text: columnName,
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: onTap,
            child: SvgPicture.asset(
              iconOfColumn,
              height: 20,
              width: 15,
            ),
          ),
        ],
      ),
    );
  }

  static DataColumn dataColumn(
      {required String columnName,
      required String imageName,
      required VoidCallback onTap,
      required double heightOfIcon,
      bool isSorted = false, // New parameter for sorting state
      bool ascending = true,
      Color? iconColor}) {
    return DataColumn(
      label: Row(
        children: [
          text15Normal(
            text: columnName,
          ),
          IconButton(
            onPressed: onTap,
            icon: SvgPicture.asset(
              imageName,
              height: heightOfIcon,
              color: iconColor,
            ),
          )
        ],
      ),
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

class text13Normal extends StatelessWidget {
  const text13Normal(
      {Key? key,
      this.text = '',
      this.color = Colors.white,
      this.fontWeight = FontWeight.w500,
      this.maxLines})
      : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: color, fontWeight: fontWeight, fontSize: 13),
    );
  }
}
