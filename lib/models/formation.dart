// lib/models/formation.dart
class Formation {
  // Le Long de Java devient int en Dart
  final int id;
  final String nom;
  final int duree;

  Formation({
    required this.id,
    required this.nom,
    required this.duree,
  });

  // Convertit l'objet JSON reçu de Spring Boot en objet Formation Dart
  factory Formation.fromJson(Map<String, dynamic> json) {
    return Formation(
      id: json['id'] as int,
      nom: json['nom'] as String,
      duree: json['duree'] as int,
    );
  }
}
