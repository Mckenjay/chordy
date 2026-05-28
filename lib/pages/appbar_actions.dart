import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/pages/settings.dart';
import 'package:chordy/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Conditional import: chooses the web version only when compiling for web.
import 'package:chordy/services/google_button_stub.dart'
    if (dart.library.html) 'package:chordy/services/google_button_web.dart'
    as web;

class AppBarActions extends StatefulWidget {
  const AppBarActions({super.key});

  @override
  State<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends State<AppBarActions> {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(
      children: [
        IconButton(
          tooltip: 'Account',
          icon: Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
              color: c.surfaceLight, shape: BoxShape.circle,
              border: Border.all(color: c.border.withValues(alpha: 0.5)),
            ),
            child: Icon(Icons.person_outline_rounded, size: 18, color: c.textSecondary),
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              alignment: const Alignment(0.0, -0.8),
              backgroundColor: c.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              width: 28, height: 28,
                              decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(7)),
                              child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 16),
                            ),
                            const SizedBox(width: 10),
                            Text('Chordy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.textPrimary)),
                          ]),
                          Material(
                            color: c.surfaceLight, borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 32, height: 32,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: c.border.withValues(alpha: 0.3))),
                                child: Icon(Icons.close_rounded, size: 16, color: c.textSecondary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Login card
                    Container(
                      decoration: AppDecorations.card(context),
                      child: kIsWeb
                          ? web.renderGoogleButton()
                          : ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              leading: Container(
                                width: 38, height: 38,
                                decoration: BoxDecoration(color: AppColors.primaryIndigo.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.login_rounded, color: AppColors.primaryIndigo, size: 20),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              title: Text("Sign in", style: TextStyle(fontWeight: FontWeight.w600, color: c.textPrimary)),
                              subtitle: Text("Sign in with Google", style: TextStyle(fontSize: 12, color: c.textMuted)),
                              trailing: Icon(Icons.chevron_right_rounded, color: c.textMuted),
                              onTap: () {},
                            ),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: c.divider),
                    const SizedBox(height: 6),
                    // Settings
                    Container(
                      decoration: AppDecorations.card(context),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        leading: Icon(Icons.settings_outlined, color: c.textSecondary, size: 22),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.w500, color: c.textPrimary)),
                        trailing: Icon(Icons.chevron_right_rounded, color: c.textMuted, size: 20),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}