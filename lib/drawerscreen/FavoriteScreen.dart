import 'package:flutter/material.dart';
import 'package:jungkook_app/drawerscreen/drawer.dart';
import 'package:jungkook_app/screens/ItemPhoto.dart';
import 'package:jungkook_app/utils/Common.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        body: Common.item.length == 0
            ? Container(
                child: Center(
                  child: Text("No image favorite"),
                ),
              )
            : GridView.builder(
                itemCount: Common.item.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight)),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemPhoto(
                                    img: Common.item[index],
                                  )));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(Common.item[index]),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
