import 'package:flutter/material.dart';
import 'package:rick_morty_practice/presentation/pages/characters_page.dart'; // Tu "Search" actual
import 'package:rick_morty_practice/presentation/pages/favorites_page.dart';
import 'package:rick_morty_practice/presentation/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Lista de pantallas
  final List<Widget> _pages = [
    const HomePage(), // Index 0
    const CharactersPage(), // Index 1 (Tu buscador actual)
    const FavoritesPage(), // Index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // IndexedStack mantiene el estado de las páginas (no recarga al cambiar tab)
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
