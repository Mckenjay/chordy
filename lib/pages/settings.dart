import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/pages/settings/abouts.dart';
import 'package:chordy/pages/settings/appearance.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text('PREFERENCES', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c.textMuted, letterSpacing: 1.2)),
          ),
          Container(
            decoration: AppDecorations.card(context),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(color: AppColors.primaryPurple.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.palette_outlined, color: AppColors.primaryPurple, size: 20),
                  ),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
                  title: Text('Appearance', style: TextStyle(fontWeight: FontWeight.w500, color: c.textPrimary)),
                  trailing: Icon(Icons.chevron_right_rounded, color: c.textMuted, size: 20),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Appearance())),
                ),
                Divider(height: 1, indent: 70, color: c.divider),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(color: AppColors.primaryIndigo.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.info_outline_rounded, color: AppColors.primaryIndigo, size: 20),
                  ),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(14), bottomRight: Radius.circular(14))),
                  title: Text('About', style: TextStyle(fontWeight: FontWeight.w500, color: c.textPrimary)),
                  trailing: Icon(Icons.chevron_right_rounded, color: c.textMuted, size: 20),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Abouts())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}