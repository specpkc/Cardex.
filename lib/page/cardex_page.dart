import 'package:flutter/material.dart';
import 'aboutpage.dart';
import 'home_page.dart';
import 'scannerpage.dart';

class CardexPage extends StatefulWidget {
  final String? derniereVoitureDetectee; // Pour recevoir la dernière voiture détectée
  const CardexPage({super.key, this.derniereVoitureDetectee});

  @override
  _CardexPageState createState() => _CardexPageState();
}

class _CardexPageState extends State<CardexPage> {
  // Liste des exemples de voitures avec leurs caractéristiques
  List<Map<String, dynamic>> _voituresScannees = [
    {
      
      'nom': 'Ferrari 812 Superfast',
      'annee': '2017-présent',
      'marque': 'Ferrari',
      'modele': '812 Superfast',
      'chevaux': 789,
      'nm': 718,
      'moteur': '6.5L V12 atmosphérique',
      'production': 'En cours',
      'image': 'assets/812.png',
      'detailsVisible': false
    },
    {
      'nom': 'Porsche Carrera 4 GTS',
      'annee': '2015-2019',
      'marque': 'Porsche',
      'modele': 'Carrera 4 GTS',
      'chevaux': 450,
      'nm': 550,
      'moteur': '3.0L flat-6 turbo',
      'production': 'N/A',
      'image': 'assets/porschecarrera.png',
      'detailsVisible': false
    },
    {
      'nom': 'BMW E92 M3',
      'annee': '2007-2013',
      'marque': 'BMW',
      'modele': 'E92 M3',
      'chevaux': 420,
      'nm': 400,
      'moteur': '4.0L V8 atmosphérique',
      'production': 'Environ 40,000',
      'image': 'assets/bmwM3.png',
      'detailsVisible': false
    },
    {
      'nom': 'Porsche 911 Turbo S (992)',
      'annee': '2020-présent',
      'marque': 'Porsche',
      'modele': '911 Turbo S (992)',
      'chevaux': 650,
      'nm': 800,
      'moteur': '3.8L flat-6 bi-turbo',
      'production': 'En cours',
      'image': 'assets/turbo.png',
      'detailsVisible': false
    },
    {
      'nom': 'Nissan Silvia S15',
      'annee': '1999-2002',
      'marque': 'Nissan',
      'modele': 'Silvia S15',
      'chevaux': 250,
      'nm': 275,
      'moteur': '2.0L inline-4 turbo (SR20DET)',
      'production': '30,000 unités',
      'image': 'assets/s15.png',
      'detailsVisible': false
    },


    {
      'nom': 'Mercedes AMG Classe G',
      'annee': '2018-présent',
      'marque': 'Mercedes',
      'modele': 'AMG Classe G',
      'chevaux': 585,
      'nm': 850,
      'moteur': '4.0L V8 bi-turbo',
      'production': 'En cours',
      'image': 'assets/mercedesclassg.png',
      'detailsVisible': false
    },
    {
      'nom': 'Ferrari Roma',
      'annee': '2020-présent',
      'marque': 'Ferrari',
      'modele': 'Roma',
      'chevaux': 620,
      'nm': 760,
      'moteur': '3.9L V8 bi-turbo',
      'production': 'En cours',
      'image': 'assets/roma.png',
      'detailsVisible': false
    },
    {
      'nom': 'BMW F80',
      'annee': '2014-2018',
      'marque': 'BMW',
      'modele': 'F80 M3',
      'chevaux': 431,
      'nm': 550,
      'moteur': '3.0L L6 bi-turbo',
      'production': 'Environ 80,000',
      'image': 'assets/BMW-F80-M3.png',
      'detailsVisible': false
    },
    {
      'nom': 'Porsche Cayenne GTS',
      'annee': '2015-2021',
      'marque': 'Porsche',
      'modele': 'Cayenne GTS',
      'chevaux': 440,
      'nm': 600,
      'moteur': '4.0L V8 bi-turbo',
      'production': 'N/A',
      'image': 'assets/porschecayenne.png',
      'detailsVisible': false
    },
    {
      'nom': 'Porsche 718 GTS',
      'annee': '2017-présent',
      'marque': 'Porsche',
      'modele': '718 GTS',
      'chevaux': 365,
      'nm': 430,
      'moteur': '2.5L flat-4 turbo',
      'production': 'En cours',
      'image': 'assets/porsche718gts.png',
      'detailsVisible': false
    },
    {
      'nom': 'Nissan GTR R34',
      'annee': '1999-2002',
      'marque': 'Nissan',
      'modele': 'GTR R34',
      'chevaux': 280,
      'nm': 392,
      'moteur': '2.6L L6 bi-turbo (RB26DETT)',
      'production': 'Environ 12,000',
      'image': 'assets/nissangtr34.png',
      'detailsVisible': false
    },
    {
      'nom': 'Nissan GTR R35',
      'annee': '2007-présent',
      'marque': 'Nissan',
      'modele': 'GTR R35',
      'chevaux': 565,
      'nm': 633,
      'moteur': '3.8L V6 bi-turbo (VR38DETT)',
      'production': 'En cours',
      'image': 'assets/nissangtr35.png',
      'detailsVisible': false
    },
    {
      'nom': 'Ferrari F12 TDF',
      'annee': '2015-2017',
      'marque': 'Ferrari',
      'modele': 'F12 TDF',
      'chevaux': 780,
      'nm': 705,
      'moteur': '6.3L V12 atmosphérique',
      'production': '799 exemplaires',
      'image': 'assets/f12.png',
      'detailsVisible': false
    },
    { 'nom': 'Ferrari SF90 Stradale',
      'annee': '2019-présent',
      'marque': 'Ferrari',
      'modele': 'SF90 Stradale',
      'chevaux': 1000,
      'nm': 900,
      'moteur': '4.0L V8 bi-turbo + 3 moteurs électriques',
      'production': 'En cours',
      'image': 'assets/sf90.png',
      'detailsVisible': false
    }
  ];

