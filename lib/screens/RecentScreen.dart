import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jungkook_app/configs/ads.dart';
import 'package:jungkook_app/screens/ItemPhoto.dart';

class RecentSceen extends StatefulWidget {
  RecentSceen({Key key}) : super(key: key);

  @override
  _RecentSceenState createState() => _RecentSceenState();
}

class _RecentSceenState extends State<RecentSceen> {
  List<String> items = [
    "assets/recent/kook22.jpg",
    "assets/recent/kook23.jpg",
    "assets/recent/kook24.jpg",
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
    "assets/recent/kook13.jpg",
    "assets/recent/kook14.jpg",
    "assets/recent/kook15.jpg",
    "assets/recent/kook16.jpg",
    "assets/recent/kook17.jpg",
    "assets/recent/kook18.jpg",
    "assets/recent/kook19.jpg",
    "assets/recent/kook20.jpg",
  ];
  InterstitialAd _interstitialAd;
  bool abc = false;
  bool isLoad = false;

  void getAd(item) async {
    setState(() {
      isLoad = true;
    });
    _interstitialAd = InterstitialAd(
      adUnitId: interUnitId,
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
        _interstitialAd.show();

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
    FirebaseAdMob.instance.initialize(appId: appId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          physics: ScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) => Card(
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            child: Container(
              child: InkWell(
                onTap: () {
                  getAd(items[index]);
                },
                child: Image.asset(items[index], fit: BoxFit.cover),
              ),
            ),
          ),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 2.7 : 3),
          scrollDirection: Axis.vertical,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
        ),
        isLoad
            ? Positioned(
                child: Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height,
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
    );
  }
}
