import 'package:flutter/material.dart';

BoxDecoration containerDecoration({Color color=Colors.white,double radius=5,double sR=3,double bR=4,Color borderColor=const Color(0xffD5D6D9),double borderWidth=1.0}){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color:color,
    border: Border.all(color: borderColor,width:borderWidth),
    boxShadow:  [
      BoxShadow(
          color: const Color(0xffD5D6D9),
          blurRadius: bR,
          offset: const Offset(0, 1),
          spreadRadius: sR),
    ],
  );
}