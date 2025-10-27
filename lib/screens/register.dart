import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Méthode d'Inscription
  void handleRegister() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      setState(() {});

      try {
        // 1. Appel du service d'inscription
        User u = await register(emailController.text, passwordController.text);

        // 2. Succès : Afficher un message et retourner à l'écran de Login
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Inscription réussie pour ${u.email} ! Veuillez vous connecter.'),
            backgroundColor: Colors.green));

        Navigator.pop(context); // Retour à l'écran de Login
      } catch (e) {
        // 3. Échec : Afficher un message d'erreur (e.g., email déjà utilisé)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().contains('Failed to register')
                  ? 'Échec de l\'inscription. L\'email est peut-être déjà utilisé.'
                  : 'Erreur: ${e.toString()}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {});
      }
    }
  }

  // Construction de l'UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inscription")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ... (TextFormField pour l'email et le mot de passe, similaires à l'écran Login)
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Veuillez entrer votre email'
                      : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Veuillez entrer votre mot de passe'
                      : null,
                ),
                const SizedBox(height: 40),

                // Bouton d'Inscription
                ElevatedButton(
                  onPressed: handleRegister,
                  child: const Text('S\'inscrire'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
