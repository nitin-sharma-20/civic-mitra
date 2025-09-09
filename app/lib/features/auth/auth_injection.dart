import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_with_otp.dart';
import 'domain/usecases/verify_otp.dart';
import 'presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void initAuthInjection() {
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: Supabase.instance.client,
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginWithOtp(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));

  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      loginWithOtp: sl(),
      verifyOtp: sl(),
      authRepository: sl(),
    ),
  );
}