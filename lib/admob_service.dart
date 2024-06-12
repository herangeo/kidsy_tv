import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{
  static String? get bannerAdunitId {
    if (Platform.isAndroid)
    {
      return 'ca-app-pub-1001110363789350/4596215270';
    }
    else if(Platform.isIOS)
    {
      return 'ca-app-pub-1001110363789350/7769173524';
    }

    return null;
  }

    static String? get interstitialAdUnitId {
    if (Platform.isAndroid)
    {
      return 'ca-app-pub-1001110363789350/4596215270';
    }
    else if(Platform.isIOS)
    {
      return 'ca-app-pub-1001110363789350/7769173524';
    }

    return null;
  }

      static String? get rewardedUnitId {
    if (Platform.isAndroid)
    {
      return 'ca-app-pub-1001110363789350/4596215270';
    }
    else if(Platform.isIOS)
    {
      return 'ca-app-pub-1001110363789350/7769173524';
    }

    return null;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded'),
    onAdFailedToLoad: (ad, error) => {
      ad.dispose(),
      debugPrint('Ad failed to load: $error')
    },
    onAdClosed: (ad) => debugPrint('Ad Closed'),
    onAdOpened: (ad) => debugPrint('Ad Opened'),
  );

  static void initialize() {
    MobileAds.instance.initialize();
    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
        testDeviceIds: ['E2F4F10C314A8CB4B82EB452AAC9076D'],
      ),
    );
  }

}