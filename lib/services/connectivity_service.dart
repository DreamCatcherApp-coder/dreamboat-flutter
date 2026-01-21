import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';

/// Service to check internet connectivity.
/// Uses multiple endpoints to ensure actual internet access,
/// works globally including regions where Google is blocked.
class ConnectivityService {
  
  // Multiple endpoints for global availability
  static const List<String> _endpoints = [
    'google.com',      // Primary - works in most regions
    'cloudflare.com',  // Fallback - works in China and blocked regions
    '1.1.1.1',         // Cloudflare DNS IP - direct IP fallback
  ];
  
  /// Checks if the device has internet access.
  /// Tries multiple endpoints for global compatibility.
  /// Returns `true` if connected, `false` otherwise.
  static Future<bool> get isConnected async {
    for (final endpoint in _endpoints) {
      try {
        final result = await InternetAddress.lookup(endpoint)
            .timeout(const Duration(seconds: 3));
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          debugPrint('ConnectivityService: Connected via $endpoint');
          return true;
        }
      } on SocketException catch (_) {
        debugPrint('ConnectivityService: $endpoint failed (SocketException)');
        continue; // Try next endpoint
      } on TimeoutException catch (_) {
        debugPrint('ConnectivityService: $endpoint failed (Timeout)');
        continue; // Try next endpoint
      } catch (e) {
        debugPrint('ConnectivityService: $endpoint failed ($e)');
        continue; // Try next endpoint
      }
    }
    
    // All endpoints failed
    debugPrint('ConnectivityService: All endpoints failed - no internet');
    return false;
  }
}
