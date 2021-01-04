import 'dart:async';

import 'package:bloc_task/size_config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  WebviewScreen({Key key, this.webPageURL}) : super(key: key);
  final String webPageURL;
  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  Completer<WebViewController> _webviewController =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: WebView(
                onWebViewCreated: (WebViewController webViewController) {
                  setState(() {
                    _webviewController.complete(webViewController);
                  });
                },
                initialUrl: widget.webPageURL,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            _webviewController.isCompleted
                ? Container()
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xffDB0162)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
