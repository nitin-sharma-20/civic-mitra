import '../../domain/entity/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.latitude,
    required super.longitude,
    super.imageUrl,
    required super.userId,
    required super.createdAt,
    required super.status,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: ReportStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ReportStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
      'image_url': imageUrl,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'status': status.name,
    };
  }

  factory ReportModel.fromCreateParams({
    required CreateReportParams params,
    required String id,
    required String userId,
    String? imageUrl,
  }) {
    return ReportModel(
      id: id,
      title: params.title,
      description: params.description,
      category: params.category,
      latitude: params.latitude,
      longitude: params.longitude,
      imageUrl: imageUrl,
      userId: userId,
      createdAt: DateTime.now(),
      status: ReportStatus.pending,
    );
  }
}