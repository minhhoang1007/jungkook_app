import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jungkook_app/main.dart';
import 'package:jungkook_app/utils/Common.dart';
import 'package:photos_saver/photos_saver.dart';

class ItemPhoto extends StatefulWidget {
  String img;
  ItemPhoto({this.img, Key key}) : super(key: key);

  @override
  _ItemPhotoState createState() => _ItemPhotoState();
}

class _ItemPhotoState extends State<ItemPhoto> {
  bool chonfavo;
  @override
  void initState() {
    super.initState();
    Common.item.length == 0 ? chonfavo = false : chonfavo = true;
    loadImage();
  }

  //Share
  Future<void> _shareImage() async {
    try {
      final ByteData bytes = await rootBundle.load(widget.img);
      await Share.file(
          'esys image', 'esys.png', bytes.buffer.asUint8List(), 'image/png',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  //Save
  Uint8List _imageData;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<void> loadImage() async {
    var imageData = await rootBundle.load(widget.img).then((byteData) {
      return byteData.buffer.asUint8List();
    });
    if (!mounted) return;
    setState(() {
      _imageData = imageData;
    });
  }

  //Set wallpaper
  String home = "HomeScreen",
      lock = "LockScreen",
      both = "BothScreen",
      system = "SystemWallpaer";
  Stream<String> progressString;
  String res;
  bool downloading = false;
  _setwallpaper(String path) {
    MyApp.platform.invokeMethod("setwallpaper", {"path": path}).then((value) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("OK"),
      ));
    }).catchError((onError) {});
  }

  //favorite
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.img), fit: BoxFit.fill),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: chonfavo
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                          onPressed: () {
                            chonfavo
                                ? Common.item.remove(widget.img)
                                : Common.item.add(widget.img);
                            print(Common.item.length);
                            setState(() {
                              chonfavo = !chonfavo;
                              Fluttertoast.showToast(
                                msg: chonfavo
                                    ? "Saved favorite"
                                    : "Deleted favorite",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1,
                                fontSize: 16,
                              );
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            print("share");
                            await _shareImage();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.add_event,
            closeManually: true,
            children: [
              SpeedDialChild(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  label: "Set as Wallpaper",
                  onTap: () async {
                    String filePath =
                        await PhotosSaver.saveFile(fileData: _imageData);
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text("Created image file at $filePath")));
                    _setwallpaper(filePath);
                  }),
              SpeedDialChild(
                  child: Icon(Icons.share, color: Colors.white),
                  label: "Share",
                  onTap: () async {
                    print("share");
                    await _shareImage();
                  }),
              SpeedDialChild(
                  child: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: "Save",
                  onTap: () async {
                    String filePath =
                        await PhotosSaver.saveFile(fileData: _imageData);
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text("Created image file at $filePath")));

                    print(filePath);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
