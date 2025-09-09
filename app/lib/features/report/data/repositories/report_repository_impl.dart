import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entity/report.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasources/report_remote_data_source.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource remoteDataSource;

  ReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Report>> createReport(CreateReportParams params) async {
    try {
      final report = await remoteDataSource.createReport(params);
      return Right(report);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Report>>> getMyReports() async {
    try {
      final reports = await remoteDataSource.getMyReports();
      return Right(reports);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Report>> getReportById(String reportId) async {
    try {
      final report = await remoteDataSource.getReportById(reportId);
      return Right(report);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}