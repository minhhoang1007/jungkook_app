import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:jungkook_app/constants/ApiConstants.dart';
import 'package:jungkook_app/drawerscreen/drawer.dart';
import 'package:jungkook_app/screens/ItemPhoto.dart';
import 'package:jungkook_app/utils/Common.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

const String testDevice = 'MobileId';

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  bool abc = false;
  bool isLoad = false;
  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: ADMOB_BANNER_ID,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  // InterstitialAd createInterstitialAd() {
  //   return InterstitialAd(
  //       adUnitId: ADMOB_INTERSTITIAL_ID,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("IntersttialAd $event");
  //       });
  // }
  void getAd(item) async {
    setState(() {
      isLoad = true;
    });
    _interstitialAd = InterstitialAd(
      adUnitId: ADMOB_INTERSTITIAL_ID,
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
        isLoad = false;
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
        isLoad = false;
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
    FirebaseAdMob.instance.initialize(appId: ADMOB_APP_ID);
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
    print(Common.item);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = size.width / 2;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //drawer: DrawerSceen(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 130),
          leading: IconButton(
            onPressed: () {
              //_scaffoldKey.currentState.openDrawer();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "Jungkook Wallpaper",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "Favorite",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              )
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Common.item.length == 0
                ? Container(
                    child: Center(
                      child: Text("No image favorite"),
                    ),
                  )
                : GridView.builder(
                    itemCount: Common.item.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          getAd(Common.item[index]);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ItemPhoto(
                          //               img: Common.item[index],
                          //             )));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Image.asset(Common.item[index]),
                        ),
                      );
                    },
                  ),
            isLoad
                ? Positioned(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 1,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }
}
