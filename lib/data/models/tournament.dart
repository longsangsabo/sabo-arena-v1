import 'package:equatable/equatable.dart';
import 'user.dart';

/// Tournament model class
class Tournament extends Equatable {
  final String id;
  final String name;
  final String description;
  final String organizerId;
  final User? organizer;
  final TournamentType type;
  final TournamentStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationDeadline;
  final int maxParticipants;
  final int currentParticipants;
  final double? entryFee;
  final String? prizePool;
  final List<String> rules;
  final String? location;
  final String? imageUrl;
  final List<String> participantIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.organizerId,
    this.organizer,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.registrationDeadline,
    required this.maxParticipants,
    this.currentParticipants = 0,
    this.entryFee,
    this.prizePool,
    this.rules = const [],
    this.location,
    this.imageUrl,
    this.participantIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  Tournament copyWith({
    String? id,
    String? name,
    String? description,
    String? organizerId,
    User? organizer,
    TournamentType? type,
    TournamentStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? registrationDeadline,
    int? maxParticipants,
    int? currentParticipants,
    double? entryFee,
    String? prizePool,
    List<String>? rules,
    String? location,
    String? imageUrl,
    List<String>? participantIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      organizerId: organizerId ?? this.organizerId,
      organizer: organizer ?? this.organizer,
      type: type ?? this.type,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      registrationDeadline: registrationDeadline ?? this.registrationDeadline,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      entryFee: entryFee ?? this.entryFee,
      prizePool: prizePool ?? this.prizePool,
      rules: rules ?? this.rules,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      participantIds: participantIds ?? this.participantIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Factory constructor from JSON
  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      organizerId: json['organizer_id'] as String,
      organizer: json['organizer'] != null 
          ? User.fromJson(json['organizer'] as Map<String, dynamic>)
          : null,
      type: TournamentType.fromString(json['type'] as String),
      status: TournamentStatus.fromString(json['status'] as String),
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      registrationDeadline: DateTime.parse(json['registration_deadline'] as String),
      maxParticipants: json['max_participants'] as int,
      currentParticipants: json['current_participants'] as int? ?? 0,
      entryFee: (json['entry_fee'] as num?)?.toDouble(),
      prizePool: json['prize_pool'] as String?,
      rules: (json['rules'] as List<dynamic>?)?.cast<String>() ?? [],
      location: json['location'] as String?,
      imageUrl: json['image_url'] as String?,
      participantIds: (json['participant_ids'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'organizer_id': organizerId,
      'organizer': organizer?.toJson(),
      'type': type.value,
      'status': status.value,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'registration_deadline': registrationDeadline.toIso8601String(),
      'max_participants': maxParticipants,
      'current_participants': currentParticipants,
      'entry_fee': entryFee,
      'prize_pool': prizePool,
      'rules': rules,
      'location': location,
      'image_url': imageUrl,
      'participant_ids': participantIds,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Helper getters
  bool get isFull => currentParticipants >= maxParticipants;
  bool get isRegistrationOpen => DateTime.now().isBefore(registrationDeadline) && !isFull;
  bool get hasStarted => DateTime.now().isAfter(startDate);
  bool get hasEnded => DateTime.now().isAfter(endDate);
  bool get isUpcoming => status == TournamentStatus.upcoming;
  bool get isActive => status == TournamentStatus.active;
  bool get isCompleted => status == TournamentStatus.completed;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        organizerId,
        organizer,
        type,
        status,
        startDate,
        endDate,
        registrationDeadline,
        maxParticipants,
        currentParticipants,
        entryFee,
        prizePool,
        rules,
        location,
        imageUrl,
        participantIds,
        createdAt,
        updatedAt,
      ];
}

/// Tournament type enum
enum TournamentType {
  football('football'),
  futsal('futsal'),
  basketball('basketball'),
  volleyball('volleyball'),
  tennis('tennis'),
  badminton('badminton'),
  other('other');

  const TournamentType(this.value);
  final String value;

  static TournamentType fromString(String value) {
    return TournamentType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => TournamentType.other,
    );
  }

  String get displayName {
    switch (this) {
      case TournamentType.football:
        return 'Bóng đá';
      case TournamentType.futsal:
        return 'Futsal';
      case TournamentType.basketball:
        return 'Bóng rổ';
      case TournamentType.volleyball:
        return 'Bóng chuyền';
      case TournamentType.tennis:
        return 'Tennis';
      case TournamentType.badminton:
        return 'Cầu lông';
      case TournamentType.other:
        return 'Khác';
    }
  }
}

/// Tournament status enum
enum TournamentStatus {
  draft('draft'),
  upcoming('upcoming'),
  active('active'),
  completed('completed'),
  cancelled('cancelled');

  const TournamentStatus(this.value);
  final String value;

  static TournamentStatus fromString(String value) {
    return TournamentStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => TournamentStatus.draft,
    );
  }

  String get displayName {
    switch (this) {
      case TournamentStatus.draft:
        return 'Nháp';
      case TournamentStatus.upcoming:
        return 'Sắp diễn ra';
      case TournamentStatus.active:
        return 'Đang diễn ra';
      case TournamentStatus.completed:
        return 'Đã kết thúc';
      case TournamentStatus.cancelled:
        return 'Đã hủy';
    }
  }
}
