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

  IconData? ResouverIcone(OpcoesGame? opcao) {
    debugPrint('opcao ${opcao}');

    if (opcao == null) return null;

    if (opcao == OpcoesGame.Pedra) return Icons.beach_access;

    if (opcao == OpcoesGame.Papel) return Icons.pan_tool;

    if (opcao == OpcoesGame.Tesoura) return Icons.pan_tool_alt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo Pedra, Papel e Tesoura.'),
        actions: [
          IconButton(
            onPressed: () => { },
            icon: const Icon(Icons.fact_check_outlined),
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        onPageChanged: updatePage,
        children: [
          Consumer<JogoController>(
            builder: (context, controller, _) {
              final jogador1 = controller.jogado1;

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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: Column(children: [
                      Icon(
                        ResouverIcone(jogador1.opcao),
                        color: Colors.black,
                        size: 120.0,
                      ),
                      Text("${jogador1.opcao ?? ''}",
                        style: TextStyle(fontSize: 20.0),
                      )
                    ],)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.beach_access,
                          color: Colors.blue,
                          size: 36.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        onPressed: () => {
                          setState(() {
                            jogador1.setJogada(OpcoesGame.Pedra);
                          }),
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.pan_tool,
                          color: Colors.blue,
                          size: 36.0,
                        ),
                        onPressed: () => {
                          setState(() {
                            jogador1.setJogada(OpcoesGame.Papel);
                          }),
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.pan_tool_alt,
                          color: Colors.blue,
                          size: 36.0,
                        ),
                        onPressed: () => {
                          setState(() {
                            jogador1.setJogada(OpcoesGame.Tesoura);
                          }),
                        },
                      ),
                    ],
                  )
                ],
              );
            },
          ),
          Consumer<JogoController>(
            builder: (context, controller, _) {
              final jogador2 = controller.jogado2;

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
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 80),
                      child: Column(children: [
                        Icon(
                          ResouverIcone(jogador2.opcao),
                          color: Colors.black,
                          size: 120.0,
                        ),
                        Text("${jogador2.opcao ?? ''}",
                          style: TextStyle(fontSize: 20.0),
                        )
                      ],)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.beach_access,
                          color: Colors.blue,
                          size: 36.0,
                          semanticLabel:
                          'Text to announce in accessibility modes',
                        ),
                        onPressed: () => {
                          setState(() {
                            jogador2.setJogada(OpcoesGame.Pedra);
                          }),
                        controller.VerificarGanhador(),
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.pan_tool,
                          color: Colors.blue,
                          size: 36.0,
                        ),
                        onPressed: () => {
                          setState(() {
                            jogador2.setJogada(OpcoesGame.Papel);
                          }),
                          controller.VerificarGanhador(),
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.pan_tool_alt,
                          color: Colors.blue,
                          size: 36.0,
                        ),
                        onPressed: () => {
                          setState(() {
                            jogador2.setJogada(OpcoesGame.Tesoura);
                          }),
                          controller.VerificarGanhador(),
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
