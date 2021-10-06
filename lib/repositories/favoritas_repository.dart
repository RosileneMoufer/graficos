import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:graficos/adapters/moeda_hive_adapter.dart';
import 'package:graficos/models/coin.dart';
import 'package:hive/hive.dart';

class FavoritasRepository extends ChangeNotifier {
  final List<Coin> _lista = [];
  late LazyBox box;

  FavoritasRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(MoedaHiveAdapter());
    box = await Hive.openLazyBox<Coin>('moedas_favoritas');
  }

  _readFavoritas() {
    box.keys.forEach((moeda) async {
      Coin m = await box.get(moeda);
      _lista.add(m);
      notifyListeners();
    });
  }

  UnmodifiableListView<Coin> get lista => UnmodifiableListView(_lista);

  saveAll(List<Coin> coins) {
    for (var coin in coins) {
      if (!_lista.any((atual) => atual.sigla == coin.sigla)) {
        _lista.add(coin);
        box.put(coin.sigla, coin);
      }
    }
    notifyListeners();
  }

  remove(Coin coin) {
    _lista.remove(coin);
    box.delete(coin.sigla);
    notifyListeners();
  }
}
