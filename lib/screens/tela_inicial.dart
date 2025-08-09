import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_reciclagem/screens/tela_jogo.dart';

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
        height: MediaQuery.of(context).size.height,
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
              mainAxisSize: MainAxisSize.max,
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
                              color: Colors.green.withValues(alpha: 0.3),
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
                        color: Colors.grey.withValues(alpha: 0.3),
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
                            color: Colors.green.withValues(alpha: 0.3),
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
          backgroundColor: Colors.white,
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
