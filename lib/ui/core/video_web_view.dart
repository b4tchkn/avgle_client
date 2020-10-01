import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoWebView extends StatelessWidget {
  const VideoWebView({@required String videoUrl, @required String videoTitle})
      : _videoUrl = videoUrl,
        _videoTitle = videoTitle;

  final String _videoUrl;
  final String _videoTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_videoTitle),
      ),
      body: WebView(
        initialUrl: _videoUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
