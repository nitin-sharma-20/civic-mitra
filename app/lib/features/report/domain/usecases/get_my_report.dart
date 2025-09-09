import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entity/report.dart';
import '../repositories/report_repository.dart';

class GetMyReports {
  final ReportRepository repository;

  GetMyReports(this.repository);

  Future<Either<Failure, List<Report>>> call() async {
    return await repository.getMyReports();
  }
}