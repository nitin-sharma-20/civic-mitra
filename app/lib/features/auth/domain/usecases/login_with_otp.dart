import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class LoginWithOtp {
  final AuthRepository repository;

  LoginWithOtp(this.repository);

  Future<Either<Failure, void>> call(String phoneNumber) async {
    return await repository.loginWithOtp(phoneNumber);
  }
}