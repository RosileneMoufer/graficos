import 'package:flutter/material.dart';
import 'package:graficos/database/database.dart';
import 'package:graficos/models/coin.dart';
import 'package:graficos/models/historico.dart';
import 'package:graficos/models/position.dart';
import 'package:sqflite/sqlite_api.dart';

import 'moeda_repository.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Position> _carteira = [];
  List<Historico> _historico = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Position> get carteira => _carteira;
  List<Historico> get historico => _historico;

  ContaRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
    await _getCarteira();
    await _getHistorico();
  }

  _getHistorico() async {
    _historico = [];
    List operacoes = await db.query('historico');
    for (var operacao in operacoes) {
      Coin coin = MoedaRepository.tabela.firstWhere(
        (m) => m.sigla == operacao['sigla'],
      );
      _historico.add(Historico(
        dataOperacao: DateTime.fromMillisecondsSinceEpoch(operacao['data_operacao']),
        tipoOperacao: operacao['tipo_operacao'],
        coin: coin,
        valor: operacao['valor'],
        quantidade: double.parse(operacao['quantidade']),
      ));
    }
    notifyListeners();
  }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];

    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;

    notifyListeners();
  }

  _getCarteira() async {
    _carteira = [];
    List posicoes = await db.query('carteira');
    for (var posicao in posicoes) {
      Coin coin = MoedaRepository.tabela.firstWhere(
        (m) => m.sigla == posicao['sigla'],
      );
      _carteira.add(Position(
        coin: coin,
        quantidade: double.parse(posicao['quantidade']),
      ));
    }
    notifyListeners();
  }

  comprar(Coin coin, double valor) async {
    db = await DB.instance.database;

    await db.transaction((_transaction) async {
      // Verificar se a moeda já foi comprada
      final posicaoMoeda = await _transaction.query(
        'carteira',
        where: 'sigla = ?',
        whereArgs: [coin.sigla],
      );
      // Se não tem a moeda ainda, insert
      if (posicaoMoeda.isEmpty) {
        await _transaction.insert('carteira', {
          'sigla': coin.sigla,
          'moeda': coin.nome,
          'quantidade': (valor / coin.preco).toString()
        });
      } else {
        final atual = double.parse(posicaoMoeda.first['quantidade'].toString());
        await _transaction.update(
          'carteira',
          {'quantidade': ((valor / coin.preco) + atual).toString()},
          where: 'sigla = ?',
          whereArgs: [coin.sigla],
        );
      }

      // Inserir o histórico
      await _transaction.insert('historico', {
        'sigla': coin.sigla,
        'moeda': coin.nome,
        'quantidade': (valor / coin.preco).toString(),
        'valor': valor,
        'tipo_operacao': 'compra',
        'data_operacao': DateTime.now().millisecondsSinceEpoch
      });

      await _transaction.update('conta', {'saldo': saldo - valor});
    });

    await _initRepository();
    notifyListeners();
  }
}
