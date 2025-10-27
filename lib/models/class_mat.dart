// lib/models/class_mat.dart
import 'classe.dart';
import 'matiere.dart';

class ClassMat {
  // Le Long de Java devient int en Dart
  final int id;

  // Relations ManyToOne imbriquées
  final Classe classe;
  final Matiere matiere;

  final double coefMat; // Float de Java devient double en Dart
  final double nbrHS; // Float de Java devient double en Dart

  ClassMat({
    required this.id,
    required this.classe,
    required this.matiere,
    required this.coefMat,
    required this.nbrHS,
  });

  // Convertit l'objet JSON reçu de Spring Boot en objet ClassMat Dart
  factory ClassMat.fromJson(Map<String, dynamic> json) {
    return ClassMat(
      id: json['id'] as int,
      // Récupération des objets imbriqués
      classe: Classe.fromJson(json['classe']),
      matiere: Matiere.fromJson(json['matiere']),
      // Les Float sont souvent reçus comme double ou int en JSON, utiliser .toDouble()
      coefMat: (json['coefMat'] as num).toDouble(),
      nbrHS: (json['nbrHS'] as num).toDouble(),
    );
  }
}
