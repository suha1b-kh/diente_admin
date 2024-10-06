import 'package:diente_admin/core/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(context, Color color, VoidCallback onPressed, String text,
    double textSize) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
        width: 342.w,
        height: 53.h,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Center(
          child: customText(
              context,
              text,
              Theme.of(context).colorScheme.inverseSurface,
              textSize,
              FontWeight.w500),
        )),
  );
}

Widget customButtonWithBorder(
    context, Color color, VoidCallback onPressed, Text text) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
        width: 342.w,
        height: 53.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: color,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Center(
          child: text,
        )),
  );
}

Widget customDialogButton(context, Color color, VoidCallback onPressed,
    String text, double textSize) {
  return TextButton(
    onPressed: onPressed,
    child: Container(
        width: 263.w,
        height: 55.h,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        child: Center(
          child: customText(
              context,
              text,
              Theme.of(context).colorScheme.inverseSurface,
              textSize,
              FontWeight.w500),
        )),
  );
}
