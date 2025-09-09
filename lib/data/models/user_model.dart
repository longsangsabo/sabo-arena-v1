import 'package:equatable/equatable.dart';

/// User Model
class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? avatar;
  final String? phone;
  final DateTime? birthDate;
  final String? bio;
  final UserStats stats;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.phone,
    this.birthDate,
    this.bio,
    required this.stats,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get display name
  String get displayName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    if (firstName != null) return firstName!;
    return username;
  }

  /// Get full name
  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  /// Factory from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'] as String)
          : null,
      bio: json['bio'] as String?,
      stats: UserStats.fromJson(json['stats'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
      'phone': phone,
      'birth_date': birthDate?.toIso8601String(),
      'bio': bio,
      'stats': stats.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Copy with
  User copyWith({
    String? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
    String? phone,
    DateTime? birthDate,
    String? bio,
    UserStats? stats,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      bio: bio ?? this.bio,
      stats: stats ?? this.stats,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        firstName,
        lastName,
        avatar,
        phone,
        birthDate,
        bio,
        stats,
        createdAt,
        updatedAt,
      ];
}

/// User Statistics Model
class UserStats extends Equatable {
  final int totalTournaments;
  final int wonTournaments;
  final int totalMatches;
  final int wonMatches;
  final int totalGoals;
  final double winRate;
  final int ranking;

  const UserStats({
    this.totalTournaments = 0,
    this.wonTournaments = 0,
    this.totalMatches = 0,
    this.wonMatches = 0,
    this.totalGoals = 0,
    this.winRate = 0.0,
    this.ranking = 0,
  });

  /// Factory from JSON
  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      totalTournaments: json['total_tournaments'] as int? ?? 0,
      wonTournaments: json['won_tournaments'] as int? ?? 0,
      totalMatches: json['total_matches'] as int? ?? 0,
      wonMatches: json['won_matches'] as int? ?? 0,
      totalGoals: json['total_goals'] as int? ?? 0,
      winRate: (json['win_rate'] as num?)?.toDouble() ?? 0.0,
      ranking: json['ranking'] as int? ?? 0,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'total_tournaments': totalTournaments,
      'won_tournaments': wonTournaments,
      'total_matches': totalMatches,
      'won_matches': wonMatches,
      'total_goals': totalGoals,
      'win_rate': winRate,
      'ranking': ranking,
    };
  }

  /// Copy with
  UserStats copyWith({
    int? totalTournaments,
    int? wonTournaments,
    int? totalMatches,
    int? wonMatches,
    int? totalGoals,
    double? winRate,
    int? ranking,
  }) {
    return UserStats(
      totalTournaments: totalTournaments ?? this.totalTournaments,
      wonTournaments: wonTournaments ?? this.wonTournaments,
      totalMatches: totalMatches ?? this.totalMatches,
      wonMatches: wonMatches ?? this.wonMatches,
      totalGoals: totalGoals ?? this.totalGoals,
      winRate: winRate ?? this.winRate,
      ranking: ranking ?? this.ranking,
    );
  }

  @override
  List<Object?> get props => [
        totalTournaments,
        wonTournaments,
        totalMatches,
        wonMatches,
        totalGoals,
        winRate,
        ranking,
      ];
}
