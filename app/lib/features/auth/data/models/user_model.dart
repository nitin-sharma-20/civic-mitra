import '../../domain/entity/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.phoneNumber,
    super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      phoneNumber: json['phone'] as String,
      createdAt: json['created_at'] != null 
        ? DateTime.parse(json['created_at'] as String)
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phoneNumber,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory UserModel.fromSupabaseUser(dynamic user) {
    return UserModel(
      id: user.id,
      phoneNumber: user.phone ?? '',
      createdAt: DateTime.parse(user.createdAt),
    );
  }
}