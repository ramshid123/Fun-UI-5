import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_ui5/core/constants/palette.dart';
import 'package:google_fonts/google_fonts.dart';

Widget kText({
  required String text,
  Color color = ColorConstants.textBlackColor,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.normal,
  int? maxLines,
  String family = 'Ubuntu',
  TextAlign textAlign = TextAlign.start,
  TextDecoration textDecoration = TextDecoration.none,
  TextOverflow textOverflow = TextOverflow.ellipsis,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: textOverflow,
    style: GoogleFonts.getFont(
      family,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      decoration: textDecoration,
    ),
  );
}

Widget kHeight(double height) {
  return SizedBox(height: height);
}

Widget kWidth(double width) {
  return SizedBox(width: width);
}
