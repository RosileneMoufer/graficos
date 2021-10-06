import 'package:flutter/material.dart';
import 'package:graficos/screens/settings_page.dart';

import 'carteira_page.dart';
import 'favoritas_page.dart';
import 'moedas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentPage;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _currentPage = 0;
    _pageController = PageController(initialPage: _currentPage);
  }

  setCurrentPage(page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          MoedasPage(),
          FavoritasPage(),
          CarteiraPage(),
          const SettingsPage(),
        ],
        onPageChanged: setCurrentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Carteira'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
        ],
        onTap: (page) {
          _pageController.animateToPage(
              page,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease
          );
        },
      ),
    );
  }
}