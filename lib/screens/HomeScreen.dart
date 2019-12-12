import 'package:flutter/material.dart';
import 'package:jungkook_app/drawerscreen/drawer.dart';
import 'package:jungkook_app/screens/CategoryScreen.dart';
import 'package:jungkook_app/screens/RecentScreen.dart';

const String testDevice = 'MobileId';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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
  //   _tabController = new TabController(length: 2, vsync: this);
  //   FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
  //   //Change appId With Admob Id
  //   _bannerAd = createBannerAd()
  //     ..load()
  //     ..show();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _bannerAd.dispose();
  //   //_interstitialAd.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerSceen(_tabController),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.list),
              iconSize: 35,
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            title: Text(
              "Jungkook Wallpaper",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            backgroundColor: Color.fromARGB(255, 0, 0, 130),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "RECENT",
                ),
                Tab(
                  text: "CATEGORY",
                )
              ],
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            bottomOpacity: 1,
          ),
          body: TabBarView(
            children: [
              RecentSceen(),
              CategorySceen(),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
