import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/core/theme_notifier.dart';
import 'package:chordy/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chordy/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

/// Global theme notifier — accessible from anywhere via ThemeNotifierScope
final ThemeNotifier themeNotifier = ThemeNotifier();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeNotifier,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chordy',
          themeMode: themeNotifier.themeMode,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          home: const MainPage(),
        );
      },
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Dark Theme
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ThemeData _buildDarkTheme() {
    const c = AppThemeColors.dark;
    final baseTextTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: c.background,
      textTheme: baseTextTheme,

      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryIndigo,
        secondary: AppColors.primaryPurple,
        tertiary: AppColors.primaryViolet,
        surface: c.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: c.textPrimary,
        onError: Colors.white,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: c.surface,
        foregroundColor: c.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w700,
          color: c.textPrimary, letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: c.textPrimary),
      ),

      navigationBarTheme: _buildNavBarTheme(c),
      floatingActionButtonTheme: _buildFabTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      inputDecorationTheme: _buildInputTheme(c),
      cardTheme: _buildCardTheme(c),
      dialogTheme: _buildDialogTheme(c),
      snackBarTheme: _buildSnackBarTheme(c),
      popupMenuTheme: _buildPopupMenuTheme(c),
      listTileTheme: ListTileThemeData(textColor: c.textPrimary, iconColor: c.textSecondary),
      switchTheme: _buildSwitchTheme(),
      dividerTheme: DividerThemeData(color: c.divider, thickness: 1, space: 0),
      chipTheme: _buildChipTheme(),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primaryIndigo),
      pageTransitionsTheme: _defaultPageTransitions(),
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Light Theme
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  ThemeData _buildLightTheme() {
    const c = AppThemeColors.light;
    final baseTextTheme = GoogleFonts.interTextTheme(ThemeData.light().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: c.background,
      textTheme: baseTextTheme,

      colorScheme: ColorScheme.light(
        primary: AppColors.primaryIndigo,
        secondary: AppColors.primaryPurple,
        tertiary: AppColors.primaryViolet,
        surface: c.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: c.textPrimary,
        onError: Colors.white,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: c.surface,
        foregroundColor: c.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w700,
          color: c.textPrimary, letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: c.textPrimary),
      ),

      navigationBarTheme: _buildNavBarTheme(c),
      floatingActionButtonTheme: _buildFabTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      inputDecorationTheme: _buildInputTheme(c),
      cardTheme: _buildCardTheme(c),
      dialogTheme: _buildDialogTheme(c),
      snackBarTheme: _buildSnackBarTheme(c),
      popupMenuTheme: _buildPopupMenuTheme(c),
      listTileTheme: ListTileThemeData(textColor: c.textPrimary, iconColor: c.textSecondary),
      switchTheme: _buildSwitchTheme(),
      dividerTheme: DividerThemeData(color: c.divider, thickness: 1, space: 0),
      chipTheme: _buildChipTheme(),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primaryIndigo),
      pageTransitionsTheme: _defaultPageTransitions(),
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Shared Component Themes
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  NavigationBarThemeData _buildNavBarTheme(AppThemeColors c) {
    return NavigationBarThemeData(
      backgroundColor: c.surface,
      indicatorColor: AppColors.primaryIndigo.withValues(alpha: 0.15),
      surfaceTintColor: Colors.transparent,
      labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryIndigo);
        }
        return GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: c.textMuted);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primaryIndigo, size: 26);
        }
        return IconThemeData(color: c.textMuted, size: 24);
      }),
    );
  }

  FloatingActionButtonThemeData _buildFabTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryIndigo,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryIndigo,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  InputDecorationTheme _buildInputTheme(AppThemeColors c) {
    return InputDecorationTheme(
      filled: true,
      fillColor: c.surfaceLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: c.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: c.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryIndigo, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.error)),
      hintStyle: TextStyle(color: c.textMuted),
    );
  }

  CardThemeData _buildCardTheme(AppThemeColors c) {
    return CardThemeData(
      color: c.cardDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: c.border.withValues(alpha: 0.3)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    );
  }

  DialogThemeData _buildDialogTheme(AppThemeColors c) {
    return DialogThemeData(
      backgroundColor: c.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      surfaceTintColor: Colors.transparent,
    );
  }

  SnackBarThemeData _buildSnackBarTheme(AppThemeColors c) {
    return SnackBarThemeData(
      backgroundColor: c.surfaceLight,
      contentTextStyle: GoogleFonts.inter(color: c.textPrimary, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
    );
  }

  PopupMenuThemeData _buildPopupMenuTheme(AppThemeColors c) {
    return PopupMenuThemeData(
      color: c.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      surfaceTintColor: Colors.transparent,
    );
  }

  SwitchThemeData _buildSwitchTheme() {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primaryIndigo;
        return const Color(0xFF8B949E);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primaryIndigo.withValues(alpha: 0.3);
        return const Color(0xFF30363D);
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    );
  }

  ChipThemeData _buildChipTheme() {
    return ChipThemeData(
      backgroundColor: AppColors.primaryIndigo.withValues(alpha: 0.15),
      labelStyle: GoogleFonts.inter(color: AppColors.primaryIndigo, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      side: BorderSide(color: AppColors.primaryIndigo.withValues(alpha: 0.3)),
    );
  }

  PageTransitionsTheme _defaultPageTransitions() {
    return const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    );
  }
}