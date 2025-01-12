import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cardex_page.dart';
import 'aboutpage.dart';
import 'home_page.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool _isProcessing = false;
  String? _result;

  Future<void> _selectAndAnalyzeImage() async {
    try {
      // Pour séléctionner une image
      final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files == null || files.isEmpty) return;

        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);

        reader.onLoadEnd.listen((e) async {
          final Uint8List imageBytes = reader.result as Uint8List;

          setState(() {
            _isProcessing = true;
          });

          // Pour envoyer l'image à Roboflow 
          final result = await _analyzeImageWithRoboflow(imageBytes);

          setState(() {
            _result = result;
            _isProcessing = false;
          });

          // Quand une voiture est détecté ça renvoie vers le Cardex
          if (_result != null && _result!.isNotEmpty) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CardexPage(derniereVoitureDetectee: _result),
              ),
            );
          }
        });
      });
    } catch (e) {
      print('Erreur lors de la sélection : $e');
    }
  }

  Future<String> _analyzeImageWithRoboflow(Uint8List imageBytes) async {
    try {
      const apiKey = 'CxMs0B91fsKZttCxS2zI';
      const modelEndpoint = 'https://detect.roboflow.com/car_project-yyjf0/1';
      final url = Uri.parse('$modelEndpoint?api_key=$apiKey');

      final request = http.MultipartRequest('POST', url)
        ..files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: 'image.jpg'));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // Extraire le nom de la voiture détectée
        if (jsonResponse['predictions'] != null && jsonResponse['predictions'].isNotEmpty) {
          return jsonResponse['predictions'][0]['class']; // Nom de la voiture détectée
        } else {
          return 'Aucune voiture détectée';
        }
      } else {
        print('Erreur Roboflow : ${response.statusCode}, ${response.body}');
        return 'Erreur Roboflow : ${response.statusCode}';
      }
    } catch (e) {
      return 'Exception : ${e.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner un véhicule'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isProcessing)
              const CircularProgressIndicator()
            else if (_result != null)
              Text(
                'Résultat : $_result',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isProcessing ? null : _selectAndAnalyzeImage,
              child: const Text('Importer et scanner une photo'),
            ),
          ],
        ),
      ),
    );
  }
}
