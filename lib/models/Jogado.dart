import 'package:flutter/material.dart';

class Jogado {
  int id;
  String name;
  int _score = 0;
  OpcoesGame? opcao;

  int get score => _score;

  void incrementScore() {
    _score++;
  }

  setJogada(OpcoesGame op){
    this.opcao = op;
    debugPrint('setJogada: ${op}');
  }

  Jogado({
    required this.id,
    required this.name,
    this.opcao,
  });
}
enum OpcoesGame {
  Pedra,
  Papel,
  Tesoura
}