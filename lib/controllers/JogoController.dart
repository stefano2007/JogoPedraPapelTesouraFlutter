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
  void VerificarGanhador(){
    Jogado? Ganhado = service.VerificarGanhador(jogado1, jogado2);
    if(Ganhado != null){
      Ganhado.incrementScore();
      notifyListeners();
      debugPrint('Jogador ${Ganhado.name} ganhou!');
    }else{
      debugPrint('Empatou!');
    }
  }
}