import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatelessWidget {
  final String url;

  const AppWebView({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: WebViewController()
        ..loadRequest(
          Uri.parse(url),
        ),
    );
  }
}
