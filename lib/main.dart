import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Quotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "PlaywriteESDeco",
      ),
      home: const QuoteGenerator(),
    );
  }
}

class QuoteGenerator extends StatefulWidget {
  const QuoteGenerator({super.key});

  @override
  State<QuoteGenerator> createState() => _QuoteGeneratorState();
}

class _QuoteGeneratorState extends State<QuoteGenerator> {
  final String quoteURL = "https://api.adviceslip.com/advice";
  String quote = 'Press the button to generate a random quote';
   bool isFavorite = false; // Déclaration de la variable isFavorite

  Future<void> generateQuote() async {
    try {
      final response = await http.get(Uri.parse(quoteURL));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          quote = result["slip"]["advice"];
        });
      } else {
        setState(() {
          quote = 'Failed to fetch quote';
        });
      }
    } catch (e) {
      setState(() {
        quote = 'Failed to fetch quote';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: const Center(
          child: Text(
            'Random Quote Generator',
            style: TextStyle(fontFamily: "PlaywriteESDeco",),
          ),
        ),
      ),
      body: Center(
        
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      quote,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontFamily: "PlaywriteESDeco",
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: generateQuote,
                child: const Text('Generate Quote'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[800],
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: "PlaywriteESDeco"
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite; // Inverse l'état du favori
          // Ajoutez ici votre logique pour gérer le favori
        });
      },
    ),
    const SizedBox(width: 20),
    ElevatedButton.icon(
      onPressed: () {
        Share.share(quote);
      },
      icon: const Icon(Icons.share),
      label: const Text('Share'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[800],
        onPrimary: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontFamily: "PlaywriteESDeco"
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  ],
),


        ]),
      ),
    ));
  }
}
