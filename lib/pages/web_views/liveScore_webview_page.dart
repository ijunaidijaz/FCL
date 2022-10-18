import 'package:fcl/widgets/app_progressIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveScoreWebViewPage extends StatefulWidget {
  final String title;
  final String selectedUrl;

  LiveScoreWebViewPage({
    @required this.title,
    @required this.selectedUrl,
  });
  LiveScoreWebViewPageState createState() => LiveScoreWebViewPageState();
}

class LiveScoreWebViewPageState extends State<LiveScoreWebViewPage> {
  num position = 1;

  final key = UniqueKey();

  doneLoading(url) {
    setState(() {
      position = 0;
    });
  }

  startLoading(url) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: IndexedStack(index: position, children: <Widget>[
          WebView(
            initialUrl: widget.selectedUrl,
            javascriptMode: JavascriptMode.unrestricted,
            key: key,
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
          ),
          Container(
            color: Colors.white,
            child: Center(child: progressIndicator()),
          ),
        ]));
  }
}
