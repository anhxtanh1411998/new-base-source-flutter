import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/utils/ad_utils.dart';

/// A helper class for loading and showing rewarded ads.
class AdRewardedHelper {
  /// Private constructor to prevent instantiation
  AdRewardedHelper._();
  
  /// The rewarded ad instance.
  static RewardedAd? _rewardedAd;
  
  /// Whether an ad is currently being loaded.
  static bool _isLoading = false;

  /// Loads a rewarded ad if one is not already loaded or loading.
  static Future<void> loadAd() async {
    if (_rewardedAd != null || _isLoading) {
      return;
    }

    _isLoading = true;
    
    _rewardedAd = await AdUtils.loadRewardedAd(
      onAdLoaded: (ad) {
        _isLoading = false;
        
        // Set a callback for when the ad is closed
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _rewardedAd = null;
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            debugPrint('Failed to show rewarded ad: ${error.message}');
            ad.dispose();
            _rewardedAd = null;
          },
        );
      },
      onAdFailedToLoad: (error) {
        _isLoading = false;
        debugPrint('Failed to load rewarded ad: ${error.message}');
      },
    );
  }

  /// Shows the loaded rewarded ad if available.
  /// 
  /// Returns true if the ad was shown, false otherwise.
  /// The [onUserEarnedReward] callback is called when the user earns a reward.
  static Future<bool> showAdIfAvailable({
    required void Function(RewardItem reward) onUserEarnedReward,
  }) async {
    if (_rewardedAd == null) {
      await loadAd();
      return false;
    }

    try {
      await _rewardedAd!.show(onUserEarnedReward: (_, reward) => onUserEarnedReward(reward));
      return true;
    } catch (e) {
      debugPrint('Error showing rewarded ad: $e');
      _rewardedAd = null;
      return false;
    }
  }

  /// Disposes of the rewarded ad if one is loaded.
  static void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isLoading = false;
  }
}