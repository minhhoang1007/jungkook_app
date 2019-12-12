import 'package:flutter/material.dart';
import 'package:jungkook_app/drawerscreen/drawer.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //drawer: DrawerSceen(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 100, 400),
          leading: IconButton(
            onPressed: () {
              //_scaffoldKey.currentState.openDrawer();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.list,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Jungkook Wallpaper",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                "About",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              )
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              title: Text("Application Name",
                  style: TextStyle(color: Colors.grey)),
              subtitle: Text("Jungkook Wallpaper"),
            ),
            Divider(
              indent: 16,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.error_outline,
                color: Colors.grey,
              ),
              title:
                  Text("Build Version", style: TextStyle(color: Colors.grey)),
              subtitle: Text("Version 7.3.1"),
            ),
            Divider(
              indent: 16,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.grey,
              ),
              title: Text("Email", style: TextStyle(color: Colors.grey)),
              subtitle: Text("jungkook@gmail.com"),
            ),
            Divider(
              indent: 16,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.error,
                color: Colors.grey,
              ),
              title: Text("Copyright", style: TextStyle(color: Colors.grey)),
              subtitle: Text("Copyright @ 2019 Walls Studio Developer \n"
                  "All right reserved"),
            ),
            Divider(
              indent: 16,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.rate_review,
                color: Colors.grey,
              ),
              title: Text("Rate", style: TextStyle(color: Colors.grey)),
              subtitle: Text("Give you rate and feedback"),
            ),
            Divider(
              indent: 16,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.more,
                color: Colors.grey,
              ),
              title: Text("More", style: TextStyle(color: Colors.grey)),
              subtitle: Text("More apps from developer"),
            ),
            Divider(
              indent: 16,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              title:
                  Text("Privacy Policy", style: TextStyle(color: Colors.grey)),
              subtitle: Text("Privacy Policy for Jungkook Wallpaper"),
            ),
            Divider(
              indent: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
