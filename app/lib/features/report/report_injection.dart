import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/datasources/report_remote_data_source.dart';
import 'data/repositories/report_repository_impl.dart';
import 'domain/repositories/report_repository.dart';
import 'domain/usecases/create_report.dart';
import 'domain/usecases/get_my_report.dart';
import 'presentation/bloc/report_bloc.dart';

final sl = GetIt.instance;

void initReportInjection() {
  sl.registerLazySingleton<ReportRemoteDataSource>(
    () => ReportRemoteDataSourceImpl(
      supabaseClient: Supabase.instance.client,
    ),
  );


  sl.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => CreateReport(sl()));
  sl.registerLazySingleton(() => GetMyReports(sl()));

  sl.registerFactory(
    () => ReportBloc(
      getMyReports: sl(),
      createReport: sl(),
    ),
  );
}