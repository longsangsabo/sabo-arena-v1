import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../../providers/providers.dart';

/// API Service class để handle HTTP requests
class ApiService {
  late final Dio _dio;
  final String baseUrl;

  ApiService({
    required this.baseUrl,
    String? accessToken,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
      },
    ));

    _setupInterceptors();
  }

  /// Setup Dio interceptors
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Log request
          print('🚀 REQUEST: ${options.method} ${options.path}');
          print('📋 Data: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          // Log response
          print('✅ RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (error, handler) {
          // Log error
          print('❌ ERROR: ${error.response?.statusCode} ${error.requestOptions.path}');
          print('💭 Message: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  /// Update authorization header
  void updateToken(String? token) {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  /// Generic GET request
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: 'Unexpected error: $e');
    }
  }

  /// Generic POST request
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: 'Unexpected error: $e');
    }
  }

  /// Generic PUT request
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: 'Unexpected error: $e');
    }
  }

  /// Generic DELETE request
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.delete(endpoint);

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: 'Unexpected error: $e');
    }
  }

  /// Handle successful response
  ApiResponse<T> _handleResponse<T>(
    Response response,
    T Function(dynamic)? fromJson,
  ) {
    final data = response.data;

    if (data is Map<String, dynamic>) {
      return ApiResponse.fromJson(data, fromJson);
    }

    // Direct data response
    return ApiResponse.success(
      data: fromJson != null ? fromJson(data) : data as T,
      statusCode: response.statusCode ?? 200,
    );
  }

  /// Handle error response
  ApiResponse<T> _handleError<T>(DioException error) {
    String message = 'Network error occurred';
    int statusCode = 0;
    List<String>? errors;

    if (error.response != null) {
      statusCode = error.response!.statusCode ?? 0;
      final data = error.response!.data;

      if (data is Map<String, dynamic>) {
        message = data['message'] as String? ?? 'Server error';
        errors = (data['errors'] as List<dynamic>?)?.cast<String>();
      } else if (data is String) {
        message = data;
      }
    } else {
      // Network error
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          message = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          message = 'Send timeout';
          break;
        case DioExceptionType.receiveTimeout:
          message = 'Receive timeout';
          break;
        case DioExceptionType.connectionError:
          message = 'Network connection error';
          break;
        default:
          message = error.message ?? 'Network error';
      }
    }

    return ApiResponse.error(
      message: message,
      statusCode: statusCode,
      errors: errors,
    );
  }

  /// Upload file
  Future<ApiResponse<T>> uploadFile<T>(
    String endpoint,
    File file, {
    String fieldName = 'file',
    Map<String, dynamic>? additionalData,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(file.path),
        ...?additionalData,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      return _handleError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: 'Upload error: $e');
    }
  }
}

/// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  // Get base URL from environment or config
  const baseUrl = 'https://api.sabo-arena.com/v1'; // Replace với real API URL
  
  // Watch for auth token changes
  final appState = ref.watch(appProvider);
  
  return ApiService(
    baseUrl: baseUrl,
    accessToken: appState.userToken,
  );
});

/// API Endpoints Constants
class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String uploadAvatar = '/user/avatar';

  // Tournament endpoints
  static const String tournaments = '/tournaments';
  static const String createTournament = '/tournaments';
  static String tournamentDetail(String id) => '/tournaments/$id';
  static String joinTournament(String id) => '/tournaments/$id/join';
  static String leaveTournament(String id) => '/tournaments/$id/leave';

  // Search endpoints
  static const String searchTournaments = '/search/tournaments';
  static const String searchUsers = '/search/users';

  // Club endpoints
  static const String clubs = '/clubs';
  static const String createClub = '/clubs';
  static String clubDetail(String id) => '/clubs/$id';
  static String joinClub(String id) => '/clubs/$id/join';
}
