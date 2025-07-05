// Beschreibung: Flutter-Anwendung für einen Passwortgenerator
// Autor: Christian Möller
// Version: 1.0.0
// Datum: 05.07.2025
// Für PC-Magazin+PCGo 09/2025
// Diese Anwendung generiert sichere Passwörter basierend auf Benutzereinstellungen
// Sie lässt sich in allen Plattformen, die Flutter unterstützen, ausführen

// Import der benötigten Flutter Material Design Bibliothek
import 'package:flutter/material.dart';
// Import der Mathematik-Bibliothek für Zufallszahlen
import 'dart:math';

// Haupteinstiegspunkt der Anwendung
void main() {
  runApp(MyApp());
}

// Root-Widget der Anwendung
// Definiert das grundlegende Theme und die Hauptseite
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passwort Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PasswordGenerator(),
    );
  }
}

// Hauptwidget für den Passwortgenerator
// Verwaltet den zustandsabhängigen Teil der Anwendung
class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  PasswordGeneratorState createState() => PasswordGeneratorState();
}

// Zustandsklasse für den Passwortgenerator
// Enthält die Logik und den UI-Aufbau
class PasswordGeneratorState extends State<PasswordGenerator> {
  // Zustandsvariablen für das generierte Passwort und die Einstellungen
  String _password = 'Klicken Sie auf "Generieren"';
  double _length = 12; // Standardlänge des Passworts
  bool _includeNumbers = true; // Option für Zahlen
  bool _includeSymbols = true; // Option für Sonderzeichen
  bool _includeUppercase = true; // Option für Großbuchstaben

  // Zeichensätze für die verschiedenen Passwortoptionen
  final String _lowercase = 'abcdefghijklmnopqrstuvwxyz';
  final String _uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final String _numbers = '0123456789';
  final String _symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

  // Methode zur Generierung eines neuen Passworts
  void _generatePassword() {
    // Zusammenstellung der verfügbaren Zeichen basierend auf den Einstellungen
    String chars = _lowercase;

    if (_includeUppercase) chars += _uppercase;
    if (_includeNumbers) chars += _numbers;
    if (_includeSymbols) chars += _symbols;

    // Initialisierung des Zufallsgenerators
    Random random = Random();
    String password = '';

    // Generierung des Passworts durch zufällige Auswahl von Zeichen
    for (int i = 0; i < _length.toInt(); i++) {
      password += chars[random.nextInt(chars.length)];
    }

    // Aktualisierung des Zustands mit dem neuen Passwort
    setState(() {
      _password = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kopfzeile der Anwendung
      appBar: AppBar(title: Text('Passwort Generator'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Kartenwidget zur Anzeige des generierten Passworts
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Generiertes Passwort:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Container für das generierte Passwort mit Styling
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      // Selektierbarer Text für einfaches Kopieren
                      child: SelectableText(
                        _password,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'monospace',
                          color: Colors.blue[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Längeneinstellung mit Slider
            Text('Länge: ${_length.toInt()} Zeichen'),
            Slider(
              value: _length,
              min: 4,
              max: 30,
              divisions: 26,
              onChanged: (value) {
                setState(() {
                  _length = value;
                });
              },
            ),
            SizedBox(height: 10),
            // Optionen für Passworteinstellungen als Checkboxen
            CheckboxListTile(
              title: Text('Großbuchstaben'),
              value: _includeUppercase,
              onChanged: (value) {
                setState(() {
                  _includeUppercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Zahlen'),
              value: _includeNumbers,
              onChanged: (value) {
                setState(() {
                  _includeNumbers = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Sonderzeichen'),
              value: _includeSymbols,
              onChanged: (value) {
                setState(() {
                  _includeSymbols = value!;
                });
              },
            ),
            SizedBox(height: 20),
            // Button zum Generieren eines neuen Passworts
            ElevatedButton(
              onPressed: _generatePassword,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Text(
                  'Neues Passwort generieren',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
