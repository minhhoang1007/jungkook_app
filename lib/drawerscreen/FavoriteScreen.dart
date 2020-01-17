import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jungkook_app/configs/ads.dart';
import 'package:jungkook_app/main.dart';
import 'package:jungkook_app/screens/ItemPhoto.dart';
import 'package:jungkook_app/utils/Common.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  InterstitialAd _interstitialAd;
  bool abc = false;
  bool isLoad = false;
  void getString() {
    Common.item = prefs.getStringList(Common.LIST_FAVORITE);
  }

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
    getString();
    FirebaseAdMob.instance.initialize(appId: appId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Common.item);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 130),
        leading: IconButton(
          onPressed: () {
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
          Common.item == null
              ? Container(
                  child: Center(
                    child: Text(
                      "No image favorite",
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                )
              : StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  physics: ScrollPhysics(),
                  itemCount: Common.item.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    elevation: 4,
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          getAd(Common.item[index]);
                        },
                        child:
                            Image.asset(Common.item[index], fit: BoxFit.cover),
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
    );
  }
}
