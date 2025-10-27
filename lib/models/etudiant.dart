// lib/models/etudiant.dart
import 'classe.dart';
import 'formation.dart';

class Etudiant {
  // Le Long de Java devient int en Dart
  final int id;
  final String nom;
  final String prenom;
  // La Date de Java est reçue comme String en JSON (ex: "2000-01-01")
  final DateTime dateNais;

  // Les relations ManyToOne sont reçues comme des objets JSON imbriqués
  final Formation formation;
  final Classe classe;

  Etudiant({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.dateNais,
    required this.formation,
    required this.classe,
  });

  // Convertit l'objet JSON reçu de Spring Boot en objet Etudiant Dart
  factory Etudiant.fromJson(Map<String, dynamic> json) {
    return Etudiant(
      id: json['id'] as int,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      // Conversion de la String de la date en objet DateTime
      dateNais: DateTime.parse(json['dateNais']),

      // Appel des factory constructors des modèles imbriqués
      formation: Formation.fromJson(json['formation']),
      classe: Classe.fromJson(json['classe']),
    );
  }
}
