import 'package:flutter/material.dart';

// Lista expandida de itens para classificar
final List<Map<String, dynamic>> itens = [
  {'nome': 'Garrafa PET', 'categoria': 'Plástico', 'imagem': 'assets/images/plastic_bottle.png', 'dica': 'Material plástico transparente'},
  {'nome': 'Jornal', 'categoria': 'Papel', 'imagem': 'assets/images/newspaper.png', 'dica': 'Material de papel impresso'},
  {'nome': 'Lata de Alumínio', 'categoria': 'Metal', 'imagem': 'assets/images/tin_can.png', 'dica': 'Material metálico leve'},
  {'nome': 'Casca de Banana', 'categoria': 'Orgânico', 'imagem': 'assets/images/banana_peel.png', 'dica': 'Resto de alimento natural'},
  {'nome': 'Garrafa de Vidro', 'categoria': 'Vidro', 'imagem': 'assets/images/glass_bottle.png', 'dica': 'Material transparente e frágil'},
  {'nome': 'Revista', 'categoria': 'Papel', 'imagem': 'assets/images/magazine.png', 'dica': 'Material de papel colorido'},
  {'nome': 'Sacola Plástica', 'categoria': 'Plástico', 'imagem': 'assets/images/plastic_bag.png', 'dica': 'Material plástico flexível'},
  {'nome': 'Resto de Comida', 'categoria': 'Orgânico', 'imagem': 'assets/images/apple_core.png', 'dica': 'Sobras de alimentos'},
  {'nome': 'Lata de Conserva', 'categoria': 'Metal', 'imagem': 'assets/images/tin_can.png', 'dica': 'Embalagem metálica de alimentos'},
  {'nome': 'Copo de Vidro', 'categoria': 'Vidro', 'imagem': 'assets/images/glass_cup.png', 'dica': 'Utensílio de vidro transparente'},
  {'nome': 'Caixa de Papelão', 'categoria': 'Papel', 'imagem': 'assets/images/cardboard_box.png', 'dica': 'Embalagem de papel'},
  {'nome': 'Garrafa de Plástico', 'categoria': 'Plástico', 'imagem': 'assets/images/plastic_bottle.png', 'dica': 'Garrafa de plástico'},
  {'nome': 'Lata de Refrigerante', 'categoria': 'Metal', 'imagem': 'assets/images/aluminum_can.png', 'dica': 'Lata de bebida'},
  {'nome': 'Folha Seca', 'categoria': 'Orgânico', 'imagem': 'assets/images/dry_leaf.png', 'dica': 'Resíduo vegetal'},
  {'nome': 'Pote de Vidro', 'categoria': 'Vidro', 'imagem': 'assets/images/glass_jar.png', 'dica': 'Pote de vidro'},
  {'nome': 'Caixa de Leite', 'categoria': 'Papel', 'imagem': 'assets/images/milk_carton.png', 'dica': 'Embalagem de papel revestido'},
  {'nome': 'Garrafa de Vinho', 'categoria': 'Vidro', 'imagem': 'assets/images/wine_bottle.png', 'dica': 'Garrafa de vidro para bebidas'},
  {'nome': 'Pilha', 'categoria': 'Pilhas e Baretias', 'imagem': 'assets/images/battery.png', 'dica': 'Fonte de energia metálica'},
  {'nome': 'Embalagem de Alimentos', 'categoria': 'Plástico', 'imagem': 'assets/images/food_packaging_plastic.png', 'dica': 'Embalagem plástica de alimentos'},
  {'nome': 'Restos de Pão', 'categoria': 'Orgânico', 'imagem': 'assets/images/bread_crust.png', 'dica': 'Sobras de pão'},

  {'nome': 'Restos de Comida Cozida', 'categoria': 'Orgânico', 'imagem': 'assets/images/cooked_food_scraps.png', 'dica': 'Sobras de refeições'},
  {'nome': 'Caixa de Sapatos', 'categoria': 'Papel', 'imagem': 'assets/images/shoe_box.png', 'dica': 'Embalagem de papel para calçados'},
  {'nome': 'Tampa de Plástico', 'categoria': 'Plástico', 'imagem': 'assets/images/plastic_lid.png', 'dica': 'Tampa de garrafa ou pote'},
  {'nome': 'Bateria de Carro', 'categoria': 'Pilhas e Baretias', 'imagem': 'assets/images/car_battery.png', 'dica': 'Fonte de energia automotiva'},
  {'nome': 'Embalagem Tetra Pak', 'categoria': 'Papel', 'imagem': 'assets/images/tetra_pak.png', 'dica': 'Embalagem de papel revestido'},
  {'nome': 'Lata de Sopa', 'categoria': 'Metal', 'imagem': 'assets/images/soup_can.png', 'dica': 'Embalagem metálica de sopa'},
  {'nome': 'Caixa de Cereais', 'categoria': 'Papel', 'imagem': 'assets/images/cereal_box.png', 'dica': 'Embalagem de papel para cereais'},
  {'nome': 'Resto de Verduras', 'categoria': 'Orgânico', 'imagem': 'assets/images/vegetable_scraps.png', 'dica': 'Sobras de vegetais'},
  {'nome': 'Embalagem Plástica de Iogurte', 'categoria': 'Plástico', 'imagem': 'assets/images/yogurt_packaging.png', 'dica': 'Embalagem plástica de iogurte'},

];

// Categorias de reciclagem
final List<Map<String, dynamic>> categorias = [
  {'nome': 'Plástico', 'cor': Colors.red[600], 'icone': Icons.local_drink, 'descricao': 'Garrafas, sacolas'},
  {'nome': 'Papel', 'cor': Colors.blue[600], 'icone': Icons.description, 'descricao': 'Jornais, revistas'},
  {'nome': 'Metal', 'cor': Colors.yellow[700], 'icone': Icons.build_circle, 'descricao': 'Latas, tampas'},
  {'nome': 'Orgânico', 'cor': Colors.brown[600], 'icone': Icons.eco, 'descricao': 'Restos de comida'},
  {'nome': 'Vidro', 'cor': Colors.green[600], 'icone': Icons.wine_bar, 'descricao': 'Garrafas, copos'},
  {'nome': 'Pilhas e Baretias', 'cor': Colors.orange[600], 'icone': Icons.battery_alert, 'descricao': 'Pilhas, baterias'},
  //{'nome': 'Outros', 'cor': Colors.grey[600], 'icone': Icons.help, 'descricao': 'Itens não recicláveis'},
];