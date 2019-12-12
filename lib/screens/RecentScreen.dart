import 'package:flutter/material.dart';
import 'package:jungkook_app/screens/ItemPhoto.dart';

class RecentSceen extends StatefulWidget {
  RecentSceen({Key key}) : super(key: key);

  @override
  _RecentSceenState createState() => _RecentSceenState();
}

const String testDevice = 'MobileId';

class _RecentSceenState extends State<RecentSceen> {
  List<String> items = [
    "assets/recent/kook1.jpg",
    "assets/recent/kook2.jpg",
    "assets/recent/kook3.jpg",
    "assets/recent/kook4.jpg",
    "assets/recent/kook5.jpg",
    "assets/recent/kook6.jpg",
    "assets/recent/kook7.jpg",
    "assets/recent/kook8.jpg",
    "assets/recent/kook9.jpg",
    "assets/recent/kook10.jpg",
    "assets/recent/kook11.jpg",
    "assets/recent/kook12.jpg",
  ];

  // static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: testDevice != null ? <String>[testDevice] : null,
  //   nonPersonalizedAds: true,
  //   keywords: <String>['Game', 'Mario'],
  // );
  // BannerAd _bannerAd;
  // InterstitialAd _interstitialAd;
  // BannerAd createBannerAd() {
  //   return BannerAd(
  //       adUnitId: BannerAd.testAdUnitId,
  //       //Change BannerAd adUnitId with Admob ID
  //       size: AdSize.banner,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("BannerAd $event");
  //       });
  // }

  // InterstitialAd createInterstitialAd() {
  //   return InterstitialAd(
  //       adUnitId: InterstitialAd.testAdUnitId,
  //       //Change Interstitial AdUnitId with Admob ID
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("IntersttialAd $event");
  //       });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
  //   //Change appId With Admob Id
  //   // _bannerAd = createBannerAd()
  //   //   ..load()
  //   //   ..show();
  //   // super.initState();
  // }

  // @override
  // void dispose() {
  //   //_bannerAd.dispose();
  //   //_interstitialAd.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = size.width / 2;
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              // createInterstitialAd()
              //   ..load()
              //   ..show();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemPhoto(
                            img: items[index],
                          )));
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Image.asset(items[index]),
          ),
        );
      },
    );
  }
}
