
import 'package:graficos/models/coin.dart';

class Historico {
  DateTime dataOperacao;
  String tipoOperacao;
  Coin coin;
  double valor;
  double quantidade;

  Historico({
    required this.dataOperacao,
    required this.tipoOperacao,
    required this.coin,
    required this.valor,
    required this.quantidade,
  });
}
