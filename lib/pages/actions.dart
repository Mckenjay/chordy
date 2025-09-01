import 'package:chordy/pages/abouts.dart';
import 'package:flutter/material.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Account',
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Abouts())),
        ),
        const SizedBox(width: 8,),
      ],
    );
  }
}