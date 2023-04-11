import 'package:contador/models/Jogado.dart';
import 'package:contador/services/JogoService.dart';
import 'package:flutter/material.dart';

class JogoController extends ChangeNotifier{
  Jogado jogado1 = Jogado(id: 1,name: "Jogador 1");
  Jogado jogado2 = Jogado(id: 2, name: "Jogador 2");

  JogoService service;
  JogoController({required this.service });

  void JogaPlay1(OpcoesGame opcao){
    jogado1.setJogada(opcao);
    notifyListeners();
  }
  void JogaPlay2(OpcoesGame opcao){
    jogado2.setJogada(opcao);
    notifyListeners();
  }
  void VerificarGanhador(BuildContext context){

    if(jogado1.opcao == null || jogado2.opcao == null){
      mostraMensagem('Um ou mais pendente de jogar', context);
      return;
    }

    Jogado? Ganhado = service.VerificarGanhador(jogado1, jogado2);
    if(Ganhado != null){
      Ganhado.incrementScore();
      mostraMensagem('${Ganhado.name} ganhou!', context);
    }else{
      mostraMensagem('Empatou!', context);
    }

    jogado1.opcao = null;
    jogado2.opcao = null;
    notifyListeners();
  }

  void mostraMensagem(String mensagem, BuildContext context){
    debugPrint(mensagem);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }
}