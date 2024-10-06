import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    required this.text,
    this.icon,  String? Function(String? value) ?validator,  TextInputType? keyboardType,  bool? hide,  Null Function()? iconPressed,
  });

  final double width, height;
  final TextEditingController controller;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Center(
        child: TextFormField(
          cursorColor: Theme.of(context).colorScheme.inversePrimary,
          controller: controller,
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 14.sp),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.inverseSurface,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            labelText: text,
            labelStyle: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: icon != null
                ? Icon(
                    icon,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 24.sp,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
