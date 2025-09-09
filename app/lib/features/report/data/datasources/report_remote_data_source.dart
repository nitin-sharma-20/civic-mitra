import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/report.dart';
import '../models/report_model.dart';

abstract class ReportRemoteDataSource {
  Future<ReportModel> createReport(CreateReportParams params);
  Future<List<ReportModel>> getMyReports();
  Future<ReportModel> getReportById(String reportId);
}

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  final SupabaseClient supabaseClient;
  final Uuid uuid = const Uuid();

  ReportRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<ReportModel> createReport(CreateReportParams params) async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final reportId = uuid.v4();
      String? imageUrl;

      // Upload image if provided
      if (params.imagePath != null) {
        final file = File(params.imagePath!);
        final fileName = '${reportId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        
        await supabaseClient.storage
            .from('reports')
            .upload(fileName, file);

        imageUrl = supabaseClient.storage
            .from('reports')
            .getPublicUrl(fileName);
      }

      // Create report data
      final reportData = {
        'id': reportId,
        'title': params.title,
        'description': params.description,
        'category': params.category,
        'latitude': params.latitude,
        'longitude': params.longitude,
        'image_url': imageUrl,
        'user_id': user.id,
        'created_at': DateTime.now().toIso8601String(),
        'status': ReportStatus.pending.name,
      };

      // Insert into database
      await supabaseClient
          .from('reports')
          .insert(reportData);

      return ReportModel.fromJson(reportData);
    } catch (e) {
      throw Exception('Failed to create report: ${e.toString()}');
    }
  }

  @override
  Future<List<ReportModel>> getMyReports() async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final response = await supabaseClient
          .from('reports')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return response
          .map<ReportModel>((json) => ReportModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch reports: ${e.toString()}');
    }
  }

  @override
  Future<ReportModel> getReportById(String reportId) async {
    try {
      final response = await supabaseClient
          .from('reports')
          .select()
          .eq('id', reportId)
          .single();

      return ReportModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch report: ${e.toString()}');
    }
  }
}