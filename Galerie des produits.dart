import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductGalleryScreen(),
    );
  }
}

class ProductGalleryScreen extends StatefulWidget {
  @override
  State<ProductGalleryScreen> createState() => _ProductGalleryScreenState();
}

class _ProductGalleryScreenState extends State<ProductGalleryScreen> {
  bool isGrid = true;
  String selectedOption = "Aucune option sélectionnée";

  final List<Map<String, dynamic>> produits = [
    {
      "nom": "Ordinateur",
      "prix": "8000 DH",
      "icone": Icons.laptop,
      "couleur": Colors.blue.shade100,
    },
    {
      "nom": "Clavier",
      "prix": "300 DH",
      "icone": Icons.keyboard,
      "couleur": Colors.green.shade100,
    },
    {
      "nom": "Souris",
      "prix": "150 DH",
      "icone": Icons.mouse,
      "couleur": Colors.orange.shade100,
    },
    {
      "nom": "Écran",
      "prix": "2500 DH",
      "icone": Icons.monitor,
      "couleur": Colors.purple.shade100,
    },
    {
      "nom": "Téléphone",
      "prix": "4500 DH",
      "icone": Icons.smartphone,
      "couleur": Colors.red.shade100,
    },
    {
      "nom": "Casque",
      "prix": "500 DH",
      "icone": Icons.headphones,
      "couleur": Colors.teal.shade100,
    },
  ];

  void handleMenuAction(String value) {
    setState(() {
      selectedOption = value;

      if (value == "Vue grille") {
        isGrid = true;
      } else if (value == "Vue liste") {
        isGrid = false;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Option choisie : $value"),
      ),
    );
  }

  Widget buildGridItem(Map<String, dynamic> produit) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(12),
        color: produit["couleur"],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              produit["icone"],
              size: 50,
            ),
            SizedBox(height: 10),
            Text(
              produit["nom"],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              produit["prix"],
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(Map<String, dynamic> produit) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        tileColor: produit["couleur"],
        leading: Icon(
          produit["icone"],
          size: 35,
        ),
        title: Text(
          produit["nom"],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Prix : ${produit["prix"]}"),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,

        // leading : élément à gauche
        leading: IconButton(
          icon: Icon(Icons.store),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Icône boutique cliquée"),
              ),
            );
          },
        ),

        // title : titre principal
        title: Text("Galerie des produits"),

        // actions : éléments à droite
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu), // icône des trois lignes
            onSelected: handleMenuAction,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Vue grille",
                child: Text("Vue grille"),
              ),
              PopupMenuItem(
                value: "Vue liste",
                child: Text("Vue liste"),
              ),
              PopupMenuItem(
                value: "Trier par nom",
                child: Text("Trier par nom"),
              ),
              PopupMenuItem(
                value: "À propos",
                child: Text("À propos"),
              ),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            color: Colors.grey.shade200,
            child: Text(
              "Option sélectionnée : $selectedOption",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: isGrid
                ? GridView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: produits.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return buildGridItem(produits[index]);
                    },
                  )
                : ListView.builder(
                    itemCount: produits.length,
                    itemBuilder: (context, index) {
                      return buildListItem(produits[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
