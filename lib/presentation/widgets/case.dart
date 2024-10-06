import 'dart:developer';

import 'package:diente_admin/core/text.dart';
import 'package:diente_admin/data/models/request.dart';
import 'package:diente_admin/data/models/student.dart';
import 'package:diente_admin/data/services/requests.dart';
import 'package:diente_admin/data/services/students.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget CaseWidget(context, String requestName) {
  return Padding(
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
            padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 21.w),
            child: customText(context, 'request.caseDescription',
                Theme.of(context).colorScheme.primary, 24.sp, FontWeight.w500),
          ),
          Gap(10.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  //TODO: accept request
                },
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80.w,
                ),
              ),
              Gap(10.w),
              IconButton(
                onPressed: () async {
                  //TODO: reject request
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 80.w,
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
