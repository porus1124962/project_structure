import 'base_model.dart';

/// Example model — replace or extend with your own fields.
///
/// ```dart
/// // Deserialise from API response:
/// final user = UserModel.fromJson(response.data as Map<String, dynamic>);
///
/// // Update a single field without mutation:
/// final updated = user.copyWith(name: 'New Name');
/// ```
class UserModel extends BaseModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String email;
  final String? avatarUrl;

  // ── Deserialisation ───────────────────────────────────────────────────────

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  // ── Serialisation ─────────────────────────────────────────────────────────

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatar_url': avatarUrl,
      };

  // ── Immutable update ──────────────────────────────────────────────────────

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  // ── Equality ──────────────────────────────────────────────────────────────

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          avatarUrl == other.avatarUrl;

  @override
  int get hashCode => Object.hash(id, name, email, avatarUrl);

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl)';
}

