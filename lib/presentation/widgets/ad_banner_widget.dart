import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/utils/ad_utils.dart';

/// A widget that displays a banner ad.
class AdBannerWidget extends StatefulWidget {
  /// The size of the banner ad.
  final AdSize adSize;

  /// Creates a new [AdBannerWidget].
  const AdBannerWidget({
    super.key,
    this.adSize = AdSize.banner,
  });

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  /// The banner ad instance.
  BannerAd? _bannerAd;
  
  /// Whether the ad has been loaded.
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  /// Loads a banner ad.
  void _loadBannerAd() {
    _bannerAd = AdUtils.createBannerAd(
      size: widget.adSize,
      onAdLoaded: (ad) {
        setState(() {
          _isAdLoaded = true;
        });
      },
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        debugPrint('Ad failed to load: ${error.message}');
      },
    );

    _bannerAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd == null || !_isAdLoaded) {
      return SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      alignment: Alignment.center,
      child: AdWidget(ad: _bannerAd!),
    );
  }
}