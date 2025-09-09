import 'package:equatable/equatable.dart';
import 'user_model.dart';

/// Tournament Model
class Tournament extends Equatable {
  final String id;
  final String name;
  final String description;
  final TournamentType type;
  final TournamentStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationDeadline;
  final int maxParticipants;
  final int currentParticipants;
  final double entryFee;
  final List<Prize> prizes;
  final TournamentSettings settings;
  final User organizer;
  final String? imageUrl;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.registrationDeadline,
    required this.maxParticipants,
    this.currentParticipants = 0,
    this.entryFee = 0.0,
    this.prizes = const [],
    required this.settings,
    required this.organizer,
    this.imageUrl,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  /// Check if tournament is full
  bool get isFull => currentParticipants >= maxParticipants;

  /// Check if registration is open
  bool get isRegistrationOpen {
    final now = DateTime.now();
    return status == TournamentStatus.upcoming &&
        now.isBefore(registrationDeadline) &&
        !isFull;
  }

  /// Get spots remaining
  int get spotsRemaining => maxParticipants - currentParticipants;

  /// Factory from JSON
  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: TournamentType.fromString(json['type'] as String),
      status: TournamentStatus.fromString(json['status'] as String),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      registrationDeadline: DateTime.parse(json['registration_deadline'] as String),
      maxParticipants: json['max_participants'] as int,
      currentParticipants: json['current_participants'] as int? ?? 0,
      entryFee: (json['entry_fee'] as num?)?.toDouble() ?? 0.0,
      prizes: (json['prizes'] as List<dynamic>?)
              ?.map((p) => Prize.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
      settings: TournamentSettings.fromJson(json['settings'] as Map<String, dynamic>),
      organizer: User.fromJson(json['organizer'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.value,
      'status': status.value,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'registration_deadline': registrationDeadline.toIso8601String(),
      'max_participants': maxParticipants,
      'current_participants': currentParticipants,
      'entry_fee': entryFee,
      'prizes': prizes.map((p) => p.toJson()).toList(),
      'settings': settings.toJson(),
      'organizer': organizer.toJson(),
      'image_url': imageUrl,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Copy with
  Tournament copyWith({
    String? id,
    String? name,
    String? description,
    TournamentType? type,
    TournamentStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? registrationDeadline,
    int? maxParticipants,
    int? currentParticipants,
    double? entryFee,
    List<Prize>? prizes,
    TournamentSettings? settings,
    User? organizer,
    String? imageUrl,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      registrationDeadline: registrationDeadline ?? this.registrationDeadline,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      entryFee: entryFee ?? this.entryFee,
      prizes: prizes ?? this.prizes,
      settings: settings ?? this.settings,
      organizer: organizer ?? this.organizer,
      imageUrl: imageUrl ?? this.imageUrl,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        type,
        status,
        startDate,
        endDate,
        registrationDeadline,
        maxParticipants,
        currentParticipants,
        entryFee,
        prizes,
        settings,
        organizer,
        imageUrl,
        tags,
        createdAt,
        updatedAt,
      ];
}

/// Tournament Type Enum
enum TournamentType {
  football('football', 'Bóng đá'),
  futsal('futsal', 'Futsal'),
  basketball('basketball', 'Bóng rổ'),
  volleyball('volleyball', 'Bóng chuyền'),
  tennis('tennis', 'Tennis'),
  badminton('badminton', 'Cầu lông');

  const TournamentType(this.value, this.displayName);

  final String value;
  final String displayName;

  static TournamentType fromString(String value) {
    return TournamentType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => TournamentType.football,
    );
  }
}

/// Tournament Status Enum
enum TournamentStatus {
  upcoming('upcoming', 'Sắp diễn ra'),
  registrationOpen('registration_open', 'Đang mở đăng ký'),
  registrationClosed('registration_closed', 'Đã đóng đăng ký'),
  ongoing('ongoing', 'Đang diễn ra'),
  completed('completed', 'Đã kết thúc'),
  cancelled('cancelled', 'Đã hủy');

  const TournamentStatus(this.value, this.displayName);

  final String value;
  final String displayName;

  static TournamentStatus fromString(String value) {
    return TournamentStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => TournamentStatus.upcoming,
    );
  }
}

/// Prize Model
class Prize extends Equatable {
  final int position;
  final String title;
  final double amount;
  final String? description;

  const Prize({
    required this.position,
    required this.title,
    required this.amount,
    this.description,
  });

  /// Factory from JSON
  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      position: json['position'] as int,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String?,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'title': title,
      'amount': amount,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [position, title, amount, description];
}

/// Tournament Settings Model
class TournamentSettings extends Equatable {
  final TournamentFormat format;
  final int teamSize;
  final int matchDuration; // in minutes
  final bool allowSubstitutions;
  final int maxSubstitutions;
  final String rules;

  const TournamentSettings({
    required this.format,
    this.teamSize = 11,
    this.matchDuration = 90,
    this.allowSubstitutions = true,
    this.maxSubstitutions = 3,
    this.rules = '',
  });

  /// Factory from JSON
  factory TournamentSettings.fromJson(Map<String, dynamic> json) {
    return TournamentSettings(
      format: TournamentFormat.fromString(json['format'] as String),
      teamSize: json['team_size'] as int? ?? 11,
      matchDuration: json['match_duration'] as int? ?? 90,
      allowSubstitutions: json['allow_substitutions'] as bool? ?? true,
      maxSubstitutions: json['max_substitutions'] as int? ?? 3,
      rules: json['rules'] as String? ?? '',
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'format': format.value,
      'team_size': teamSize,
      'match_duration': matchDuration,
      'allow_substitutions': allowSubstitutions,
      'max_substitutions': maxSubstitutions,
      'rules': rules,
    };
  }

  @override
  List<Object?> get props => [
        format,
        teamSize,
        matchDuration,
        allowSubstitutions,
        maxSubstitutions,
        rules,
      ];
}

/// Tournament Format Enum
enum TournamentFormat {
  knockout('knockout', 'Loại trực tiếp'),
  roundRobin('round_robin', 'Vòng tròn'),
  groupStage('group_stage', 'Vòng bảng'),
  swiss('swiss', 'Swiss');

  const TournamentFormat(this.value, this.displayName);

  final String value;
  final String displayName;

  static TournamentFormat fromString(String value) {
    return TournamentFormat.values.firstWhere(
      (format) => format.value == value,
      orElse: () => TournamentFormat.knockout,
    );
  }
}
