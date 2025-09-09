import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> loginWithOtp(String phoneNumber);
  Future<Either<Failure, User>> verifyOtp(String phoneNumber, String otp);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
  Stream<User?> get authStateChanges;
}