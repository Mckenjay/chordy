import 'package:flutter/material.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Search',
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        PopupMenuButton<Text>(
          tooltip: 'More options',
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: const Text('Settings'),
                child: const Text('Settings'),
                onTap: () {},
              ),
              PopupMenuItem(
                value: const Text('About'),
                child: const Text('About Chordy'),
                onTap: () {},
              ),
            ];
          },
        ),
      ],
    );
  }
}