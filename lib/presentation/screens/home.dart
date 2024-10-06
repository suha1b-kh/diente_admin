// ignore_for_file: sized_box_for_whitespace

import 'package:diente_admin/core/text.dart';
import 'package:diente_admin/data/models/student.dart';
import 'package:diente_admin/presentation/widgets/case.dart';
import 'package:diente_admin/presentation/widgets/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});
  StudentModel student = StudentModel(
      name: 'diente student',
      email: 'diente.student@gmail.com',
      id: '1',
      imageUrl:
          'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
      year: '3');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(50.w),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                children: [
                  customText(
                      context,
                      'Here are new cases',
                      Theme.of(context).colorScheme.primary,
                      40.sp,
                      FontWeight.w500),
                  Expanded(
                    child: Container(
                      width: 433.w,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return CaseWidget(context, 'Routine examination');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                customText(
                    context,
                    'Here are diente students',
                    Theme.of(context).colorScheme.primary,
                    40.sp,
                    FontWeight.w500),
                Expanded(
                  child: Container(
                    width: 433.w,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return StudentWidget(
                          context,
                          student,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
