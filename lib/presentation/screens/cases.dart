import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:diente_admin/data/models/request.dart';
import 'package:diente_admin/data/services/requests.dart';
import 'package:diente_admin/presentation/widgets/case.dart';
import 'package:diente_admin/core/text.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              customText(
                context,
                'Here are new cases',
                const Color(0xFF1B2A57),
                40.sp,
                FontWeight.w500,
              ),
              SizedBox(
                width: 433.w,
                height: 1000.h,
                child: StreamBuilder<List<RequestModel>>(
                  stream: getRequestsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('There are no requests'),
                      );
                    } else {
                      List<RequestModel> requests = snapshot.data!;
                      return ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          return CaseWidget(
                            request: requests[index],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
