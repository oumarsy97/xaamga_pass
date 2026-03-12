enum UserRole { admin, guichet, checking, food, drink, activity, unknown }

extension UserRoleExtension on UserRole {
  int get code {
    switch (this) {
      case UserRole.admin:
        return 14;
      case UserRole.guichet:
        return 15; // Hypothetical codes based on Admin=14
      case UserRole.checking:
        return 16;
      case UserRole.food:
        return 17;
      case UserRole.drink:
        return 18;
      case UserRole.activity:
        return 19;
      default:
        return 0;
    }
  }

  static UserRole fromCode(int code) {
    switch (code) {
      case 14:
        return UserRole.admin;
      case 15:
        return UserRole.guichet;
      case 16:
        return UserRole.checking;
      case 17:
        return UserRole.food;
      case 18:
        return UserRole.drink;
      case 19:
        return UserRole.activity;
      default:
        return UserRole.unknown;
    }
  }

  String get label {
    switch (this) {
      case UserRole.admin:
        return 'Administrateur';
      case UserRole.guichet:
        return 'Guichet';
      case UserRole.checking:
        return 'Check-in';
      case UserRole.food:
        return 'Food Court';
      case UserRole.drink:
        return 'Drink';
      case UserRole.activity:
        return 'Activity';
      default:
        return 'Inconnu';
    }
  }
}

class UserModel {
  final int id;
  final String? nom;
  final String? telephone;
  final String? username;
  final UserRole role;
  final String? eventId;

  UserModel({
    required this.id,
    this.nom,
    this.telephone,
    this.username,
    required this.role,
    this.eventId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      nom: json['nom'] as String?,
      telephone: json['telephone'] as String?,
      username: json['user'] as String?,
      role: UserRoleExtension.fromCode(json['role'] as int? ?? 0),
      eventId: json['event']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'telephone': telephone,
      'user': username,
      'role': role.code,
      'event': eventId,
    };
  }
}
