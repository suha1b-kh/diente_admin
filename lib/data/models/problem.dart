class ReportProblemModel {
  String userId;
  String description;
  String userEmail;
  DateTime timestamp;

  ReportProblemModel({
    required this.userId,
    required this.description,
    required this.userEmail,
    required this.timestamp,
  });

  factory ReportProblemModel.fromJson(Map<String, dynamic> json) {
    return ReportProblemModel(
      userId: json['userId'] as String,
      description: json['description'] as String,
      userEmail: json['userEmail'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'description': description,
      'userEmail': userEmail,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
