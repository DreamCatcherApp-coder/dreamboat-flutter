import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for handling biometric authentication for Dream Journal
class BiometricService {
  static final LocalAuthentication _auth = LocalAuthentication();
  
  static const String _journalLockKey = 'journal_lock_enabled';
  static const String _promptShownKey = 'biometric_prompt_shown';

  static DateTime? _lastAuthTime;
  
  /// Check if authentication happened very recently (prevents loops)
  static bool get recentlyAuthenticated => 
      _lastAuthTime != null && 
      DateTime.now().difference(_lastAuthTime!) < const Duration(seconds: 3);

  /// Check if device has biometric capability
  static Future<bool> isBiometricAvailable() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      return canCheck || isSupported;
    } catch (e) {
      debugPrint('Biometric check error: $e');
      return false;
    }
  }

  /// Authenticate user with biometrics
  /// Returns true if authentication successful, false otherwise
  static Future<bool> authenticate(String localizedReason) async {
    try {
      final isAvailable = await isBiometricAvailable();
      if (!isAvailable) return false;

      final authenticated = await _auth.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(
          stickyAuth: true,
          // Android: allow PIN/pattern fallback
          // iOS: biometric only (Apple policy)
          biometricOnly: Platform.isIOS,
        ),
      );
      
      if (authenticated) {
        _lastAuthTime = DateTime.now();
      }
      
      return authenticated;
    } catch (e) {
      debugPrint('Authentication error: $e');
      return false;
    }
  }

  /// Check if journal lock is enabled
  static Future<bool> isJournalLockEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_journalLockKey) ?? false;
  }

  /// Set journal lock enabled/disabled
  static Future<void> setJournalLockEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_journalLockKey, enabled);
  }

  /// Check if biometric prompt has been shown before
  static Future<bool> hasShownBiometricPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_promptShownKey) ?? false;
  }

  /// Mark biometric prompt as shown
  static Future<void> setShownBiometricPrompt() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_promptShownKey, true);
  }

  /// Get available biometric types (for UI display)
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('Get biometrics error: $e');
      return [];
    }
  }
}
