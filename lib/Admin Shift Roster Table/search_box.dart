import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_testings/Admin%20Shift%20Roster%20Table/textField_decorations.dart';

import '../constants/colors.dart';

class SearchBoxForRoster extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final double width;
  final String hintText;

  const SearchBoxForRoster(
      {super.key,
      required this.controller,
      required this.onSearch,
      this.width = 220,
      this.hintText = " Name or ID"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: width,
        height: 35,
        child: TextField(
          cursorColor: AppColors.defaultTextFieldColor,
          controller: controller,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              enabledBorder:
                  decorationTextField(color: AppColors.defaultTextFieldColor),
              errorBorder:
                  decorationTextField(color: AppColors.defaultTextFieldColor),
              focusedErrorBorder:
                  decorationTextField(color: AppColors.defaultTextFieldColor),
              suffixIcon:  Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  'icons/search_icon.svg', // Adjust the path to your refresh icon
                ),
              ),
              prefixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        onSearch('');
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                splashRadius: 0.1,
              )
                  : null,
              hintText: hintText,
              hintStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              fillColor: Colors.white,
              focusColor: Colors.white,
              border: decorationTextField(color: AppColors.defaultTextFieldColor),
              focusedBorder:
                  decorationTextField(color: AppColors.defaultTextFieldColor),
              alignLabelWithHint: true),
          onChanged: onSearch,
        ),
      ),
    );
  }
}
