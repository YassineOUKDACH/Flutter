import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppBarPopupExample(),
    );
  }
}


class AppBarPopupExample extends StatefulWidget {
  @override
  State<AppBarPopupExample> createState() => _AppBarPopupExampleState();
}

class _AppBarPopupExampleState extends State<AppBarPopupExample> {
  String message = "Aucune option sélectionnée";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,

        // Leading : icône à gauche
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            setState(() {
              message = "Icône profil cliquée";
            });
          },
        ),

        // Title : titre de l'application
        title: Text("AppName"),

        // Actions : éléments à droite
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                message = "Option choisie : $value";
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Profil",
                child: Text("Profil"),
              ),
              PopupMenuItem(
                value: "Paramètres",
                child: Text("Paramètres"),
              ),
              PopupMenuItem(
                value: "Déconnexion",
                child: Text("Déconnexion"),
              ),
            ],
          ),
        ],
      ),

      body: Center(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
