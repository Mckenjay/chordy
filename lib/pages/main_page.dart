import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/pages/home.dart';
import 'package:chordy/pages/library.dart';
import 'package:chordy/pages/search.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;

  final List<Widget> pages = [
    HomePage(),
    LibraryPage()
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: KeyedSubtree(key: ValueKey<int>(currentPage), child: pages[currentPage]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: c.surface,
          border: Border(top: BorderSide(color: c.border.withValues(alpha: 0.3))),
        ),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search_rounded), selectedIcon: Icon(Icons.search_rounded), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.library_music_outlined), selectedIcon: Icon(Icons.library_music_rounded), label: 'Library'),
          ],
          selectedIndex: currentPage == 0 ? 0 : 2,
          onDestinationSelected: (value) {
            if (value == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage()));
            } else {
              setState(() { currentPage = value == 0 ? 0 : 1; });
            }
          },
        ),
      ),
    );
  }
}
