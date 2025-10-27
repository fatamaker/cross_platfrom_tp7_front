// lib/models/user.dart
import 'dart:convert';

class User {
  final int id;
  final String email;

  User(this.id, this.email);

  // Méthode de fabrique pour créer un objet User à partir du JSON (Map)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map["id"],
      map["email"],
    );
  }
}
