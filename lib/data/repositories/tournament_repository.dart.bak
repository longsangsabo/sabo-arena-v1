import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/api_service.dart';

/// Tournament Repository
class TournamentRepository {
  final ApiService _apiService;

  TournamentRepository(this._apiService);

  /// Get tournaments list
  Future<ApiResponse<List<Tournament>>> getTournaments({
    int page = 1,
    int limit = 20,
    String? search,
    TournamentStatus? status,
    TournamentType? type,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      if (search != null) 'search': search,
      if (status != null) 'status': status.value,
      if (type != null) 'type': type.value,
    };

    final response = await _apiService.get<List<Tournament>>(
      ApiEndpoints.tournaments,
      queryParameters: queryParams,
      fromJson: (data) => (data as List<dynamic>)
          .map((json) => Tournament.fromJson(json as Map<String, dynamic>))
          .toList(),
    );

    return response;
  }

  /// Get tournament detail
  Future<ApiResponse<Tournament>> getTournamentDetail(String id) async {
    return await _apiService.get<Tournament>(
      ApiEndpoints.tournamentDetail(id),
      fromJson: (data) => Tournament.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Create tournament
  Future<ApiResponse<Tournament>> createTournament(Map<String, dynamic> data) async {
    return await _apiService.post<Tournament>(
      ApiEndpoints.createTournament,
      data: data,
      fromJson: (data) => Tournament.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Join tournament
  Future<ApiResponse<bool>> joinTournament(String tournamentId) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      ApiEndpoints.joinTournament(tournamentId),
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return ApiResponse<bool>(
      success: response.success,
      message: response.message,
      data: response.success,
      statusCode: response.statusCode,
      errors: response.errors,
    );
  }

  /// Leave tournament
  Future<ApiResponse<bool>> leaveTournament(String tournamentId) async {
    final response = await _apiService.delete<Map<String, dynamic>>(
      ApiEndpoints.leaveTournament(tournamentId),
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return ApiResponse<bool>(
      success: response.success,
      message: response.message,
      data: response.success,
      statusCode: response.statusCode,
      errors: response.errors,
    );
  }

  /// Search tournaments
  Future<ApiResponse<List<Tournament>>> searchTournaments(String query) async {
    return await _apiService.get<List<Tournament>>(
      ApiEndpoints.searchTournaments,
      queryParameters: {'q': query},
      fromJson: (data) => (data as List<dynamic>)
          .map((json) => Tournament.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Tournament Repository Provider
final tournamentRepositoryProvider = Provider<TournamentRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return TournamentRepository(apiService);
});
