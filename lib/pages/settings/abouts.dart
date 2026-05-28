import 'package:chordy/core/styles/styles.dart';
import 'package:flutter/material.dart';

class Abouts extends StatelessWidget {
  const Abouts({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.pop(context)),
        title: const Text('About'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Avatar with gradient ring
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primary,
                boxShadow: [BoxShadow(color: AppColors.primaryIndigo.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 2)],
              ),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(shape: BoxShape.circle, color: c.background),
                child: const CircleAvatar(
                  radius: 60,
                  foregroundImage: NetworkImage("https://avatars.githubusercontent.com/Mckenjay"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Gradient app name
            ShaderMask(
              shaderCallback: (bounds) => AppGradients.primary.createShader(bounds),
              child: const Text('CHORDY', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 4, color: Colors.white)),
            ),
            const SizedBox(height: 8),
            Chip(label: const Text('v0.0.1'), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
            const SizedBox(height: 16),
            Text('Created by', style: TextStyle(fontSize: 13, color: c.textMuted)),
            const SizedBox(height: 4),
            Text('Mckenjay', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: c.textPrimary)),
          ],
        ),
      ),
    );
  }
}