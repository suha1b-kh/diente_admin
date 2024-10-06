import 'package:diente_admin/core/text.dart';
import 'package:diente_admin/data/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget StudentWidget(context, StudentModel student) {
  return GestureDetector(
    onTap: () {
      //TODO: navigate to student profile
    },
    child: Padding(
      padding: EdgeInsets.all(20.w),
      child: Container(
        height: 200.w,
        width: 433.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.w),
              child: CircleAvatar(
                radius: 50.r,
                backgroundImage: NetworkImage(student.imageUrl
                    // 'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png'),
                    ),
              ),
            ),
            Gap(10.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText(
                    context,
                    student.name,
                    Theme.of(context).colorScheme.primary,
                    24.sp,
                    FontWeight.w500),
                Gap(20.w),
                customText(
                    context,
                    student.year,
                    Theme.of(context).colorScheme.primary,
                    20.sp,
                    FontWeight.w400),
              ],
            ),
            customText(
                context,
                student.email,
                Theme.of(context).colorScheme.secondary,
                18.sp,
                FontWeight.w400),
          ],
        ),
      ),
    ),
  );
}
