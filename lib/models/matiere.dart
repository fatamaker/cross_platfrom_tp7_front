// lib/models/matiere.dart

class Matiere {
  // Le Long de Java devient int en Dart
  final int codMat;
  final String intMat;
  final String description;

  Matiere({
    required this.codMat,
    required this.intMat,
    required this.description,
  });

  // Convertit l'objet JSON reçu de Spring Boot en objet Matiere Dart
  factory Matiere.fromJson(Map<String, dynamic> json) {
    return Matiere(
      codMat: json['codMat'] as int,
      intMat: json['intMat'] as String,
      // Note: 'Description' commence par une majuscule dans votre entité Java
      description: json['description'] as String,
    );
  }
}
