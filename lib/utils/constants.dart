import 'package:flutter/material.dart';

// Lista expandida de itens para classificar
final List<Map<String, dynamic>> itens = [
  {'nome': 'Garrafa PET', 'categoria': 'Plástico', 'imagem': 'assets/images/plastic_bottle.png', 'dica': 'Material plástico transparente'},
  {'nome': 'Jornal', 'categoria': 'Papel', 'imagem': 'assets/images/newspaper.png', 'dica': 'Material de papel impresso'},
  {'nome': 'Lata de Alumínio', 'categoria': 'Metal', 'imagem': 'assets/images/aluminum_can.png', 'dica': 'Material metálico leve'},
  {'nome': 'Casca de Banana', 'categoria': 'Orgânico', 'imagem': 'assets/images/banana_peel.png', 'dica': 'Resto de alimento natural'},
  {'nome': 'Garrafa de Vidro', 'categoria': 'Vidro', 'imagem': 'assets/images/glass_bottle.png', 'dica': 'Material transparente e frágil'},
  {'nome': 'Revista', 'categoria': 'Papel', 'imagem': 'assets/images/newspaper.png', 'dica': 'Material de papel colorido'},
  {'nome': 'Sacola Plástica', 'categoria': 'Plástico', 'imagem': 'assets/images/plastic_bottle.png', 'dica': 'Material plástico flexível'},
  {'nome': 'Resto de Comida', 'categoria': 'Orgânico', 'imagem': 'assets/images/banana_peel.png', 'dica': 'Sobras de alimentos'},
  {'nome': 'Lata de Conserva', 'categoria': 'Metal', 'imagem': 'assets/images/aluminum_can.png', 'dica': 'Embalagem metálica de alimentos'},
  {'nome': 'Copo de Vidro', 'categoria': 'Vidro', 'imagem': 'assets/images/glass_bottle.png', 'dica': 'Utensílio de vidro transparente'},
];

// Categorias de reciclagem
final List<Map<String, dynamic>> categorias = [
  {'nome': 'Plástico', 'cor': Colors.red[600], 'icone': Icons.local_drink, 'descricao': 'Garrafas, sacolas'},
  {'nome': 'Papel', 'cor': Colors.blue[600], 'icone': Icons.description, 'descricao': 'Jornais, revistas'},
  {'nome': 'Metal', 'cor': Colors.yellow[700], 'icone': Icons.build_circle, 'descricao': 'Latas, tampas'},
  {'nome': 'Orgânico', 'cor': Colors.brown[600], 'icone': Icons.eco, 'descricao': 'Restos de comida'},
  {'nome': 'Vidro', 'cor': Colors.green[600], 'icone': Icons.wine_bar, 'descricao': 'Garrafas, copos'},
];