import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
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

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  bool abc = false;
  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  // InterstitialAd createInterstitialAd() {
  //   return InterstitialAd(
  //       adUnitId: InterstitialAd.testAdUnitId,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("IntersttialAd $event");
  //       });
  // }
  void getAd(item) async {
    _interstitialAd = InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.closed) {
          _interstitialAd.load();
        }
        handEvent(event, item);
      },
    );
    _interstitialAd.load();
  }

  void handEvent(MobileAdEvent event, item) {
    switch (event) {
      case MobileAdEvent.loaded:
        //if (!c) {
        _interstitialAd.show();
        //c = true;
        //}
        break;
      case MobileAdEvent.opened:
        break;
      case MobileAdEvent.closed:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemPhoto(
              img: item,
            ),
          ),
        );
        break;
      case MobileAdEvent.failedToLoad:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemPhoto(
              img: item,
            ),
          ),
        );
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();
    super.initState();
  }

  @override
  void dispose() {
    //_bannerAd.dispose();
    //_interstitialAd.dispose();
    super.dispose();
  }

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
            getAd(items[index]);
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
