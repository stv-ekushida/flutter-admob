import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  /// バナー広告（テスト用）
  static String get topBannerAdIUnitID => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  /// インタースティシャル広告（テスト用）
  static final String interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  static InterstitialAd _interstitialAd;

  /// 初期化
  static initialize() {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
  }

  /// バナー広告の作成
  static BannerAd createBannerAd({
    AdSize adSize,
    String adUnitId,
    Function(Ad ad) onAdLoaded,
    Function(Ad ad, LoadAdError error) onAdFailedToLoad,
    Function(Ad ad) onAdOpened,
    Function(Ad ad) onAdClosed,
  }) {
    BannerAd ad = BannerAd(
      size: adSize,
      adUnitId: adUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
        onAdOpened: onAdOpened,
        onAdClosed: onAdClosed,
      ),
    );
    return ad;
  }

  static InterstitialAd createInterstitialAd(
      void Function() onAdClosed,
      String interstitialAdUnitId,
      Function(Ad ad, LoadAdError error) onAdFailedToLoad) {
    InterstitialAd ad = InterstitialAd(
        adUnitId: interstitialAdUnitId,
        request: AdRequest(),
        listener: AdListener(
          onAdLoaded: (Ad ad) async => {await _interstitialAd.show()},
          onAdFailedToLoad: onAdFailedToLoad,
          onAdOpened: (Ad ad) => print('Ad opened'),
          onAdClosed: (Ad ad) {
            onAdClosed();
            _interstitialAd.dispose();
          },
          onApplicationExit: (Ad ad) => {_interstitialAd.dispose()},
        ));
    return ad;
  }

  static Future<void> showInterstitialAd(
      void Function() onAdClosed,
      String interstitialAdUnitId,
      Function(Ad ad, LoadAdError error) onAdFailedToLoad) async {
    _interstitialAd?.dispose();
    _interstitialAd = null;

    if (_interstitialAd == null)
      _interstitialAd = createInterstitialAd(
        onAdClosed,
        interstitialAdUnitId,
        onAdFailedToLoad,
      );

    await _interstitialAd?.load();
  }
}
