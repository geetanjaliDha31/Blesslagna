import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/color.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:blesslagna/API/paymentapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class PaymentWebView extends ConsumerStatefulWidget {
  final packageid;
  const PaymentWebView({super.key, required this.packageid});

  @override
  ConsumerState<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends ConsumerState<PaymentWebView> {
  bool isLoading = false;
  StateProvider pageloaderProvider = StateProvider((ref) => true);
  PaymentModel? paymentdata;
  void callApi() async {
    log(widget.packageid.toString());
    paymentdata = await paymentpackage(packid: widget.packageid).whenComplete(
        () => ref.watch(pageloaderProvider.notifier).state = false);
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(pageloaderProvider);
    return Scaffold(
        body: loader
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: Stack(children: [
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: paymentdata!.shortUrl,
                  gestureNavigationEnabled: true,
                  onPageFinished: (String url) async {
                    log('Page finished loading: $url');

                    var apiurl = Uri.parse(url);
                    var request = await http.get(apiurl);
                    var data = jsonDecode(request.body);
                    if (data['url'] == "success.php") {
                      log('payment done');
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 600,
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      ' Congratulations! You have ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'purchased has been Successful',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SvgPicture.asset('assets/sucess.svg'),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationScreen()),
                                          (route) => false);
                                    },
                                    child: Text(
                                      'Go to Home Screen',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: primary,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      // Navigator.pop(context);
                    } else {
                      log("payment fail");
                    }
                    // if (url.contains("paid")) {
                    //   Navigator.pop(context);
                    // }

                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ])));
  }
}
