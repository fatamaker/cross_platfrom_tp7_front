import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

// URL de base de l'API Spring Boot
// ATTENTION : L'IP 10.0.2.2 fonctionne UNIQUEMENT pour l'émulateur Android.
// Utilisez votre IP locale (e.g., 192.168.1.XX) pour un appareil physique ou 'localhost' pour Chrome/Web.
const String _baseUrl = "http://10.0.2.2:3000";

// A. Fonction d'Inscription (Register)
Future<User> register(String email, String password) async {
  final url = Uri.parse("$_baseUrl/register");

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  // L'API Spring renvoie généralement 200 (OK) ou 201 (Created) en cas de succès.
  if (response.statusCode == 200 || response.statusCode == 201) {
    // Si l'inscription réussit, l'API renvoie les données de l'utilisateur créé.
    return User.fromMap(jsonDecode(response.body));
  } else {
    // Gestion d'erreur, par exemple, si l'email existe déjà (409 Conflict) ou autre erreur serveur.
    throw Exception('Failed to register. Status: ${response.statusCode}');
  }
}

// B. Fonction de Connexion (Login)
Future<User> login(String email, String password) async {
  final url = Uri.parse("$_baseUrl/login");

  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);

    // Le contrôleur Spring renvoie l'objet 'User' si trouvé, ou 'null' si les identifiants sont invalides.
    if (body != null) {
      return User.fromMap(body);
    } else {
      // API a retourné 200, mais le corps est null -> Identifiants invalides
      throw Exception('Invalid email or password.');
    }
  } else {
    // Gérer les erreurs de connexion (e.g., 500 Internal Server Error)
    throw Exception('Failed to log in. Status: ${response.statusCode}');
  }
}
