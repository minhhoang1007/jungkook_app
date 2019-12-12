import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OtherScreen extends StatefulWidget {
  OtherScreen({Key key}) : super(key: key);

  @override
  _OtherScreenState createState() => _OtherScreenState();
}

class _OtherScreenState extends State<OtherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 100, 400),
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
        title: Text("Ohther"),
      ),
      body: WebView(
        initialUrl:
            'https://vi.wikipedia.org/wiki/Dart_(ng%C3%B4n_ng%E1%BB%AF_l%E1%BA%ADp_tr%C3%ACnh)',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
