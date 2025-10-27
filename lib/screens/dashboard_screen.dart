// lib/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:tp7_isetn/screens/gestion_etudiants_screen.dart';

import 'login.dart'; // Pour la déconnexion (si vous l'ajoutez)

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil ScolA7"),
        backgroundColor: Colors.blueGrey,
      ),
      // --- Implémentation du Drawer ---
      drawer: buildDrawer(context),

      body: const Center(
        child: Text(
          "Sélectionnez une option dans le menu latéral",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // L'en-tête du Drawer (style du TP)
          const UserAccountsDrawerHeader(
            accountName: Text("ISET Nabeul", style: TextStyle(fontSize: 18)),
            accountEmail: Text(
                "Exercise for groups : DSI33 and DSI31"), // Texte de l'exercice
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("Ex",
                  style: TextStyle(fontSize: 40.0, color: Colors.purple)),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF9C27B0), // Couleur violette
            ),
          ),

          // 1. Manage groups (Gestion des Classes/Groupes)
          ListTile(
            leading: const Icon(Icons.people, color: Colors.deepOrange),
            title: const Text('Manage groups'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              // Naviguer vers l'écran de gestion des groupes (Classe)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GestionClassesScreen()));
            },
          ),

          // 2. Manage students (Gestion des Étudiants)
          ListTile(
            leading: const Icon(Icons.school, color: Colors.deepOrange),
            title: const Text('Manage students'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              // Naviguer vers l'écran de gestion des étudiants (avec DropDownButton)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GestionEtudiantsScreen()));
            },
          ),

          // 3. Manage teachers (Gestion des Professeurs)
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepOrange),
            title: const Text('Manage teachers'),
            onTap: () {
              Navigator.pop(context);
              // Naviguer vers l'écran de gestion des professeurs
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GestionTeachersScreen()));
            },
          ),

          const Divider(),

          // 4. Close (Fermer le Drawer / Déconnexion)
          ListTile(
            leading: const Icon(Icons.close, color: Colors.red),
            title: const Text('Close'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              // Optionnel: Déconnecter et retourner à l'écran de Login
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

// Écrans factices (placeholders)
class GestionClassesScreen extends StatelessWidget {
  const GestionClassesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des Groupes")),
      body: const Center(child: Text("Gestion des Classes / Groupes")),
    );
  }
}

class GestionTeachersScreen extends StatelessWidget {
  const GestionTeachersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des Professeurs")),
      body: const Center(child: Text("Gestion des Professeurs")),
    );
  }
}
