import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String phoneNumber;
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.phoneNumber,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, phoneNumber, createdAt];
}