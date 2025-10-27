// lib/gestion_etudiants_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp7_isetn/models/classe.dart';

// URL de base de l'API (assurez-vous d'utiliser le bon port 8080 ou 8081)
const String _baseUrl = "http://10.0.2.2:3000";

class GestionEtudiantsScreen extends StatefulWidget {
  const GestionEtudiantsScreen({super.key});

  @override
  State<GestionEtudiantsScreen> createState() => _GestionEtudiantsScreenState();
}

class _GestionEtudiantsScreenState extends State<GestionEtudiantsScreen> {
  Future<List<Classe>>? _classesFuture;
  Classe? _selectedClasse; // La classe actuellement sélectionnée

  @override
  void initState() {
    super.initState();
    // Lance la récupération des classes au démarrage de l'écran
    _classesFuture = _fetchClasses();
  }

  // Fonction pour récupérer la liste des classes (GET /classes/all)
  Future<List<Classe>> _fetchClasses() async {
    final response = await http.get(Uri.parse('$_baseUrl/classes/all'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      // Mappe la liste des JSON en objets Classe
      List<Classe> classes =
          body.map((dynamic item) => Classe.fromJson(item)).toList();

      // Si la liste n'est pas vide, initialise la classe sélectionnée
      if (classes.isNotEmpty) {
        setState(() {
          _selectedClasse = classes.first;
        });
      }
      return classes;
    } else {
      throw Exception('Failed to load classes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des Étudiants")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Classe :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            // FutureBuilder pour gérer l'état de chargement des données
            FutureBuilder<List<Classe>>(
              future: _classesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Erreur de chargement: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<Classe> classes = snapshot.data!;

                  return DropdownButton<Classe>(
                    value: _selectedClasse,
                    items: classes.map((Classe classe) {
                      return DropdownMenuItem<Classe>(
                        // Le 'value' est l'objet Classe, le 'child' est le nom affiché (codClass)
                        value: classe,
                        child: Text(classe.codClass
                            as String), // Afficher le Code Classe
                      );
                    }).toList(),
                    onChanged: (Classe? newValue) {
                      setState(() {
                        _selectedClasse = newValue;
                        // Logique future : Charger les étudiants de cette nouvelle classe
                        // _fetchEtudiantsByClasse(newValue!.codClass);
                      });
                    },
                  );
                } else {
                  return const Text('Aucune classe trouvée.');
                }
              },
            ),

            const SizedBox(height: 30),
            // Placeholder pour l'affichage de la liste des étudiants
            Expanded(
              child: Center(
                child: Text(
                  "Étudiants de la classe : ${_selectedClasse?.codClass ?? 'N/A'}\n(Implémenter la liste ici)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
