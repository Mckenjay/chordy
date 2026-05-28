import 'package:flutter/material.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Theme-Aware Color Palette
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class AppThemeColors {
  final Color background;
  final Color surface;
  final Color surfaceLight;
  final Color cardDark;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color divider;

  const AppThemeColors({
    required this.background,
    required this.surface,
    required this.surfaceLight,
    required this.cardDark,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.divider,
  });

  static const dark = AppThemeColors(
    background: Color(0xFF0D1117),
    surface: Color(0xFF161B22),
    surfaceLight: Color(0xFF1C2333),
    cardDark: Color(0xFF1A1F2E),
    textPrimary: Color(0xFFF0F6FC),
    textSecondary: Color(0xFF8B949E),
    textMuted: Color(0xFF6E7681),
    border: Color(0xFF30363D),
    divider: Color(0xFF21262D),
  );

  static const light = AppThemeColors(
    background: Color(0xFFF6F8FA),
    surface: Color(0xFFFFFFFF),
    surfaceLight: Color(0xFFF0F2F5),
    cardDark: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF1F2328),
    textSecondary: Color(0xFF656D76),
    textMuted: Color(0xFF8B949E),
    border: Color(0xFFD0D7DE),
    divider: Color(0xFFD8DEE4),
  );
}

/// Extension for easy access: `context.colors`
extension AppThemeExtension on BuildContext {
  AppThemeColors get colors {
    return Theme.of(this).brightness == Brightness.dark
        ? AppThemeColors.dark
        : AppThemeColors.light;
  }

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Shared Accent Colors (same in both themes)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class AppColors {
  static const Color primaryIndigo = Color(0xFF6366F1);
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryViolet = Color(0xFFA855F7);
  static const Color success = Color(0xFF3FB950);
  static const Color error = Color(0xFFF85149);
  static const Color chordGreen = Color(0xFF7EE787);
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Gradients
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class AppGradients {
  static const LinearGradient primary = LinearGradient(
    colors: [AppColors.primaryIndigo, AppColors.primaryPurple, AppColors.primaryViolet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Returns a unique gradient per index for song tiles
  static LinearGradient songTile(int index) {
    const palettes = [
      [Color(0xFF6366F1), Color(0xFF818CF8)],
      [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
      [Color(0xFFA855F7), Color(0xFFC084FC)],
      [Color(0xFF7C3AED), Color(0xFF9F67FF)],
      [Color(0xFF6D28D9), Color(0xFF8B5CF6)],
      [Color(0xFF4F46E5), Color(0xFF6366F1)],
      [Color(0xFF7E22CE), Color(0xFFA855F7)],
      [Color(0xFF5B21B6), Color(0xFF7C3AED)],
    ];
    final palette = palettes[index % palettes.length];
    return LinearGradient(
      colors: palette,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Context-Aware Decorations
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class AppDecorations {
  static BoxDecoration glassBar(BuildContext context) {
    final c = context.colors;
    return BoxDecoration(
      color: c.surface.withValues(alpha: 0.92),
      border: Border(
        top: BorderSide(color: c.border.withValues(alpha: 0.3)),
      ),
    );
  }

  static BoxDecoration songCard(BuildContext context) {
    final c = context.colors;
    return BoxDecoration(
      color: c.cardDark,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: c.border.withValues(alpha: 0.2)),
    );
  }

  static BoxDecoration card(BuildContext context) {
    final c = context.colors;
    return BoxDecoration(
      color: c.cardDark,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: c.border.withValues(alpha: 0.3)),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Form Styles (context-aware)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

InputDecoration appInputDecoration(BuildContext context) {
  final c = context.colors;
  return InputDecoration(
    filled: true,
    fillColor: c.surfaceLight,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: c.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primaryIndigo, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    hintStyle: TextStyle(color: c.textMuted),
  );
}

TextStyle appLabelStyle(BuildContext context) {
  final c = context.colors;
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: c.textPrimary,
  );
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Musical Constants
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

const String defaultMusicalKey = 'F#';

const List<String> musicalKeys = [
  'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'
];

const Map<String, int> _musicalKeyAliases = {
  'C': 0,
  'B#': 0,
  'C#': 1,
  'DB': 1,
  'D': 2,
  'D#': 3,
  'EB': 3,
  'E': 4,
  'FB': 4,
  'F': 5,
  'E#': 5,
  'F#': 6,
  'GB': 6,
  'G': 7,
  'G#': 8,
  'AB': 8,
  'A': 9,
  'A#': 10,
  'BB': 10,
  'B': 11,
  'CB': 11,
};

int? musicalKeyIndex(String? value) {
  final key = value?.trim();
  if (key == null || key.isEmpty) return null;

  final match = RegExp(r'^([A-Ga-g])([#b]?)').firstMatch(key);
  if (match == null) return null;

  final root = '${match.group(1)!.toUpperCase()}${match.group(2) ?? ''}'.toUpperCase();
  return _musicalKeyAliases[root];
}

String? normalizeMusicalKey(String? value) {
  final index = musicalKeyIndex(value);
  return index == null ? null : musicalKeys[index];
}
