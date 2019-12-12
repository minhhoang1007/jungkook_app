import 'package:flutter/material.dart';
import 'package:jungkook_app/screens/ItemCategory.dart';

class CategorySceen extends StatefulWidget {
  CategorySceen({Key key}) : super(key: key);

  @override
  _CategorySceenState createState() => _CategorySceenState();
}

class _CategorySceenState extends State<CategorySceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 22,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemCategory(
                        title: "JUNGKOOK WALLPAPER #${22 - position} | New"),
                  ));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/anhcate.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.2,
                                right: MediaQuery.of(context).size.width * 0.2),
                            child: Divider(
                              indent: 1,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "WALLS STUDIO",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                fontSize: 36),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.2,
                                right: MediaQuery.of(context).size.width * 0.2),
                            child: Divider(
                              color: Colors.white,
                              indent: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "JUNGKOOK WALLPAPER #${22 - position} | New",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
