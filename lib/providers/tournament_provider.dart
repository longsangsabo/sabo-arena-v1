import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../data/data.dart';

/// Tournament state
class TournamentState extends Equatable {
  final List<Tournament> tournaments;
  final bool isLoading;
  final String? error;
  final int newTournamentCount; // For badge

  const TournamentState({
    this.tournaments = const [],
    this.isLoading = false,
    this.error,
    this.newTournamentCount = 0,
  });

  TournamentState copyWith({
    List<Tournament>? tournaments,
    bool? isLoading,
    String? error,
    int? newTournamentCount,
  }) {
    return TournamentState(
      tournaments: tournaments ?? this.tournaments,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      newTournamentCount: newTournamentCount ?? this.newTournamentCount,
    );
  }

  @override
  List<Object?> get props => [tournaments, isLoading, error, newTournamentCount];
}

/// Tournament Notifier
class TournamentNotifier extends StateNotifier<TournamentState> {
  TournamentNotifier() : super(const TournamentState()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    // Mock data - trong thực tế sẽ fetch từ API
    state = state.copyWith(
      newTournamentCount: 8, // Badge count
    );
  }

  /// Load tournaments from API
  Future<void> loadTournaments() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock tournaments data
      final now = DateTime.now();
      final mockUser = User(
        id: 'user_1',
        username: 'organizer',
        email: 'organizer@example.com',
        stats: const UserStats(),
        createdAt: now,
        updatedAt: now,
      );

      final mockTournaments = [
        Tournament(
          id: '1',
          name: 'Giải Bóng Đá Mùa Xuân 2025',
          description: 'Giải đấu bóng đá hấp dẫn nhất mùa xuân',
          type: TournamentType.football,
          status: TournamentStatus.upcoming,
          startDate: now.add(const Duration(days: 7)),
          endDate: now.add(const Duration(days: 14)),
          registrationDeadline: now.add(const Duration(days: 5)),
          maxParticipants: 16,
          currentParticipants: 12,
          settings: const TournamentSettings(
            format: TournamentFormat.knockout,
            teamSize: 11,
          ),
          organizer: mockUser,
          createdAt: now,
          updatedAt: now,
        ),
        Tournament(
          id: '2',
          name: 'Cup Futsal Sinh Viên',
          description: 'Giải futsal dành cho sinh viên',
          type: TournamentType.futsal,
          status: TournamentStatus.upcoming,
          startDate: now.add(const Duration(days: 21)),
          endDate: now.add(const Duration(days: 23)),
          registrationDeadline: now.add(const Duration(days: 19)),
          maxParticipants: 8,
          currentParticipants: 5,
          settings: const TournamentSettings(
            format: TournamentFormat.knockout,
            teamSize: 5,
          ),
          organizer: mockUser,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      state = state.copyWith(
        tournaments: mockTournaments,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Mark tournaments as viewed (clear badge)
  void markTournamentsAsViewed() {
    state = state.copyWith(newTournamentCount: 0);
  }

  /// Add new tournament
  void addTournament(Tournament tournament) {
    final updatedTournaments = [...state.tournaments, tournament];
    state = state.copyWith(
      tournaments: updatedTournaments,
      newTournamentCount: state.newTournamentCount + 1,
    );
  }

  /// Update tournament
  void updateTournament(Tournament tournament) {
    final updatedTournaments = state.tournaments.map((t) {
      return t.id == tournament.id ? tournament : t;
    }).toList();

    state = state.copyWith(tournaments: updatedTournaments);
  }

  /// Remove tournament
  void removeTournament(String tournamentId) {
    final updatedTournaments = state.tournaments.where((t) => t.id != tournamentId).toList();
    state = state.copyWith(tournaments: updatedTournaments);
  }
}

/// Tournament Provider
final tournamentProvider = StateNotifierProvider<TournamentNotifier, TournamentState>((ref) {
  return TournamentNotifier();
});

/// Individual providers for common use cases
final tournamentListProvider = Provider<List<Tournament>>((ref) {
  return ref.watch(tournamentProvider).tournaments;
});

final tournamentBadgeCountProvider = Provider<int>((ref) {
  return ref.watch(tournamentProvider).newTournamentCount;
});

final upcomingTournamentsProvider = Provider<List<Tournament>>((ref) {
  final tournaments = ref.watch(tournamentProvider).tournaments;
  return tournaments.where((t) => t.status == TournamentStatus.upcoming).toList();
});

final activeTournamentsProvider = Provider<List<Tournament>>((ref) {
  final tournaments = ref.watch(tournamentProvider).tournaments;
  return tournaments.where((t) => t.status == TournamentStatus.ongoing).toList();
});

final tournamentLoadingProvider = Provider<bool>((ref) {
  return ref.watch(tournamentProvider).isLoading;
});
