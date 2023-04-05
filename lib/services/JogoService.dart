import 'package:flutter/material.dart';

import '../models/Jogado.dart';

class JogoService {

  Jogado? VerificarGanhador(Jogado jogado1, Jogado jogado2){

    debugPrint("VerificarGanhador");
    //caso empate retorna 0;
    if(jogado1.opcao == jogado2.opcao){
      return null;
    }

    if(jogado1.opcao == OpcoesGame.Pedra && jogado2.opcao == OpcoesGame.Tesoura
      || jogado1.opcao == OpcoesGame.Papel && jogado2.opcao == OpcoesGame.Pedra
      || jogado1.opcao == OpcoesGame.Tesoura && jogado2.opcao == OpcoesGame.Papel){
      return jogado1;
    }

    return jogado2;
  }

  //regra
/*
Pedra x Tesoura = Pedra
Papel x Pedra= Papel
Tesoura x Papel = Teroura
*/
}