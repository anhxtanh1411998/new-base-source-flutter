import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/utils/ad_utils.dart';

/// A helper class for loading and showing interstitial ads.
class AdInterstitialHelper {
  /// Private constructor to prevent instantiation
  AdInterstitialHelper._();
  
  /// The interstitial ad instance.
  static InterstitialAd? _interstitialAd;
  
  /// Whether an ad is currently being loaded.
  static bool _isLoading = false;

  /// Loads an interstitial ad if one is not already loaded or loading.
  static Future<void> loadAd() async {
    if (_interstitialAd != null || _isLoading) {
      return;
    }

    _isLoading = true;
    
    _interstitialAd = await AdUtils.loadInterstitialAd(
      onAdLoaded: (ad) {
        _isLoading = false;
        
        // Set a callback for when the ad is closed
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _interstitialAd = null;
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            debugPrint('Failed to show interstitial ad: ${error.message}');
            ad.dispose();
            _interstitialAd = null;
          },
        );
      },
      onAdFailedToLoad: (error) {
        _isLoading = false;
        debugPrint('Failed to load interstitial ad: ${error.message}');
      },
    );
  }

  /// Shows the loaded interstitial ad if available.
  /// 
  /// Returns true if the ad was shown, false otherwise.
  static Future<bool> showAdIfAvailable() async {
    if (_interstitialAd == null) {
      await loadAd();
      return false;
    }

    try {
      await _interstitialAd!.show();
      return true;
    } catch (e) {
      debugPrint('Error showing interstitial ad: $e');
      _interstitialAd = null;
      return false;
    }
  }

  /// Disposes of the interstitial ad if one is loaded.
  static void dispose() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isLoading = false;
  }
}