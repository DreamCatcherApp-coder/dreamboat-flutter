import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dream_boat_mobile/main.dart';
import 'package:dream_boat_mobile/l10n/app_localizations.dart';

/// A premium bottom sheet for selecting app language with modern bluish design
class LanguageSelectorModal extends StatefulWidget {
  const LanguageSelectorModal({super.key});

  @override
  State<LanguageSelectorModal> createState() => _LanguageSelectorModalState();
}

class _LanguageSelectorModalState extends State<LanguageSelectorModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // Premium bluish color palette
  static const _primaryBlue = Color(0xFF60A5FA);
  static const _accentBlue = Color(0xFF3B82F6);
  static const _deepBlue = Color(0xFF1E3A5F);
  static const _darkBlue = Color(0xFF0A1628);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    final languages = [
      {'code': 'tr', 'name': 'Türkçe', 'flag': '🇹🇷'},
      {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
      {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
      {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
      {'code': 'pt', 'name': 'Português', 'flag': '🇵🇹'},
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _deepBlue.withOpacity(0.95),
                _darkBlue.withOpacity(0.98),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: _primaryBlue.withOpacity(0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _accentBlue.withOpacity(0.1),
                blurRadius: 30,
                spreadRadius: -5,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Premium handle bar with glow
              Container(
                margin: const EdgeInsets.only(top: 14),
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _primaryBlue.withOpacity(0.4),
                      _accentBlue.withOpacity(0.6),
                      _primaryBlue.withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: _primaryBlue.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Title with gradient
              FadeTransition(
                opacity: _fadeAnimation,
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [_primaryBlue, const Color(0xFF93C5FD)],
                  ).createShader(bounds),
                  child: Text(
                    AppLocalizations.of(context)!.settingsLanguage,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Language options with staggered animation
              ...languages.asMap().entries.map((entry) {
                final index = entry.key;
                final lang = entry.value;
                final isSelected = currentLocale.languageCode == lang['code'];

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 300 + (index * 60)),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: _buildLanguageOption(lang, isSelected),
                );
              }),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(Map<String, String> lang, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            MyApp.setLocale(context, Locale(lang['code'] as String));
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: _primaryBlue.withOpacity(0.15),
          highlightColor: _primaryBlue.withOpacity(0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _accentBlue.withOpacity(0.25),
                        _primaryBlue.withOpacity(0.15),
                      ],
                    )
                  : null,
              color: isSelected ? null : Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? _primaryBlue.withOpacity(0.5)
                    : Colors.white.withOpacity(0.08),
                width: isSelected ? 1.5 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: _primaryBlue.withOpacity(0.15),
                        blurRadius: 12,
                        spreadRadius: -2,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                // Flag with container
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      lang['flag'] as String,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Language name
                Expanded(
                  child: Text(
                    lang['name'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                // Checkmark with glow effect
                if (isSelected)
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_accentBlue, _primaryBlue],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: _primaryBlue.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: -1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      LucideIcons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
