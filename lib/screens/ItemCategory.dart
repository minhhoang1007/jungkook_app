import 'package:flutter/material.dart';
import 'package:jungkook_app/screens/ItemPhoto.dart';

class ItemCategory extends StatefulWidget {
  String title;
  ItemCategory({this.title, Key key}) : super(key: key);

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  List<String> items = [
    "assets/recent/kook13.jpg",
    "assets/recent/kook14.jpg",
    "assets/recent/kook15.jpg",
    "assets/recent/kook16.jpg",
    "assets/recent/kook17.jpg",
    "assets/recent/kook18.jpg",
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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 130),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemPhoto(
                            img: items[index],
                          )));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Image.asset(items[index]),
            ),
          );
        },
      ),
    );
  }
}
