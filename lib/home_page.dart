import 'package:flutter/material.dart';
import 'package:flutter_admob/ad_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd _topBanner;
  bool _isLoadedTopBanner = false;

  @override
  void initState() {
    _createTopBanner();
    super.initState();
  }

  @override
  void dispose() {
    _topBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AD DEMO'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _isLoadedTopBanner
                ? Container(
                    height: 300,
                    child: AdWidget(ad: _topBanner),
                  )
                : Container(),
            const SizedBox(
              height: 44,
            ),
            RaisedButton(
                child: Text('インタースティシャル広告'),
                onPressed: () async {
                  AdService.showInterstitialAd(
                      () {}, AdService.interstitialAdUnitId, (ad, error) {
                    ad.dispose();
                  });
                })
          ],
        ),
      ),
    );
  }

  /// バナー
  /// The medium rectangle (300x250) size.
  _createTopBanner() {
    if (_topBanner == null) {
      _topBanner = AdService.createBannerAd(
        adSize: AdSize.mediumRectangle,
        adUnitId: AdService.topBannerAdIUnitID,
        onAdLoaded: (ad) {
          setState(() {
            _isLoadedTopBanner = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          setState(() {
            _isLoadedTopBanner = false;
          });

          print('AD ERROR : ${error.message}');
          ad.dispose();
        },
        onAdOpened: (ad) {},
        onAdClosed: (ad) {},
      );
    }
    _topBanner.load();
  }
}
