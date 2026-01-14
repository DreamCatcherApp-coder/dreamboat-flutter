
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:dream_boat_mobile/l10n/app_localizations.dart';
import 'package:dream_boat_mobile/widgets/gradient_text.dart';
import 'package:dream_boat_mobile/widgets/custom_button.dart';

class MoodSelectionSheet extends StatefulWidget {
  final Function(String mood, List<String> secondaryMoods, int intensity, int vividness) onSave;

  const MoodSelectionSheet({super.key, required this.onSave});

  @override
  State<MoodSelectionSheet> createState() => _MoodSelectionSheetState();
}

class _MoodSelectionSheetState extends State<MoodSelectionSheet> {
  String? _selectedMood;
  int _intensity = 2; // Medium default
  int _vividness = 2; // Medium default
  List<String> _secondaryMoods = [];
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    
    final moods = [
        {'key': 'awe', 'label': t.moodAwe, 'icon': LucideIcons.sparkles, 'color': const Color(0xFFC084FC)},
        {'key': 'love', 'label': t.moodLove, 'icon': LucideIcons.heart, 'color': const Color(0xFFEC4899)},
        {'key': 'happy', 'label': t.moodHappy, 'icon': LucideIcons.smile, 'color': const Color(0xFFFBBF24)},
        {'key': 'empowered', 'label': t.moodEmpowered, 'icon': LucideIcons.zap, 'color': const Color(0xFFF43F5E)},
        {'key': 'longing', 'label': t.moodLonging, 'icon': LucideIcons.hourglass, 'color': const Color(0xFF38BDF8)},
        {'key': 'neutral', 'label': t.moodNeutral, 'icon': LucideIcons.meh, 'color': const Color(0xFF9CA3AF)},
        {'key': 'confusion', 'label': t.moodConfusion, 'icon': LucideIcons.helpCircle, 'color': const Color(0xFF2DD4BF)},
        {'key': 'anxiety', 'label': t.moodAnxiety, 'icon': LucideIcons.activity, 'color': const Color(0xFFFB923C)},
        {'key': 'sad', 'label': t.moodSad, 'icon': LucideIcons.cloudRain, 'color': const Color(0xFF60A5FA)},
        {'key': 'scared', 'label': t.moodScared, 'icon': LucideIcons.ghost, 'color': const Color(0xFF8B5CF6)},
        {'key': 'anger', 'label': t.moodAnger, 'icon': LucideIcons.flame, 'color': const Color(0xFFEF4444)},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F23).withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: SingleChildScrollView(
          child: Padding(
             // Bottom padding for safe area
            padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 // Drag Handle
                 Center(
                   child: Container(
                     width: 40, height: 4,
                     decoration: BoxDecoration(
                       color: Colors.white.withOpacity(0.2),
                       borderRadius: BorderRadius.circular(2)
                     ),
                   ),
                 ),
                 const SizedBox(height: 24),
                 
                 // Vividness Slider Section
                 Text(
                   t.moodVividnessQuestion,
                   style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                   textAlign: TextAlign.center,
                 ),
                 const SizedBox(height: 12),
                 Slider( // Simplified Custom Slider could be better, but standard for now
                   value: _vividness.toDouble(),
                   min: 1, max: 3, divisions: 2,
                   activeColor: const Color(0xFFA78BFA),
                   inactiveColor: Colors.white.withOpacity(0.1),
                   label: _vividness == 1 ? t.moodVividnessLow : (_vividness == 2 ? t.moodVividnessMedium : t.moodVividnessHigh),
                   onChanged: (v) => setState(() => _vividness = v.round()),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(t.moodVividnessLow, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
                     Text(t.moodVividnessHigh, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
                   ],
                 ),
                 const SizedBox(height: 32),

                 // Mood Prompt
                 GradientText(
                   t.moodSelectPrompt,
                   textAlign: TextAlign.center,
                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                   gradient: const LinearGradient(colors: [Colors.white, Color(0xFFE0E7FF)]),
                 ),
                 const SizedBox(height: 24),

                 // Mood Grid
                 Wrap(
                   spacing: 12,
                   runSpacing: 12,
                   alignment: WrapAlignment.center,
                   children: moods.map((m) {
                     final isSelected = _selectedMood == m['key'];
                     final color = m['color'] as Color;
                     
                     return GestureDetector(
                       onTap: () {
                         setState(() {
                           if (_selectedMood == m['key']) {
                              // Deselect? No, maybe just ignore or toggle secondary?
                              // For now, let's keep it simple: Select
                           } else {
                             _selectedMood = m['key'] as String;
                           }
                         });
                       },
                       child: AnimatedContainer(
                         duration: const Duration(milliseconds: 300),
                         curve: Curves.easeOutCubic, // Changed from easeOutBack to prevent negative shadow blur
                         padding: EdgeInsets.symmetric(
                           horizontal: isSelected ? 20 : 16, 
                           vertical: isSelected ? 16 : 12
                         ),
                       decoration: BoxDecoration(
                         color: isSelected ? color.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                         borderRadius: BorderRadius.circular(20),
                         border: Border.all(
                           color: isSelected ? color : Colors.white.withOpacity(0.1),
                           width: isSelected ? 2 : 1
                         ),
                         boxShadow: isSelected ? [
                           BoxShadow(color: color.withOpacity(0.4), blurRadius: 15, spreadRadius: 1)
                         ] : [],
                       ),
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Icon(m['icon'] as IconData, color: isSelected ? Colors.white : color, size: 24),
                           const SizedBox(height: 8),
                           Text(
                             m['label'] as String,
                             style: TextStyle(
                               color: isSelected ? Colors.white : Colors.white70,
                               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                               fontSize: 12
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
                 }).toList(),
               ),
               
               // Intensity Slider (Only if mood selected)
               AnimatedSize(
                 duration: const Duration(milliseconds: 300),
                 child: _selectedMood != null ? Column(
                   children: [
                     const SizedBox(height: 32),
                     Text(
                       t.moodIntensityLabel,
                       style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                     ),
                     const SizedBox(height: 8),
                     Slider(
                        value: _intensity.toDouble(),
                        min: 1, max: 3, divisions: 2,
                        activeColor:  moods.firstWhere((m) => m['key'] == _selectedMood)['color'] as Color,
                        inactiveColor: Colors.white.withOpacity(0.1),
                        label: _intensity == 1 ? t.moodIntensityLow : (_intensity == 2 ? t.moodIntensityMedium : t.moodIntensityHigh),
                        onChanged: (v) => setState(() => _intensity = v.round()),
                     ),
                      Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(t.moodIntensityLow, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
                         Text(t.moodIntensityHigh, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
                       ],
                     ),
                     const SizedBox(height: 24),
                     // Save Button
                     SizedBox(
                       width: double.infinity,
                       child: CustomButton(
                         text: t.newDreamSave, // Reuse or "Continue"
                         onPressed: () {
                           if (_selectedMood != null) {
                             widget.onSave(_selectedMood!, _secondaryMoods, _intensity, _vividness);
                             Navigator.pop(context);
                           }
                         },
                         gradient: LinearGradient(
                           colors: [
                             moods.firstWhere((m) => m['key'] == _selectedMood)['color'] as Color,
                             (moods.firstWhere((m) => m['key'] == _selectedMood)['color'] as Color).withOpacity(0.7)
                           ],
                         ),
                       ),
                     ),
                   ],
                 ) : const SizedBox.shrink(),
               ),
               
               if (_selectedMood == null) ...[
                 const SizedBox(height: 32),
                 TextButton(
                   onPressed: () {
                      widget.onSave('neutral', [], 1, _vividness);
                      Navigator.pop(context);
                   },
                   child: Text(t.moodNotSure, style: TextStyle(color: Colors.white.withOpacity(0.4))),
                 ),
               ],
               
               const SizedBox(height: 20), // Bottom SafeArea buffer
            ],
          ),
        ),
      ),
      ),
    );
  }
}
