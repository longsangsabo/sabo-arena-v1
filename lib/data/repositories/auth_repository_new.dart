import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User, AuthResponse;
import '../models/models.dart';
import '../services/supabase_service.dart';

/// Authentication Repository using Supabase
class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  /// Sign up with email and password
  Future<ApiResponse<User>> signUp({
    required String email,
    required String password,
    required String username,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
          'first_name': firstName,
          'last_name': lastName,
        },
      );

      if (response.user == null) {
        return ApiResponse.error(
          message: 'Failed to create account. Please try again.',
        );
      }

      // Create user profile in our custom table
      final userProfile = await _createUserProfile(response.user!);
      
      return ApiResponse.success(
        data: userProfile,
        message: 'Account created successfully. Please check your email to verify.',
      );
    } on AuthException catch (e) {
      return ApiResponse.error(
        message: e.message,
        statusCode: 400,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'An unexpected error occurred: $e',
        statusCode: 500,
      );
    }
  }

  /// Sign in with email and password
  Future<ApiResponse<User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return ApiResponse.error(
          message: 'Invalid email or password',
        );
      }

      // Get user profile
      final userProfile = await _getUserProfile(response.user!.id);
      
      return ApiResponse.success(
        data: userProfile,
        message: 'Signed in successfully',
      );
    } on AuthException catch (e) {
      return ApiResponse.error(
        message: e.message,
        statusCode: 400,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'An unexpected error occurred: $e',
        statusCode: 500,
      );
    }
  }

  /// Sign out
  Future<ApiResponse<bool>> signOut() async {
    try {
      await _supabase.auth.signOut();
      return ApiResponse.success(
        data: true,
        message: 'Signed out successfully',
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to sign out: $e',
      );
    }
  }

  /// Get current user
  Future<ApiResponse<User?>> getCurrentUser() async {
    try {
      final supabaseUser = _supabase.auth.currentUser;
      
      if (supabaseUser == null) {
        return ApiResponse.success(data: null);
      }

      final userProfile = await _getUserProfile(supabaseUser.id);
      return ApiResponse.success(data: userProfile);
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to get current user: $e',
      );
    }
  }

  /// Reset password
  Future<ApiResponse<bool>> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return ApiResponse.success(
        data: true,
        message: 'Password reset email sent. Please check your inbox.',
      );
    } on AuthException catch (e) {
      return ApiResponse.error(
        message: e.message,
        statusCode: 400,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to send reset email: $e',
      );
    }
  }

  /// Update password
  Future<ApiResponse<bool>> updatePassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      return ApiResponse.success(
        data: true,
        message: 'Password updated successfully',
      );
    } on AuthException catch (e) {
      return ApiResponse.error(
        message: e.message,
        statusCode: 400,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to update password: $e',
      );
    }
  }

  /// Listen to auth state changes
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Create user profile in custom table
  Future<User> _createUserProfile(SupabaseClient supabaseUser) async {
    final now = DateTime.now();
    final userData = {
      'id': supabaseUser.id,
      'email': supabaseUser.email,
      'username': supabaseUser.userMetadata?['username'] ?? 'user_${supabaseUser.id.substring(0, 8)}',
      'first_name': supabaseUser.userMetadata?['first_name'],
      'last_name': supabaseUser.userMetadata?['last_name'],
      'avatar': supabaseUser.userMetadata?['avatar_url'],
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    };

    await _supabase.from('users').insert(userData);

    // Create user stats
    await _supabase.from('user_stats').insert({
      'user_id': supabaseUser.id,
      'created_at': now.toIso8601String(),
      'updated_at': now.toIso8601String(),
    });

    return User(
      id: supabaseUser.id,
      username: userData['username'] as String,
      email: userData['email'] as String,
      firstName: userData['first_name'] as String?,
      lastName: userData['last_name'] as String?,
      avatar: userData['avatar'] as String?,
      stats: const UserStats(),
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Get user profile from custom table
  Future<User> _getUserProfile(String userId) async {
    final response = await _supabase
        .from('users')
        .select('*, user_stats(*)')
        .eq('id', userId)
        .single();

    final statsData = response['user_stats'] as Map<String, dynamic>?;
    
    return User(
      id: response['id'] as String,
      username: response['username'] as String,
      email: response['email'] as String,
      firstName: response['first_name'] as String?,
      lastName: response['last_name'] as String?,
      avatar: response['avatar'] as String?,
      phone: response['phone'] as String?,
      birthDate: response['birth_date'] != null
          ? DateTime.parse(response['birth_date'] as String)
          : null,
      bio: response['bio'] as String?,
      stats: statsData != null ? UserStats.fromJson(statsData) : const UserStats(),
      createdAt: DateTime.parse(response['created_at'] as String),
      updatedAt: DateTime.parse(response['updated_at'] as String),
    );
  }
}

/// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(SupabaseConfig.client);
});
