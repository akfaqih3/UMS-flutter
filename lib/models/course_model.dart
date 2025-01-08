class CourseModel {
  final int id;
  final String title;
  final String subject;
  final String overview;
  final String? photo;
  final String createdAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.overview,
    this.photo,
    required this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        id: json['id'],
        title: json['title'],
        subject: json['subject'],
        overview: json['overview'],
        photo: json['photo'] ?? '',
        createdAt: json['created']);
  }
}
