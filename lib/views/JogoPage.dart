import 'package:contador/config.dart';
import 'package:contador/models/Jogado.dart';
import 'package:contador/telaJogo.dart';
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

  void onTapPlayer(Jogado player, OpcoesGame opt){
      setState(() {
        player.setJogada(opt);
      });
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
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: PageView(
        controller: controller,
        onPageChanged: updatePage,
        children: [
          Consumer<JogoController>(
            builder: (context, jogoController, _) {
              final jogador = jogoController.jogado2;

              if (jogador == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return TelaJogo(jogador: jogador,
                onTapPedra: () {
                  onTapPlayer(jogador, OpcoesGame.Pedra);
                  print("onTapPedra");
                } ,
                onTapPapel: () {
                  onTapPlayer(jogador, OpcoesGame.Papel);
                  print("onTapPapel");
                },
                onTapTesoura: () {
                  onTapPlayer(jogador, OpcoesGame.Tesoura);
                  print("onTapTesoura");
                }
              );
            },
          ),
          Consumer<JogoController>(
            builder: (context, jogoController, _) {
              final jogador = jogoController.jogado1;

              if (jogador == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return TelaJogo(jogador: jogador,
                  onTapPedra: () {
                    onTapPlayer(jogador, OpcoesGame.Pedra);
                    jogoController.VerificarGanhador(context);
                    print("onTapPedra");
                  } ,
                  onTapPapel: () {
                    onTapPlayer(jogador, OpcoesGame.Papel);
                    jogoController.VerificarGanhador(context);
                    print("onTapPapel");
                  },
                  onTapTesoura: () {
                    onTapPlayer(jogador, OpcoesGame.Tesoura);
                    jogoController.VerificarGanhador(context);
                    print("onTapTesoura");
                  }
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
