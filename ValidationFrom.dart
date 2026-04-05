import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormValidationExample(),
    );
  }
}

class FormValidationExample extends StatefulWidget {
  @override
  State<FormValidationExample> createState() =>
      _FormValidationExampleState();
}

class _FormValidationExampleState extends State<FormValidationExample> {
  final _formKey = GlobalKey<FormState>();

  String nom = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Validation Formulaire"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Champ Nom
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nom",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre nom";
                  }
                  return null;
                },
                onSaved: (value) {
                  nom = value!;
                },
              ),

              SizedBox(height: 20),

              // Champ Email
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer votre email";
                  }
                  if (!value.contains("@")) {
                    return "Email invalide";
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),

              SizedBox(height: 20),

              // Bouton de validation
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Nom: $nom | Email: $email",
                        ),
                      ),
                    );
                  }
                },
                child: Text("Valider"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
