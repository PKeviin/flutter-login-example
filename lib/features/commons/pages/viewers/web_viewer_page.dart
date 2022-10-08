import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/utils/platform/platform.dart';

class WebViewerPage extends StatelessWidget {
  const WebViewerPage({
    required this.title,
    required this.url,
    super.key,
  });
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    if (Platform().isAndroid) {
      WebView.platform = AndroidWebView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        shape: const RoundedRectangleBorder(),
      ),
      body: WebView(initialUrl: url),
    );
  }
}
