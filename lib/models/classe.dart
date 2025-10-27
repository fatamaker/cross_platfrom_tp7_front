// lib/models/classe.dart
class Classe {
  // Le Long de Java devient int en Dart
  final int codClass;
  final String nomClass;
  final int nbreEtud;

  Classe({
    required this.codClass,
    required this.nomClass,
    required this.nbreEtud,
  });

  // Convertit l'objet JSON reçu de Spring Boot en objet Classe Dart
  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      codClass: json['codClass'] as int,
      nomClass: json['nomClass'] as String,
      nbreEtud: json['nbreEtud'] as int,
    );
  }

  // Permet d'afficher la classe dans le DropDownButton ou un log.
  @override
  String toString() => nomClass;
}
