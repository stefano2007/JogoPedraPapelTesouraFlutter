import 'package:contador/config.dart';
import 'package:contador/models/Jogado.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:contador/controllers/JogoController.dart';

class JogoPage extends StatefulWidget {
  const JogoPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<JogoPage> createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> {
  late PageController controller;
  ValueNotifier<int> page = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    page.dispose();
    controller.dispose();
    super.dispose();
  }

  updatePage(int newPage) {
    page.value = newPage;
  }

  changePage(int newPage) {
    controller.animateToPage(
      newPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  Image? ResouverIcone(OpcoesGame? opcao) {
    debugPrint('opcao ${opcao}');

    if (opcao == null) return null;

    if (opcao == OpcoesGame.Pedra) return Image.asset(imagemPedra);

    if (opcao == OpcoesGame.Papel) return Image.asset(imagemPapel);

    if (opcao == OpcoesGame.Tesoura) return Image.asset(imagemTesoura);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo Pedra, Papel e Tesoura.'),
        actions: [
          IconButton(
            onPressed: () => {

            },
            icon: const Icon(Icons.fact_check_outlined),
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        onPageChanged: updatePage,
        children: [
          Consumer<JogoController>(
            builder: (context, jogoController, _) {
              final jogador1 = jogoController.jogado1;

              if (jogador1 == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Play 1: ${jogador1.name}',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Text("Ponto(s): ${jogador1.score}"),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: Column(children: [
                      ResouverIcone(jogador1.opcao) ?? Image.asset(imagemLogoJogo),
                      Text("${jogador1.opcao ?? ''}",
                        style: TextStyle(fontSize: 20.0),
                      )
                    ],)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        child: Image.asset(imagemPedra),
                        onTap: () => {
                          setState(() {
                            jogador1.setJogada(OpcoesGame.Pedra);
                          }),
                          changePage(1),
                        },
                      ),
                      GestureDetector(
                        child: Image.asset(imagemPapel),
                        onTap: () => {
                          setState(() {
                            jogador1.setJogada(OpcoesGame.Papel);
                          }),
                          changePage(1),
                        },
                      ),
                      GestureDetector(
                        child: Image.asset(imagemTesoura),
                        onTap: () => {
                          setState(() {
                            jogador1.setJogada(OpcoesGame.Tesoura);
                          }),
                          changePage(1),
                        },
                      ),
                    ],
                  )
                ],
              );
            },
          ),
          Consumer<JogoController>(
            builder: (context, jogoController, _) {
              final jogador2 = jogoController.jogado2;

              if (jogador2 == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Play 2: ${jogador2.name}',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Text("Ponto(s): ${jogador2.score}"),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 80),
                      child: Column(children: [
                        ResouverIcone(jogador2.opcao) ?? Image.asset(imagemLogoJogo),
                        Text("${jogador2.opcao ?? ''}",
                          style: TextStyle(fontSize: 20.0),
                        )
                      ],)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        child: Image.asset(imagemPedra),
                        onTap: () => {
                          setState(() {
                            jogador2.setJogada(OpcoesGame.Pedra);
                          }),
                          jogoController.VerificarGanhador(context),
                          changePage(0),
                        },
                      ),
                      GestureDetector(
                        child: Image.asset(imagemPapel),
                        onTap: () => {
                          setState(() {
                            jogador2.setJogada(OpcoesGame.Papel);
                          }),
                          jogoController.VerificarGanhador(context),
                          changePage(0),
                        },
                      ),
                      GestureDetector(
                        child: Image.asset(imagemTesoura),
                        onTap: () => {
                          setState(() {
                            jogador2.setJogada(OpcoesGame.Tesoura);
                          }),
                          jogoController.VerificarGanhador(context),
                          changePage(0),
                        },
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: page,
          builder: (context, paginaAtual, _) {
            return NavigationBar(
              onDestinationSelected: (value) => changePage(value),
              selectedIndex: paginaAtual,
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.person_pin), label: 'Play 1'),
                NavigationDestination(
                    icon: Icon(Icons.person_pin), label: 'Play 2'),
              ],
            );
          }),
    );
  }
}
