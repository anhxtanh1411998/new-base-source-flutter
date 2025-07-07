import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../widgets/ad_banner_widget.dart';
import '../widgets/ad_interstitial_helper.dart';
import '../widgets/ad_rewarded_helper.dart';
import '../widgets/custom_button.dart';

/// A page that demonstrates how to use AdMob ads.
class AdExamplePage extends StatefulWidget {
  /// Creates a new [AdExamplePage].
  const AdExamplePage({super.key});

  @override
  State<AdExamplePage> createState() => _AdExamplePageState();
}

class _AdExamplePageState extends State<AdExamplePage> {
  int _rewardPoints = 0;

  @override
  void initState() {
    super.initState();
    // Preload interstitial and rewarded ads
    AdInterstitialHelper.loadAd();
    AdRewardedHelper.loadAd();
  }

  @override
  void dispose() {
    // Dispose of ads when the page is disposed
    AdInterstitialHelper.dispose();
    AdRewardedHelper.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdMob Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'AdMob Integration Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Banner Ad
            const Text('Banner Ad Example:'),
            const SizedBox(height: 10),
            const AdBannerWidget(),
            const SizedBox(height: 20),
            
            // Interstitial Ad
            const Text('Interstitial Ad Example:'),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Show Interstitial Ad',
              onPressed: _showInterstitialAd,
            ),
            const SizedBox(height: 20),
            
            // Rewarded Ad
            const Text('Rewarded Ad Example:'),
            const SizedBox(height: 10),
            Text('Current Reward Points: $_rewardPoints'),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Show Rewarded Ad',
              onPressed: _showInterstitialAd,
            ),
          ],
        ),
      ),
      // Banner ad at the bottom of the screen
      bottomNavigationBar: const AdBannerWidget(
        adSize: AdSize.banner,
      ),
    );
  }

  Future<void> _showInterstitialAd() async {
    final currentContext = context;

    final shown = await AdInterstitialHelper.showAdIfAvailable();
    if (!shown) {
      if (!mounted) return;

      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(
          content: Text('Interstitial ad not ready yet. Try again later.'),
        ),
      );

      AdInterstitialHelper.loadAd();
    }
  }
}