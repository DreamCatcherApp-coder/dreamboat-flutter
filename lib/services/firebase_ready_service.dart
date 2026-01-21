import 'dart:async';
import 'package:flutter/foundation.dart';

/// Service to track Firebase initialization status for splash screen optimization
class FirebaseReadyService {
  static final FirebaseReadyService _instance = FirebaseReadyService._internal();
  factory FirebaseReadyService() => _instance;
  FirebaseReadyService._internal();

  final Completer<void> _readyCompleter = Completer<void>();
  bool _isReady = false;

  /// Returns true if Firebase is initialized
  bool get isReady => _isReady;

  /// Future that completes when Firebase is ready
  Future<void> get ready => _readyCompleter.future;

  /// Mark Firebase as ready (called from main.dart after init)
  void markReady() {
    if (!_isReady) {
      _isReady = true;
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.complete();
      }
      debugPrint('=== FirebaseReadyService: Marked as ready ===');
    }
  }

  /// Wait for ready with timeout (fallback for slow networks)
  Future<void> waitWithTimeout({Duration timeout = const Duration(seconds: 3)}) async {
    try {
      await ready.timeout(timeout);
    } catch (e) {
      debugPrint('=== FirebaseReadyService: Timeout reached, continuing anyway ===');
    }
  }
}
