import 'dart:developer';

import 'package:diente_admin/core/text.dart';
import 'package:diente_admin/data/models/student.dart';
import 'package:diente_admin/data/services/students.dart';
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
          color: const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.w),
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: const Color(0xFF1B2A57),
                child: Text(
                  student.name.split(' ').map((e) => e[0].toUpperCase()).join(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Gap(10.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText(context, student.name, const Color(0xFF1B2A57),
                    24.sp, FontWeight.w500),
                Gap(20.w),
                customText(context, student.year, const Color(0xFF1B2A57),
                    20.sp, FontWeight.w400),
              ],
            ),
            customText(context, student.email, const Color(0xFF7CA0CA), 18.sp,
                FontWeight.w400),
          ],
        ),
      ),
    ),
  );
}
