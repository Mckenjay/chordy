import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/main.dart';
import 'package:flutter/material.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final isDark = context.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 12),
              child: Text(
                'THEME',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: c.textMuted,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              decoration: AppDecorations.card(context),
              child: Column(
                children: [
                  // Theme mode selector
                  _ThemeOption(
                    icon: Icons.dark_mode_rounded,
                    label: 'Dark Mode',
                    subtitle: 'Easy on the eyes',
                    isSelected: isDark,
                    isTop: true,
                    onTap: () {
                      themeNotifier.setThemeMode(ThemeMode.dark);
                      setState(() {});
                    },
                  ),
                  Divider(height: 1, indent: 70, color: c.divider),
                  _ThemeOption(
                    icon: Icons.light_mode_rounded,
                    label: 'Light Mode',
                    subtitle: 'Classic bright look',
                    isSelected: !isDark,
                    isTop: false,
                    onTap: () {
                      themeNotifier.setThemeMode(ThemeMode.light);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool isSelected;
  final bool isTop;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.isTop,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryIndigo.withValues(alpha: 0.15)
              : c.surfaceLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primaryIndigo : c.textMuted,
          size: 20,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isTop ? 14 : 0),
          topRight: Radius.circular(isTop ? 14 : 0),
          bottomLeft: Radius.circular(isTop ? 0 : 14),
          bottomRight: Radius.circular(isTop ? 0 : 14),
        ),
      ),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.w500, color: c.textPrimary)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: c.textMuted)),
      trailing: isSelected
          ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryIndigo, size: 22)
          : Icon(Icons.circle_outlined, color: c.border, size: 22),
      onTap: onTap,
    );
  }
}