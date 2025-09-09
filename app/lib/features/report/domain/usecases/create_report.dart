import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entity/report.dart';
import '../repositories/report_repository.dart';

class CreateReport {
  final ReportRepository repository;

  CreateReport(this.repository);

  Future<Either<Failure, Report>> call(CreateReportParams params) async {
    return await repository.createReport(params);
  }
}