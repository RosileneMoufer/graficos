import 'package:graficos/models/coin.dart';
import 'package:hive/hive.dart';

class MoedaHiveAdapter extends TypeAdapter<Coin> {
  @override
  final typeId = 0;

  @override
  Coin read(BinaryReader reader) {
    return Coin(
      icone: reader.readString(),
      nome: reader.readString(),
      sigla: reader.readString(),
      preco: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Coin coin) {
    writer.writeString(coin.icone);
    writer.writeString(coin.nome);
    writer.writeString(coin.sigla);
    writer.writeDouble(coin.preco);
  }
}
