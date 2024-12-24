import 'package:diente_admin/data/models/problem.dart';
import 'package:diente_admin/data/services/problems.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProblemsScreen extends StatelessWidget {
  const ProblemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problems'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<List<ReportProblemModel>>(
          stream: ReportProblemService().fetchProblems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No problems found.'));
            } else {
              List<ReportProblemModel> problems = snapshot.data!;
              return ListView.builder(
                itemCount: problems.length,
                itemBuilder: (context, index) {
                  ReportProblemModel problem = problems[index];
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          problem.userEmail,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(problem.description),
                        const SizedBox(height: 8.0),
                        Text(DateFormat('yyyy/MM/dd – kk:mm')
                            .format(problem.timestamp)),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
