import 'package:chordy/pages/settings/abouts.dart';
import 'package:chordy/pages/settings/appearance.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_outlined)
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text("Appearances"),
            onTap: () => Navigator.push(
              context, PageRouteBuilder(
                pageBuilder: (_, _, _) => const Appearance(),
                transitionsBuilder: (_, a, _, c) => Stack(
                  children: [
                    SlideTransition(
                      position: Tween(
                      begin: Offset.zero,
                      end: const Offset(-1, 0)
                      ).animate(a),
                      child: context.widget,
                    ),
                    SlideTransition(
                      position: Tween(
                      begin: const Offset(1, 0),
                      end: Offset.zero
                      ).animate(a),
                      child: c,
                    ),
                  ],
                )
              )
            )
          ),
          ListTile(
            leading: const Icon(Icons.info_outlined),
            title: const Text("About"),
            onTap: () => Navigator.push(
              context, PageRouteBuilder(
                pageBuilder: (_, _, _) => const Abouts(),
                transitionsBuilder: (_, a, _, c) => Stack(
                  children: [
                    SlideTransition(
                      position: Tween(
                      begin: Offset.zero,
                      end: const Offset(-1, 0)
                      ).animate(a),
                      child: context.widget,
                    ),
                    SlideTransition(
                      position: Tween(
                      begin: const Offset(1, 0),
                      end: Offset.zero
                      ).animate(a),
                      child: c,
                    ),
                  ],
                )
              )
            )
          ),
        ],
      ),
    );
  }
}