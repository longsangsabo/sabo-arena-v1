import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/api_service.dart';

/// User Repository
class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  /// Get user profile
  Future<ApiResponse<User>> getProfile() async {
    return await _apiService.get<User>(
      ApiEndpoints.profile,
      fromJson: (data) => User.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Update user profile
  Future<ApiResponse<User>> updateProfile(Map<String, dynamic> data) async {
    return await _apiService.put<User>(
      ApiEndpoints.updateProfile,
      data: data,
      fromJson: (data) => User.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Upload avatar
  Future<ApiResponse<String>> uploadAvatar(File file) async {
    return await _apiService.uploadFile<String>(
      ApiEndpoints.uploadAvatar,
      file,
      fieldName: 'avatar',
      fromJson: (data) => (data as Map<String, dynamic>)['avatar_url'] as String,
    );
  }

  /// Search users
  Future<ApiResponse<List<User>>> searchUsers(String query) async {
    return await _apiService.get<List<User>>(
      ApiEndpoints.searchUsers,
      queryParameters: {'q': query},
      fromJson: (data) => (data as List<dynamic>)
          .map((json) => User.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get user by ID
  Future<ApiResponse<User>> getUserById(String userId) async {
    return await _apiService.get<User>(
      '/users/$userId',
      fromJson: (data) => User.fromJson(data as Map<String, dynamic>),
    );
  }
}

/// User Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserRepository(apiService);
});
