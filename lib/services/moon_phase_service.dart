import 'dart:math' as math;

/// Moon Phase calculation service using synodic month algorithm
/// Simplified to 4 main phases for consistency with cosmic connection data

enum MoonPhase {
  newMoon,
  waxingMoon,
  fullMoon,
  waningMoon,
}

class MoonPhaseService {
  // Known new moon reference date (January 6, 2000 at 18:14 UTC)
  static final DateTime _referenceNewMoon = DateTime.utc(2000, 1, 6, 18, 14);
  
  // Synodic month length in days (average time between new moons)
  static const double _synodicMonth = 29.53058867;

  /// Calculate moon phase for a given date
  MoonPhase getMoonPhase(DateTime date) {
    final daysSinceReference = date.difference(_referenceNewMoon).inHours / 24.0;
    final lunarCycles = daysSinceReference / _synodicMonth;
    final currentCycleProgress = lunarCycles - lunarCycles.floor();
    
    // Convert progress (0-1) to 4 phases
    // 0.0 = New Moon, 0.25 = First Quarter (Waxing), 0.5 = Full Moon, 0.75 = Third Quarter (Waning)
    if (currentCycleProgress < 0.125) return MoonPhase.newMoon;
    if (currentCycleProgress < 0.5) return MoonPhase.waxingMoon;
    if (currentCycleProgress < 0.625) return MoonPhase.fullMoon;
    return MoonPhase.waningMoon;
  }

  /// Get moon illumination percentage (0.0 to 1.0)
  double getMoonIllumination(DateTime date) {
    final daysSinceReference = date.difference(_referenceNewMoon).inHours / 24.0;
    final lunarCycles = daysSinceReference / _synodicMonth;
    final currentCycleProgress = lunarCycles - lunarCycles.floor();
    
    // Illumination follows a sinusoidal pattern
    // 0 at new moon, 1 at full moon
    return (1 - math.cos(currentCycleProgress * 2 * math.pi)) / 2;
  }

  /// Check if moon is waxing (growing) or waning (shrinking)
  bool isWaxing(DateTime date) {
    final daysSinceReference = date.difference(_referenceNewMoon).inHours / 24.0;
    final lunarCycles = daysSinceReference / _synodicMonth;
    final currentCycleProgress = lunarCycles - lunarCycles.floor();
    return currentCycleProgress < 0.5;
  }

  /// Get phase key for localization lookup
  String getPhaseKey(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.newMoon: return 'moonPhaseNewMoon';
      case MoonPhase.waxingMoon: return 'moonPhaseWaxingMoon';
      case MoonPhase.fullMoon: return 'moonPhaseFullMoon';
      case MoonPhase.waningMoon: return 'moonPhaseWaningMoon';
    }
  }

  /// Get phase name in English (for API calls)
  String getPhaseNameEn(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.newMoon: return 'New Moon';
      case MoonPhase.waxingMoon: return 'Waxing Moon';
      case MoonPhase.fullMoon: return 'Full Moon';
      case MoonPhase.waningMoon: return 'Waning Moon';
    }
  }
}
