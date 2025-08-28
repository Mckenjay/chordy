import 'package:chordy/pages/home.dart';
import 'package:chordy/pages/library.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentPage = 0;

  final List<Widget> pages = const [
    HomePage(),
    LibraryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // labelTextStyle: WidgetStateTextStyle.resolveWith(
          //   (states) => const TextStyle(color: Colors.blue)
          // ),
          // iconTheme: WidgetStateProperty.resolveWith(
          //   (states) => const IconThemeData(color: Colors.blue)
          // )
        ), 
        child: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home'
            ),
            NavigationDestination(
              icon: Icon(Icons.folder_outlined),
              selectedIcon: Icon(Icons.folder),
              label: 'Library'
            )
          ],
          selectedIndex: currentPage,
          onDestinationSelected: (value) {
            setState(() {
              currentPage = value;
            });
          },
        ),
      ),
    );
  }
}

