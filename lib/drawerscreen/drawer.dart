import 'package:flutter/material.dart';
import 'package:jungkook_app/drawerscreen/AboutScreen.dart';
import 'package:jungkook_app/drawerscreen/FavoriteScreen.dart';
import 'package:jungkook_app/screens/HomeScreen.dart';

class DrawerSceen extends StatefulWidget {
  DrawerSceen({Key key}) : super(key: key);

  @override
  _DrawerSceenState createState() => _DrawerSceenState();
}

class _DrawerSceenState extends State<DrawerSceen> {
  Color color;

  @override
  void initState() {
    super.initState();
    color = Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * 0.5,
            width: double.infinity,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/drawer_header_image.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                        Container(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                                "assets/images/ic_notification_large.png")),
                        SizedBox(
                          height: 10,
                        ),
                        Text("JungKook Wallpaper",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        Text("jungkook@gmail.com",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Ink(
            color: color,
            child: ListTile(
              leading: Container(
                height: 30,
                width: 30,
                child: Image.asset("assets/images/ic_drawer_recent.png"),
              ),
              title: Text("Recent Wallpaper"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  color = Colors.grey;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                });
              },
            ),
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              child: Image.asset("assets/images/ic_drawer_category.png"),
            ),
            title: Text("Catepory"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              child: Image.asset("assets/images/ic_drawer_favorite.png"),
            ),
            title: Text("Favorite"),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                color = Colors.grey;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(),
                    ));
              });
            },
          ),
          Divider(
            color: Colors.black45,
            indent: 16,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Text(
              "Other",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              child: Image.asset(
                "assets/images/ic_drawer_rate.png",
                fit: BoxFit.fill,
              ),
            ),
            title: Text("Rate"),
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              child: Image.asset(
                "assets/images/ic_drawer_more.png",
                fit: BoxFit.fill,
              ),
            ),
            title: Text("More"),
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              child: Image.asset(
                "assets/images/ic_drawer_share.png",
                color: Colors.grey[700],
                fit: BoxFit.fill,
              ),
            ),
            title: Text("Share"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutScreen(),
                    ));
              });
            },
            leading: Container(
              height: 30,
              width: 30,
              child: Image.asset(
                "assets/images/ic_drawer_about.png",
                fit: BoxFit.fill,
              ),
            ),
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}
