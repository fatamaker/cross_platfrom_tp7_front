import 'package:flutter/material.dart';
import 'package:tp7_isetn/screens/dashboard_screen.dart';
import 'package:tp7_isetn/screens/register.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
// Importez votre écran de destination après la connexion (par exemple, Dashboard)

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Variables d'État
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Méthode de Connexion
  void handleSignIn() async {
    // Vérifie que le formulaire est valide (champs non vides, format email, etc.)
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {}); // Optionnel: Pour montrer un indicateur de chargement

      try {
        // 1. Appel du service de connexion
        User u = await login(emailController.text, passwordController.text);

        // 2. Succès : Navigation vers l'écran suivant (Dashboard)
        print('User logged in: ${u.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } catch (e) {
        // 3. Échec : Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().contains('Invalid email or password')
                  ? 'Identifiants invalides. Veuillez réessayer.'
                  : 'Erreur de connexion : ${e.toString()}',
            ),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        // Cacher l'indicateur de chargement si vous en aviez un
        setState(() {});
      }
    }
  }

  // Construction de l'UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Champ Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Champ Mot de passe
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Bouton de Connexion
                ElevatedButton(
                  onPressed: handleSignIn,
                  child: const Text('Se Connecter'),
                ),
                const SizedBox(height: 20),

                // Lien vers l'Inscription
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  child: const Text("Pas encore de compte ? S'inscrire"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
