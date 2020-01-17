import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:jungkook_app/configs/ads.dart';
import 'package:jungkook_app/drawerscreen/drawer.dart';
import 'package:jungkook_app/main.dart';
import 'package:jungkook_app/screens/CategoryScreen.dart';
import 'package:jungkook_app/screens/RecentScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    MyApp.platform.invokeMethod("rateAuto");
    _tabController = TabController(length: 2, vsync: this);
  }

  InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: InterstitialAd.testAdUnitId,
    targetingInfo: ADS().targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return DefaultTabController(
      length: 2,
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
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                myInterstitial
                  ..load()
                  ..show(
                    anchorType: AnchorType.bottom,
                    anchorOffset: 0.0,
                    horizontalCenterOffset: 0.0,
                  );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  image: DecorationImage(
                    image: AssetImage("assets/images/vip.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            RecentSceen(),
            CategorySceen(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