  @override
  void initState() {
    super.initState();
    // Si une voiture détectée est passée via ScannerPage, on l'ajoute au Cardex
    if (widget.derniereVoitureDetectee != null) {
      _voituresScannees.insert(0, {
        'nom': widget.derniereVoitureDetectee,
        'annee': 'Inconnue',
        'marque': 'Inconnue',
        'modele': 'Inconnu',
        'chevaux': 'Inconnu',
        'nm': 'Inconnu',
        'moteur': 'Inconnu',
        'production': 'Inconnue',
        'image': 'assets/default.png', // ça remplace une image par défaut (à changer)
        'detailsVisible': false
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardex'),
        backgroundColor: Colors.redAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              title: const Text('Scanner un véhicule'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ScannerPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Cardex'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CardexPage()),
                );
              },
            ),
            ListTile(
              title: const Text('À propos'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _ajouterVoiture,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Ajouter une voiture'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: _voituresScannees.length,
              itemBuilder: (context, index) {
                return _buildVoitureCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoitureCard(int index) {
    final voiture = _voituresScannees[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          voiture['detailsVisible'] = !voiture['detailsVisible'];
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                voiture['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.car_rental,
                      size: 50,
                      color: Colors.redAccent,
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    voiture['nom'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (voiture['detailsVisible']) ...[
                    const SizedBox(height: 5),
                    Text(
                      'Année : ${voiture['annee']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Marque : ${voiture['marque']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Modèle : ${voiture['modele']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Moteur : ${voiture['moteur']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Chevaux : ${voiture['chevaux']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _ajouterVoiture() {
    setState(() {
      _voituresScannees.insert(0, {
        'nom': 'Nouvelle voiture',
        'annee': 'Inconnue',
        'marque': 'Inconnue',
        'modele': 'Inconnu',
        'chevaux': 'Inconnu',
        'nm': 'Inconnu',
        'moteur': 'Inconnu',
        'production': 'Inconnue',
        'image': 'assets/default.png',
        'detailsVisible': false
      });
    });
  }
}
