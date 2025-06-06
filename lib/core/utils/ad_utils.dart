import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// A utility class for managing Google AdMob ads in the application.
class AdUtils {
  /// Private constructor to prevent instantiation
  AdUtils._();

  /// Initialize the AdMob SDK
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
    
    // Enable test mode for debugging
    if (kDebugMode) {
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: ['kGADSimulatorID']),
      );
    }
  }

  /// Test ad unit IDs for development
  /// Replace these with your actual ad unit IDs in production
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Android test banner ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS test banner ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Android test interstitial ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // iOS test interstitial ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; // Android test rewarded ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // iOS test rewarded ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  /// Create a banner ad
  static BannerAd createBannerAd({
    AdSize size = AdSize.banner,
    void Function(Ad ad)? onAdLoaded,
    void Function(Ad ad, LoadAdError error)? onAdFailedToLoad,
  }) {
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
  }

  /// Load an interstitial ad
  static Future<InterstitialAd?> loadInterstitialAd({
    void Function(InterstitialAd ad)? onAdLoaded,
    void Function(LoadAdError error)? onAdFailedToLoad,
  }) async {
    InterstitialAd? interstitialAd;
    
    try {
      await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            if (onAdLoaded != null) onAdLoaded(ad);
          },
          onAdFailedToLoad: (error) {
            if (onAdFailedToLoad != null) onAdFailedToLoad(error);
          },
        ),
      );
    } catch (e) {
      debugPrint('Error loading interstitial ad: $e');
    }
    
    return interstitialAd;
  }

  /// Load a rewarded ad
  static Future<RewardedAd?> loadRewardedAd({
    void Function(RewardedAd ad)? onAdLoaded,
    void Function(LoadAdError error)? onAdFailedToLoad,
  }) async {
    RewardedAd? rewardedAd;
    
    try {
      await RewardedAd.load(
        adUnitId: rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            rewardedAd = ad;
            if (onAdLoaded != null) onAdLoaded(ad);
          },
          onAdFailedToLoad: (error) {
            if (onAdFailedToLoad != null) onAdFailedToLoad(error);
          },
        ),
      );
    } catch (e) {
      debugPrint('Error loading rewarded ad: $e');
    }
    
    return rewardedAd;
  }
}