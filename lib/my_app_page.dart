import 'package:flutter/material.dart';
import 'package:graficos/repositories/conta_repository.dart';
import 'package:graficos/repositories/favoritas_repository.dart';
import 'package:graficos/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'configs/app_settings.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ContaRepository()),
          ChangeNotifierProvider(create: (context) => AppSettings()),
          ChangeNotifierProvider(create: (context) => FavoritasRepository()),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            primaryColor: Colors.indigo,
          ),
          home: const HomePage(),
        )
    );
  }
}