import 'package:equatable/equatable.dart';

/// Generic API response wrapper
class ApiResponse<T> extends Equatable {
  final bool success;
  final String? message;
  final T? data;
  final String? error;
  final int? statusCode;
  final Map<String, dynamic>? metadata;

  const ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.error,
    this.statusCode,
    this.metadata,
  });

  factory ApiResponse.success({
    T? data,
    String? message,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode ?? 200,
      metadata: metadata,
    );
  }

  factory ApiResponse.error({
    required String error,
    int? statusCode,
    Map<String, dynamic>? metadata,
  }) {
    return ApiResponse<T>(
      success: false,
      error: error,
      statusCode: statusCode ?? 400,
      metadata: metadata,
    );
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      data: json['data'] != null && fromJsonT != null 
          ? fromJsonT(json['data'])
          : json['data'] as T?,
      error: json['error'] as String?,
      statusCode: json['status_code'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T)? toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': data != null && toJsonT != null ? toJsonT(data as T) : data,
      'error': error,
      'status_code': statusCode,
      'metadata': metadata,
    };
  }

  @override
  List<Object?> get props => [success, message, data, error, statusCode, metadata];
}

/// Paginated response wrapper
class PaginatedResponse<T> extends Equatable {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const PaginatedResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final itemsJson = json['items'] as List<dynamic>? ?? [];
    final items = itemsJson
        .map((item) => fromJsonT(item as Map<String, dynamic>))
        .toList();

    return PaginatedResponse<T>(
      items: items,
      currentPage: json['current_page'] as int,
      totalPages: json['total_pages'] as int,
      totalItems: json['total_items'] as int,
      itemsPerPage: json['items_per_page'] as int,
      hasNextPage: json['has_next_page'] as bool,
      hasPreviousPage: json['has_previous_page'] as bool,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'items': items.map((item) => toJsonT(item)).toList(),
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_items': totalItems,
      'items_per_page': itemsPerPage,
      'has_next_page': hasNextPage,
      'has_previous_page': hasPreviousPage,
    };
  }

  @override
  List<Object?> get props => [
        items,
        currentPage,
        totalPages,
        totalItems,
        itemsPerPage,
        hasNextPage,
        hasPreviousPage,
      ];
}

/// Authentication response model
class AuthResponse extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final Map<String, dynamic> user;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String? ?? 'Bearer',
      expiresIn: json['expires_in'] as int,
      user: json['user'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user,
    };
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, tokenType, expiresIn, user];
}
