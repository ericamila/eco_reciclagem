import 'package:flutter/material.dart';
import 'package:jogo_reciclagem/screens/tela_inicial.dart';

void main() {
  runApp(const JogoReciclagemApp());
}

class JogoReciclagemApp extends StatelessWidget {
  const JogoReciclagemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoSort - Jogo de Reciclagem',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const TelaInicial(),
    );
  }
}
