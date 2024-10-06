// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';

import 'package:diente_admin/core/text.dart';
import 'package:diente_admin/data/models/student.dart';
import 'package:diente_admin/data/services/students.dart';
import 'package:diente_admin/presentation/widgets/case.dart';
import 'package:diente_admin/presentation/widgets/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

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
                    child: FutureBuilder<List<StudentModel>>(
                      future: fetchAllStudents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No students found'));
                        } else {
                          List<StudentModel> students = snapshot.data!;
                          return ListView.builder(
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              return StudentWidget(
                                context,
                                students[index],
                              );
                            },
                          );
                        }
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
