class StudentModel {
  final String id;
  final String name;
  final String year;
  final String email;
  final String imageUrl;

  StudentModel({
    required this.name,
    required this.id,
    required this.year,
    required this.email,
    required this.imageUrl,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'] ?? 'error',
      id: json['id'] ?? 'error',
      year: json['year'] ?? 'error',
      email: json['email'] ?? 'error',
      imageUrl: json['imageUrl'] ?? 'error',
    );
  }
}
