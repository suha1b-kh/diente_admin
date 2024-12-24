import 'dart:developer';

import 'package:diente_admin/core/text.dart';
import 'package:diente_admin/data/models/request.dart';
import 'package:diente_admin/data/services/requests.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CaseWidget extends StatefulWidget {
  const CaseWidget({super.key, required this.request});
  final RequestModel request;

  @override
  State<CaseWidget> createState() => _CaseWidgetState();
}

class _CaseWidgetState extends State<CaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Container(
        height: 300.w,
        width: 433.w,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F7),
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 21.w),
              child: customText(
                  context,
                  widget.request.caseDescription?['Name'] ?? 'no request name',
                  const Color(0xFF1B2A57),
                  24.sp,
                  FontWeight.w500),
            ),
            Gap(10.w),
            customText(
                context,
                widget.request.caseDescription?['toothNumber'] ?? 'no',
                Colors.red,
                16,
                FontWeight.w400),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    //TODO: accept request
                    try {
                      acceptCase(widget.request);
                    } on Exception catch (e) {
                      log(e.toString());
                    }
                    setState(() {});
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
                    try {
                      rejectCase(widget.request);
                      log('rejected');
                    } on Exception catch (e) {
                      log(e.toString());
                    }
                    //TODO: reject request
                    setState(() {});
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
}
