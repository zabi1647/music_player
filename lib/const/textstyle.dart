import 'package:flutter/material.dart';
import 'package:music_player/const/colors.dart';

const regular = "Reqular";
const bold = "Bold";
ourStyle(
    {String? family = regular, double? size = 14, Color? color = whitecolor}) {
  return TextStyle(
    fontFamily: family,
    fontWeight: FontWeight.w500,
    fontSize: size,
    color: color,
  );
}
