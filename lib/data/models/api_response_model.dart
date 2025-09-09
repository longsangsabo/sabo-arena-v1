import 'package:equatable/equatable.dart';

/// Generic API Response wrapper
class ApiResponse<T> extends Equatable {
  final bool success;
  final String message;
  final T? data;
  final int? statusCode;
  final List<String>? errors;
  final PaginationMeta? pagination;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.statusCode,
    this.errors,
    this.pagination,
  });

  /// Success response factory
  factory ApiResponse.success({
    required T data,
    String message = 'Success',
    int statusCode = 200,
    PaginationMeta? pagination,
  }) {
    return ApiResponse<T>(
      success: true,
      message: message,
      data: data,
      statusCode: statusCode,
      pagination: pagination,
    );
  }

  /// Error response factory
  factory ApiResponse.error({
    required String message,
    int statusCode = 400,
    List<String>? errors,
  }) {
    return ApiResponse<T>(
      success: false,
      message: message,
      statusCode: statusCode,
      errors: errors,
    );
  }

  /// From JSON factory
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null && fromJsonT != null 
          ? fromJsonT(json['data']) 
          : null,
      statusCode: json['status_code'] as int?,
      errors: (json['errors'] as List<dynamic>?)?.cast<String>(),
      pagination: json['pagination'] != null
          ? PaginationMeta.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson([Map<String, dynamic> Function(T)? toJsonT]) {
    return {
      'success': success,
      'message': message,
      'data': data != null && toJsonT != null ? toJsonT(data as T) : data,
      'status_code': statusCode,
      'errors': errors,
      'pagination': pagination?.toJson(),
    };
  }

  @override
  List<Object?> get props => [success, message, data, statusCode, errors, pagination];
}

/// Pagination metadata
class PaginationMeta extends Equatable {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNext;
  final bool hasPrevious;

  const PaginationMeta({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNext,
    required this.hasPrevious,
  });

  /// From JSON factory
  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] as int,
      totalPages: json['total_pages'] as int,
      totalItems: json['total_items'] as int,
      itemsPerPage: json['items_per_page'] as int,
      hasNext: json['has_next'] as bool,
      hasPrevious: json['has_previous'] as bool,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_items': totalItems,
      'items_per_page': itemsPerPage,
      'has_next': hasNext,
      'has_previous': hasPrevious,
    };
  }

  @override
  List<Object?> get props => [
        currentPage,
        totalPages,
        totalItems,
        itemsPerPage,
        hasNext,
        hasPrevious,
      ];
}

/// Authentication Response Model
class AuthResponse extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn; // seconds
  final String userId;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType = 'Bearer',
    required this.expiresIn,
    required this.userId,
  });

  /// From JSON factory
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String? ?? 'Bearer',
      expiresIn: json['expires_in'] as int,
      userId: json['user_id'] as String,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user_id': userId,
    };
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, tokenType, expiresIn, userId];
}

/// Login Request Model
class LoginRequest extends Equatable {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRequest({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'remember_me': rememberMe,
    };
  }

  @override
  List<Object?> get props => [email, password, rememberMe];
}

/// Register Request Model
class RegisterRequest extends Equatable {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String? firstName;
  final String? lastName;
  final String? phone;

  const RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.firstName,
    this.lastName,
    this.phone,
  });

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        confirmPassword,
        firstName,
        lastName,
        phone,
      ];
}
