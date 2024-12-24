import 'dart:developer';

import 'package:diente_admin/core/text.dart';
import 'package:diente_admin/data/models/problem.dart';
import 'package:diente_admin/data/models/request.dart';
import 'package:diente_admin/data/models/student.dart';
import 'package:diente_admin/data/services/dashboard.dart';
import 'package:diente_admin/data/services/problems.dart';
import 'package:diente_admin/data/services/requests.dart';
import 'package:diente_admin/data/services/students.dart';
import 'package:diente_admin/presentation/screens/cases.dart';
import 'package:diente_admin/presentation/screens/dashboard.dart';
import 'package:diente_admin/presentation/screens/problems.dart';
import 'package:diente_admin/presentation/widgets/case.dart';
import 'package:diente_admin/presentation/widgets/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  Widget a = const DashboardScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Row(
        children: [
          Container(
            width: 250,
            color: const Color(0xFF1B2A57),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Diente Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const Gap(50),
                  GestureDetector(
                    onTap: () {
                      log('Dashboard clicked');
                      a = const DashboardScreen();
                      setState(() {});
                    },
                    child: const SidebarItem(
                        icon: Icons.dashboard, title: 'Dashboard'),
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      a = const CasesScreen();
                      setState(() {});
                    },
                    child: const SidebarItem(
                        icon: Icons.medical_services_outlined, title: 'Cases'),
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      a = const ProblemsScreen();
                      setState(() {});
                    },
                    child: const SidebarItem(
                        icon: Icons.report_problem_sharp, title: 'Problems'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: a,
          ),
        ],
      )),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const SidebarItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
