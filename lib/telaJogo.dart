import 'package:contador/models/Jogado.dart';
import 'package:flutter/material.dart';
import 'config.dart';

class TelaJogo extends StatefulWidget {
  TelaJogo(
      {Key? key,
      required this.jogador,
      required this.onTapPedra,
      required this.onTapPapel,
      required this.onTapTesoura})
      : super(key: key);

  final Jogado jogador;
  void Function() onTapPedra;
  void Function() onTapPapel;
  void Function() onTapTesoura;

  @override
  State<StatefulWidget> createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {
  Image? ResouverIcone(OpcoesGame? opcao) {
    debugPrint('opcao ${opcao}');

    if (opcao == null) return null;

    if (opcao == OpcoesGame.Pedra) return Image.asset(imagemPedra);

    if (opcao == OpcoesGame.Papel) return Image.asset(imagemPapel);

    if (opcao == OpcoesGame.Tesoura) return Image.asset(imagemTesoura);
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.jogador;

    if (player == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                '${player.name}',
                style: const TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Ponto(s): ${player.score}"),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Column(
              children: [
                ResouverIcone(player.opcao) ?? Image.asset(imagemLogoJogo),
                Text(
                  "${player.opcao ?? ''}",
                  style: const TextStyle(fontSize: 20.0),
                )
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              child: Image.asset(imagemPedra),
              onTap: widget.onTapPedra,
            ),
            GestureDetector(
              child: Image.asset(imagemPapel),
              onTap: widget.onTapPapel,
            ),
            GestureDetector(
              child: Image.asset(imagemTesoura),
              onTap: widget.onTapTesoura,
            ),
          ],
        )
      ],
    );
  }
}
