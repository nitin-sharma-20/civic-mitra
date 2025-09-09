import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/report.dart';
import '../../domain/usecases/create_report.dart';
import '../../domain/usecases/get_my_report.dart';

// Events
abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

class ReportLoadRequested extends ReportEvent {}

class ReportCreateRequested extends ReportEvent {
  final CreateReportParams params;

  const ReportCreateRequested(this.params);

  @override
  List<Object> get props => [params];
}

class ReportRefreshRequested extends ReportEvent {}

// States
abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportCreateLoading extends ReportState {
  final List<Report> currentReports;

  const ReportCreateLoading(this.currentReports);

  @override
  List<Object> get props => [currentReports];
}

class ReportLoaded extends ReportState {
  final List<Report> reports;

  const ReportLoaded(this.reports);

  @override
  List<Object> get props => [reports];
}

class ReportCreateSuccess extends ReportState {
  final List<Report> reports;
  final Report newReport;

  const ReportCreateSuccess(this.reports, this.newReport);

  @override
  List<Object> get props => [reports, newReport];
}

class ReportError extends ReportState {
  final String message;

  const ReportError(this.message);

  @override
  List<Object> get props => [message];
}

class ReportCreateError extends ReportState {
  final String message;
  final List<Report> currentReports;

  const ReportCreateError(this.message, this.currentReports);

  @override
  List<Object> get props => [message, currentReports];
}

// BLoC
class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final GetMyReports getMyReports;
  final CreateReport createReport;

  ReportBloc({
    required this.getMyReports,
    required this.createReport,
  }) : super(ReportInitial()) {
    on<ReportLoadRequested>(_onReportLoadRequested);
    on<ReportCreateRequested>(_onReportCreateRequested);
    on<ReportRefreshRequested>(_onReportRefreshRequested);
  }

  Future<void> _onReportLoadRequested(
    ReportLoadRequested event,
    Emitter<ReportState> emit,
  ) async {
    emit(ReportLoading());

    final result = await getMyReports();
    result.fold(
      (failure) => emit(ReportError(failure.message)),
      (reports) => emit(ReportLoaded(reports)),
    );
  }

  Future<void> _onReportCreateRequested(
    ReportCreateRequested event,
    Emitter<ReportState> emit,
  ) async {
    final currentReports = state is ReportLoaded
        ? (state as ReportLoaded).reports
        : <Report>[];

    emit(ReportCreateLoading(currentReports));

    final result = await createReport(event.params);
    result.fold(
      (failure) => emit(ReportCreateError(failure.message, currentReports)),
      (newReport) {
        final updatedReports = [newReport, ...currentReports];
        emit(ReportCreateSuccess(updatedReports, newReport));
      },
    );
  }

  Future<void> _onReportRefreshRequested(
    ReportRefreshRequested event,
    Emitter<ReportState> emit,
  ) async {
    final result = await getMyReports();
    result.fold(
      (failure) => emit(ReportError(failure.message)),
      (reports) => emit(ReportLoaded(reports)),
    );
  }
}