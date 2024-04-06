import 'dart:convert';
import 'dart:developer';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:blesslagna/API/drawer_api/packageapi.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageScreen extends ConsumerStatefulWidget {
  final String comefrom;
  const PackageScreen({super.key, required this.comefrom});

  @override
  ConsumerState<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends ConsumerState<PackageScreen> {
  StateProvider packageloaderProvider = StateProvider((ref) => true);
  callApi() async {
    await getipackeges(ref: ref).whenComplete(
        () => ref.watch(packageloaderProvider.notifier).state = false);
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final loader = ref.watch(packageloaderProvider);
    final packages = ref.watch(packageProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigationScreen()),
              (route) => false),
          child: Icon(
            Icons.arrow_back_ios,
            color: primary,
            size: 20,
          ),
        ),
        title: Text(
          'Packages',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: primary),
        ),
      ),
      body: loader
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: width,
                    color: primary,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Our Customized Packages',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Stack(children: [
                    Container(
                      height: 350,
                      width: width,
                      color: primary,
                    ),
                    Positioned(
                      child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: packages.packagesArray!.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  PackageCard(
                                      data: packages.packagesArray![index]),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              );
                            }),
                      ),
                    ),
                  ])
                ],
              ),
            ),
      bottomNavigationBar: widget.comefrom == 'photo'
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavigationScreen())),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: primary,
                          minimumSize: Size(width, 50)),
                      child: const Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      )),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

class PackageCard extends ConsumerStatefulWidget {
  final PackagesArray data;
  const PackageCard({super.key, required this.data});

  @override
  ConsumerState<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends ConsumerState<PackageCard> {
  @override
  Widget build(BuildContext context) {
    final userdetail = ref.watch(userdetailProvider);
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Color(
                0x3f000000,
              ), //New
              blurRadius: 1.0,
              offset: Offset(0, 0))
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            widget.data.packageName.toString(),
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: primary),
          ),
          const SizedBox(height: 5),
          Text(
            '(${widget.data.duration.toString()} days)',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: primary),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
                color: primary, borderRadius: BorderRadius.circular(5)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                '20% off ₹ 4,450',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Divider(
            thickness: 0.5,
          ),
          Text(
            '₹ ${widget.data.packAmount.toString()}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          const Text(
            '₹ 15,000 per year',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff7E7E7E)),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(CupertinoIcons.check_mark, color: primary),
                const SizedBox(width: 10),
                Text(
                  'Interests : ${widget.data.totalInterest.toString()}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7E7E7E)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(CupertinoIcons.check_mark, color: primary),
                const SizedBox(width: 10),
                Text(
                  'Chat : ${widget.data.totalChat.toString()}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7E7E7E)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(CupertinoIcons.check_mark, color: primary),
                const SizedBox(width: 10),
                Text(
                  'Contact : ${widget.data.totalContact.toString()}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff7E7E7E)),
                )
              ],
            ),
          ),
          const SizedBox(height: 36),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    width: 1,
                    color: primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(250, 50)),
              onPressed: () {
                log('come in buy now');
                // cashfree
                double rsamount =
                    double.parse(widget.data.packAmount.toString()) * 100.0;

                Razorpay razorpay = Razorpay();
                var options = {
                  // 'key': 'rzp_test_XIYIlcRrUtXElK',
                  'key': 'rzp_live_MCMJsX5brETbxY',
                  'amount': rsamount.toString(),
                  // 'amount': 100,
                  'name': 'Powered by Blesslagna.',
                  'description': "${widget.data.packageName} Subcription",
                  'retry': {'enabled': true, 'max_count': 1},
                  'send_sms_hash': true,
                  'prefill': {
                    'contact':
                        '+91${userdetail.locationDetailsArray![0].phone}',
                    // 'email': 'shekharingale14@gmail.com'
                  },
                  'external': {
                    'wallets': ['paytm']
                  }
                };
                razorpay.on(
                    Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                    handlePaymentSuccessResponse);
                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                    handleExternalWalletSelected);
                razorpay.open(options);
              },
              child: Text(
                'Buy Now',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: primary),
              ))
        ],
      ),
    );
  }

  void handlePaymentErrorResponse(
      PaymentFailureResponse response, BuildContext context) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    log('done');
    String paymentid = response.data!['razorpay_payment_id'];
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/purchaseSubscription.php");
      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'user_id': userid,
        'package_id': widget.data.packageId,
        'payment_status': "Sucess",
        'razorpay_txn_id': paymentid,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
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
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'purchased has been Successful',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                                builder: (context) => BottomNavigationScreen()),
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
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void handleExternalWalletSelected(
      ExternalWalletResponse response, BuildContext context) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // Dialog alert = Dialog(
    //   insetPadding: const EdgeInsets.all(20),
    //   child: SingleChildScrollView(
    //     padding: const EdgeInsets.all(20),
    //     child: Column(
    //       children: [
    //         const SizedBox(height: 10),
    //         Icon(
    //           CupertinoIcons.xmark_circle_fill,
    //           color: primary,
    //           size: 80,
    //         ),
    //         const SizedBox(height: 10),
    //         Text(
    //           title,
    //           style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.w500,
    //             color: primary,
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         Text(
    //           "Your Stay Not Booked ! Due To Payment Issue",
    //           style: TextStyle(
    //               height: 1,
    //               letterSpacing: 0.5,
    //               fontSize: 12,
    //               fontWeight: FontWeight.w400,
    //               color: Colors.grey.shade500),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

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
                    ' Your Purchase has been failed ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 20),
                SvgPicture.asset('assets/sucess.svg'),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: primary,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50)),
                    child: Text(
                      "Upload Image",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    )),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationScreen()),
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
  }
}
