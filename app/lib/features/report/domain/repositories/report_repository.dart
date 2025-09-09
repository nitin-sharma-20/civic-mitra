import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entity/report.dart';

abstract class ReportRepository {
  Future<Either<Failure, Report>> createReport(CreateReportParams params);
  Future<Either<Failure, List<Report>>> getMyReports();
  Future<Either<Failure, Report>> getReportById(String reportId);
}