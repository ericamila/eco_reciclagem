import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import '../utils/constants.dart';
import '../widgets/stat_card.dart';

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
  late List<Map<String, dynamic>> _itensDoQuiz;
  late Timer _timer;
  int _countdown = 10;

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

    _iniciarQuiz();
  }

  void _iniciarQuiz() {
    // Seleciona 10 itens aleatórios
    itens.shuffle(Random());
    _itensDoQuiz = itens.take(10).toList();
    itemAtual = 0;
    pontuacao = 0;
    _startTimer();
    _itemAnimationController.forward();
  }

  void _startTimer() {
    _countdown = 10; // Reseta o tempo para cada item
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          _verificarResposta('Tempo Esgotado'); // Resposta incorreta por tempo
        }
      });
    });
  }

  @override
  void dispose() {
    _itemAnimationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (itemAtual >= _itensDoQuiz.length) {
      _timer.cancel(); // Garante que o timer seja cancelado ao final do jogo
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
                            'Item ${itemAtual + 1} de ${_itensDoQuiz.length}',
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
                    value: itemAtual / _itensDoQuiz.length,
                    backgroundColor: Colors.blueGrey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
                    minHeight: 6,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Temporizador
              Text(
                'Tempo: $_countdown s',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _countdown <= 5 ? Colors.red : Colors.green[700],
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
                                    color: Colors.grey.withValues(alpha: 0.3),
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
                                      _itensDoQuiz[itemAtual]['imagem'],
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
                                    _itensDoQuiz[itemAtual]['nome'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    _itensDoQuiz[itemAtual]['dica'],
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
    _timer.cancel(); // Para o timer quando uma resposta é dada
    bool acertou = categoriaEscolhida == _itensDoQuiz[itemAtual]['categoria'];

    if (acertou) {
      setState(() {
        pontuacao += 10;
      });
      HapticFeedback.lightImpact();
    } else if (categoriaEscolhida != 'Tempo Esgotado') { // Não penaliza duas vezes por tempo esgotado
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
                    : categoriaEscolhida == 'Tempo Esgotado'
                    ? 'O tempo esgotou! Tente ser mais rápido na próxima. ⏱️'
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
                        'Categoria correta: ${_itensDoQuiz[itemAtual]['categoria']}',
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
                    if (itemAtual < _itensDoQuiz.length) {
                      _startTimer(); // Inicia o timer para o próximo item
                      _itemAnimationController.reset();
                      _itemAnimationController.forward();
                    }
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
                  itemAtual + 1 >= _itensDoQuiz.length ? 'Ver Resultado' : 'Próximo Item',
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
    double porcentagemAcertos = (pontuacao / (_itensDoQuiz.length * 10)) * 100;
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
                    color: corMensagem.withValues(alpha: 0.3),
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
                        color: Colors.grey.withValues(alpha: 0.3),
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
                          buildStatCard('Pontuação', '$pontuacao', Icons.star, Colors.amber),
                          buildStatCard('Acertos', '${porcentagemAcertos.toStringAsFixed(0)}%', Icons.check_circle, Colors.green),
                          buildStatCard('Itens', '${_itensDoQuiz.length}', Icons.recycling, Colors.blue),
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
                            _iniciarQuiz(); // Reinicia o quiz
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
}
