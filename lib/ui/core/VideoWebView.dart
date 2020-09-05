import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebView extends StatelessWidget {
  const VideoWebView({@required String videoUrl}) : _videoUrl = videoUrl;

  final String _videoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_videoUrl),
      ),
      body: WebView(
        initialUrl: _videoUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
