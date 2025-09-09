import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/models.dart';
import '../data/repositories/auth_repository.dart';

/// Auth State for managing authentication
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error,
    );
  }
}

/// Auth Provider for managing authentication state
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _checkCurrentUser();
    _listenToAuthChanges();
  }

  /// Check if user is already authenticated
  Future<void> _checkCurrentUser() async {
    state = state.copyWith(isLoading: true);
    
    final response = await _authRepository.getCurrentUser();
    
    if (response.success && response.data != null) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.data,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        user: null,
        error: null,
      );
    }
  }

  /// Listen to auth state changes from Supabase
  void _listenToAuthChanges() {
    _authRepository.authStateChanges.listen((authState) {
      if (authState.event.name == 'SIGNED_IN') {
        _checkCurrentUser();
      } else if (authState.event.name == 'SIGNED_OUT') {
        state = state.copyWith(
          isAuthenticated: false,
          user: null,
          error: null,
        );
      }
    });
  }

  /// Sign up with email and password
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    String? firstName,
    String? lastName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _authRepository.signUp(
      email: email,
      password: password,
      username: username,
      firstName: firstName,
      lastName: lastName,
    );

    if (response.success) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.data,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message,
      );
    }
  }

  /// Sign in with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _authRepository.signIn(
      email: email,
      password: password,
    );

    if (response.success) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: response.data,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message,
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);

    await _authRepository.signOut();

    state = state.copyWith(
      isLoading: false,
      isAuthenticated: false,
      user: null,
      error: null,
    );
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _authRepository.resetPassword(email);

    state = state.copyWith(
      isLoading: false,
      error: response.success ? null : response.message,
    );

    return response.success;
  }

  /// Update password
  Future<bool> updatePassword(String newPassword) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _authRepository.updatePassword(newPassword);

    state = state.copyWith(
      isLoading: false,
      error: response.success ? null : response.message,
    );

    return response.success;
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});
