import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebView extends StatelessWidget {
  const VideoWebView(this.videoUrl);
  final String videoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videoUrl),
      ),
      body: WebView(
        initialUrl: videoUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
