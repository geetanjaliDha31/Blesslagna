import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: WebView(
            // initialUrl: 'https://apnaschoolbus.com',
            initialUrl: "https://blesslagna.com/index.php",
            javascriptMode: JavascriptMode.unrestricted,

            onWebViewCreated: (WebViewController controller) {
              webViewController = controller;
            },
            zoomEnabled: false,
          ),
        ),
      ),
    );
  }
}
