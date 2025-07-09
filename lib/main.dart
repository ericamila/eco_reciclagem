import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

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

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[100]!,
              Colors.green[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Logo animado
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/app_icon.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.green[600],
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.recycling,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),

                // Título com gradiente
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.green[800]!, Colors.green[600]!],
                  ).createShader(bounds),
                  child: const Text(
                    'EcoSort',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Jogo de Reciclagem Sustentável',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),

                // Card de descrição
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.eco,
                        size: 35,
                        color: Colors.green[600],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Aprenda sobre consumo responsável classificando itens para reciclagem!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            'ODS 12 - Consumo Responsável',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.green[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Botões
                Column(
                  children: [
                    // Botão principal
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green[600]!, Colors.green[700]!],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                              const TelaJogo(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return SlideTransition(
                                  position: animation.drive(
                                    Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                                  ),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow, color: Colors.white, size: 24),
                            SizedBox(width: 10),
                            Text(
                              'Iniciar Jogo',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Botão secundário
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          _mostrarInfoODS(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green[600],
                          side: BorderSide(color: Colors.green[600]!, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'Sobre ODS 12',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarInfoODS(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.eco, color: Colors.green[600], size: 30),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'ODS 12 - Consumo e Produção Responsável',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'O Objetivo de Desenvolvimento Sustentável 12 visa assegurar padrões de produção e de consumo sustentáveis.',
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '♻️ A reciclagem é uma das principais formas de reduzir o desperdício e promover o uso eficiente dos recursos naturais.',
                  style: TextStyle(fontSize: 13, height: 1.4),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Neste jogo, você aprenderá a classificar diferentes tipos de materiais para a reciclagem adequada!',
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Entendi',
                style: TextStyle(
                  color: Colors.green[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TelaJogo extends StatefulWidget {
  const TelaJogo({super.key});

  @override
  State<TelaJogo> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> with TickerProviderStateMixin {
  int pontuacao = 0;
  int itemAtual = 0;
  late AnimationController _itemAnimationController;
  late Animation<double> _itemAnimation;

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

  // Categorias de reciclagem com cores melhoradas
  final List<Map<String, dynamic>> categorias = [
    {'nome': 'Plástico', 'cor': Colors.red[600], 'icone': Icons.local_drink, 'descricao': 'Garrafas, sacolas'},
    {'nome': 'Papel', 'cor': Colors.blue[600], 'icone': Icons.description, 'descricao': 'Jornais, revistas'},
    {'nome': 'Metal', 'cor': Colors.yellow[700], 'icone': Icons.build_circle, 'descricao': 'Latas, tampas'},
    {'nome': 'Orgânico', 'cor': Colors.brown[600], 'icone': Icons.eco, 'descricao': 'Restos de comida'},
    {'nome': 'Vidro', 'cor': Colors.green[600], 'icone': Icons.wine_bar, 'descricao': 'Garrafas, copos'},
  ];

  @override
  void initState() {
    super.initState();
    _itemAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _itemAnimation = CurvedAnimation(
      parent: _itemAnimationController,
      curve: Curves.elasticOut,
    );
    _itemAnimationController.forward();

    // Embaralhar itens para variedade
    itens.shuffle(Random());
  }

  @override
  void dispose() {
    _itemAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (itemAtual >= itens.length) {
      return _telaFinal();
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[100]!,
              Colors.green[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar customizada
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.green[700]),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'EcoSort',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                          Text(
                            'Item ${itemAtual + 1} de ${itens.length}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber[400]!, Colors.amber[600]!],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 16),
                          const SizedBox(width: 5),
                          Text(
                            '$pontuacao',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Barra de progresso
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: itemAtual / itens.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
                    minHeight: 6,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Item atual
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Card do item
                      AnimatedBuilder(
                        animation: _itemAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _itemAnimation.value,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Imagem do item
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.asset(
                                      itens[itemAtual]['imagem'],
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.recycling,
                                          size: 60,
                                          color: Colors.green[600],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    itens[itemAtual]['nome'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    itens[itemAtual]['dica'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Onde este item deve ser descartado?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[800],
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Grid de categorias
                      Expanded(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: categorias.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _verificarResposta(categorias[index]['nome']),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      categorias[index]['cor'],
                                      categorias[index]['cor'].withOpacity(0.8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: categorias[index]['cor'].withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      categorias[index]['icone'],
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      categorias[index]['nome'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      categorias[index]['descricao'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verificarResposta(String categoriaEscolhida) {
    bool acertou = categoriaEscolhida == itens[itemAtual]['categoria'];

    if (acertou) {
      setState(() {
        pontuacao += 10;
      });
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.heavyImpact();
    }

    _mostrarFeedback(acertou, categoriaEscolhida);
  }

  void _mostrarFeedback(bool acertou, String categoriaEscolhida) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: acertou ? Colors.green[100] : Colors.red[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  acertou ? Icons.check_circle : Icons.cancel,
                  color: acertou ? Colors.green[600] : Colors.red[600],
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  acertou ? 'Parabéns!' : 'Ops!',
                  style: TextStyle(
                    color: acertou ? Colors.green[600] : Colors.red[600],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                acertou
                    ? 'Você classificou corretamente o item! 🎉'
                    : 'Não foi dessa vez, mas continue tentando! 💪',
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
              if (!acertou) ...[
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categoria correta: ${itens[itemAtual]['categoria']}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Você escolheu: $categoriaEscolhida',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (acertou) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.add, color: Colors.green[600], size: 16),
                    const SizedBox(width: 5),
                    Text(
                      '+10 pontos',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    itemAtual++;
                    _itemAnimationController.reset();
                    _itemAnimationController.forward();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  itemAtual + 1 >= itens.length ? 'Ver Resultado' : 'Próximo Item',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _telaFinal() {
    double porcentagemAcertos = (pontuacao / (itens.length * 10)) * 100;
    String mensagem = '';
    IconData icone = Icons.emoji_events;
    Color corMensagem = Colors.green;

    if (porcentagemAcertos >= 80) {
      mensagem = 'Excelente! Você é um expert em reciclagem! 🌟';
      icone = Icons.emoji_events;
      corMensagem = Colors.amber[600]!;
    } else if (porcentagemAcertos >= 60) {
      mensagem = 'Muito bem! Você está no caminho certo! 👏';
      icone = Icons.thumb_up;
      corMensagem = Colors.green[600]!;
    } else {
      mensagem = 'Continue praticando! A prática leva à perfeição! 💪';
      icone = Icons.school;
      corMensagem = Colors.blue[600]!;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[100]!,
              Colors.green[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Ícone de conquista
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: corMensagem.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icone,
                    size: 50,
                    color: corMensagem,
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  'Jogo Concluído!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 15),

                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: corMensagem,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),

                // Card de resultados
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Seus Resultados',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatCard('Pontuação', '$pontuacao', Icons.star, Colors.amber),
                          _buildStatCard('Acertos', '${porcentagemAcertos.toStringAsFixed(0)}%', Icons.check_circle, Colors.green),
                          _buildStatCard('Itens', '${itens.length}', Icons.recycling, Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Mensagem educativa
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.eco, color: Colors.green[600], size: 25),
                      const SizedBox(height: 10),
                      const Text(
                        'Continue praticando a reciclagem no dia a dia!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Cada pequena ação faz a diferença para o planeta 🌍',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Botões de ação
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pontuacao = 0;
                            itemAtual = 0;
                            itens.shuffle(Random());
                            _itemAnimationController.reset();
                            _itemAnimationController.forward();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'Jogar Novamente',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green[600],
                          side: BorderSide(color: Colors.green[600]!, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'Menu Principal',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, MaterialColor color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color[600], size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color[600],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

