import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;
  final double latitude;
  final double longitude;
  final String? imageUrl;
  final String userId;
  final DateTime createdAt;
  final ReportStatus status;

  const Report({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    required this.userId,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        latitude,
        longitude,
        imageUrl,
        userId,
        createdAt,
        status,
      ];
}

enum ReportStatus {
  pending,
  inProgress,
  resolved,
  rejected,
}

extension ReportStatusExtension on ReportStatus {
  String get displayName {
    switch (this) {
      case ReportStatus.pending:
        return 'Pending';
      case ReportStatus.inProgress:
        return 'In Progress';
      case ReportStatus.resolved:
        return 'Resolved';
      case ReportStatus.rejected:
        return 'Rejected';
    }
  }
}

class CreateReportParams extends Equatable {
  final String title;
  final String description;
  final String category;
  final double latitude;
  final double longitude;
  final String? imagePath;

  const CreateReportParams({
    required this.title,
    required this.description,
    required this.category,
    required this.latitude,
    required this.longitude,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        category,
        latitude,
        longitude,
        imagePath,
      ];
}