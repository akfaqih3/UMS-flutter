class SubjectModel {
  final String slug;
  final String title;
  final String? photo;
  final int? coursestotal;

  SubjectModel({
    required this.slug,
    required this.title,
    this.photo,
    this.coursestotal,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      slug: json['slug'],
      title: json['title'],
      photo: json['photo'],
      coursestotal: json['total_courses'],
    );
  }
}
