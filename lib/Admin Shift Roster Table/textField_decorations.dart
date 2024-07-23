import 'package:flutter/material.dart';

OutlineInputBorder decorationTextField({required Color color,double borderWidth=1}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(
        5.0), // You can adjust the border radius as needed
    borderSide:  BorderSide(
        width: borderWidth, color:color ), // Specify the border color
  );
}
OutlineInputBorder decorationTextFieldWithNoRadius({required Color color}) {
  return OutlineInputBorder(
    borderSide:  BorderSide(
        width: 1, color:color ), // Specify the border color
  );
}