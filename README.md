# Carteira de Criptomoedas - exibindo gráfico.

<p>Aplicativo desenvolvido em Flutter e com banco de dados SQLite - banco interno do Android.</p>
<p>O projeto simula uma carteira digital de criptomoedas e a medida que se vai comprando criptomoedas, é possível ver a quantidade de cada uma em forma de gráfico. <br />Foi utilizada a biblioteca fl_chart para a criação de gráficos. Foi também utilizado Provider para comunicação das atualizações de compra, inserção de dinheiro, adição de favoritos. Nas classes onde as manipulações de dados acontecem, usei ChangeNotifier e a função notifyListeners() para enviar as informações atualizadas para os ouvintes.</p>
<p>
 O banco de dados SQLite contem as tabelas Conta, Carteira e Histórico. Para salvar as moedas favoritas, usei a biblioteca Hive, um banco de dados NoSql que usa o formato de chave-valor, que tem a proposta de ser leve e extremamente rápido. Assim, tive a oportunidade de aprender sobre dois bancos de dados: o SQLite e o Hive. 
</p>
<p>
Com o Hive, utilizei LazyBoxes para salvar, buscar e deletar as moedas favoritas. Com LazyBoxes, os valores não ficam salvos na memória. Cada vez que um valor é lido, ele é carregado do back-end.
</p>

![ima2ge899](https://user-images.githubusercontent.com/9465347/174937572-e1cda899-d79e-4ccd-9e18-a8967e26ba06.png)
