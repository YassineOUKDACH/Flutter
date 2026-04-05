import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductFormScreen(),
    );
  }
}

class ProductFormScreen extends StatefulWidget {
  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String nom = "";
  String prix = "";
  String? categorie;
  bool enPromotion = false;
  String typeProduit = "Physique";
  bool disponible = true;
  double quantite = 1;
  DateTime? dateAjout;

  Future<void> choisirDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        dateAjout = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String dateText = dateAjout == null
        ? "Aucune date sélectionnée"
        : "${dateAjout!.day}/${dateAjout!.month}/${dateAjout!.year}";

    return Scaffold(
      appBar: AppBar(
        title: Text("Formulaire Produit"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Nom du produit
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Nom du produit",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer le nom du produit";
                  }
                  return null;
                },
                onSaved: (value) {
                  nom = value!;
                },
              ),

              SizedBox(height: 20),

              // Prix
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Prix",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez entrer le prix";
                  }
                  return null;
                },
                onSaved: (value) {
                  prix = value!;
                },
              ),

              SizedBox(height: 20),

              // Catégorie
              DropdownButtonFormField<String>(
                value: categorie,
                decoration: InputDecoration(
                  labelText: "Catégorie",
                  border: OutlineInputBorder(),
                ),
                items: ["Informatique", "Accessoires", "Audio", "Téléphonie"]
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    categorie = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Veuillez choisir une catégorie";
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Checkbox
              CheckboxListTile(
                value: enPromotion,
                onChanged: (value) {
                  setState(() {
                    enPromotion = value!;
                  });
                },
                title: Text("Produit en promotion"),
                secondary: Icon(Icons.local_offer),
              ),

              SizedBox(height: 10),

              // Radio
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Type de produit",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              RadioListTile<String>(
                value: "Physique",
                groupValue: typeProduit,
                onChanged: (value) {
                  setState(() {
                    typeProduit = value!;
                  });
                },
                title: Text("Physique"),
              ),

              RadioListTile<String>(
                value: "Numérique",
                groupValue: typeProduit,
                onChanged: (value) {
                  setState(() {
                    typeProduit = value!;
                  });
                },
                title: Text("Numérique"),
              ),

              SizedBox(height: 10),

              // Switch
              SwitchListTile(
                value: disponible,
                onChanged: (value) {
                  setState(() {
                    disponible = value;
                  });
                },
                title: Text("Produit disponible"),
                secondary: Icon(Icons.check_circle),
              ),

              SizedBox(height: 20),

              // Slider
              Text(
                "Quantité : ${quantite.toStringAsFixed(0)}",
                style: TextStyle(fontSize: 16),
              ),
              Slider(
                value: quantite,
                min: 1,
                max: 100,
                divisions: 99,
                label: quantite.toStringAsFixed(0),
                onChanged: (value) {
                  setState(() {
                    quantite = value;
                  });
                },
              ),

              SizedBox(height: 20),

              // DatePicker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Date d'ajout : $dateText",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: choisirDate,
                    child: Text("Choisir une date"),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Bouton de soumission
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Produit ajouté : $nom | $prix DH | $categorie",
                        ),
                      ),
                    );
                  }
                },
                child: Text("Enregistrer le produit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
