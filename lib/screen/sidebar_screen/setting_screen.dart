import 'dart:developer';

import 'package:blesslagna/API/login_api/userdeleteapi.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/provider/webview.dart';
import 'package:blesslagna/provider/zegoservices.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:blesslagna/screen/loginScreen/login_screen.dart';
import 'package:blesslagna/screen/splashscreen.dart';
import 'package:blesslagna/screen/widget/changeemail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          'Setting',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: primary),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     // border: Border.all(width: 1, color: Colors.grey),
          //     borderRadius: BorderRadius.circular(10),
          //     boxShadow: const [
          //       BoxShadow(
          //           color: Color(
          //             0x3f000000,
          //           ), //New
          //           blurRadius: 1.0,
          //           offset: Offset(0, 0))
          //     ],
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //     child: Row(
          //       children: [
          //         SvgPicture.asset('assets/notification.svg'),
          //         const SizedBox(width: 20),
          //         Text('Notification',
          //             style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.w500,
          //                 color: primary)),
          //         const Spacer(),
          //         Icon(
          //           Icons.arrow_forward_ios_sharp,
          //           color: primary,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WebViewScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color(
                        0x3f000000,
                      ), //New
                      blurRadius: 1.0,
                      offset: Offset(0, 0))
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/help.svg'),
                    const SizedBox(width: 20),
                    Text('Contact Us',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primary)),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: primary,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => bottomsheetdelete(context: context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color(
                        0x3f000000,
                      ), //New
                      blurRadius: 1.0,
                      offset: Offset(0, 0))
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/delete.svg'),
                    const SizedBox(width: 20),
                    Text('Delete Account',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primary)),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: primary,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangeEmail())),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color(
                        0x3f000000,
                      ), //New
                      blurRadius: 1.0,
                      offset: Offset(0, 0))
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: primary,
                    ),
                    const SizedBox(width: 20),
                    Text('Change Email',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primary)),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: primary,
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ElevatedButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('logged', false);
              onUserLogout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: primary,
                minimumSize: Size(width, 50)),
            child: const Text(
              "Logout",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            )),
      ),
    );
  }
}

bottomsheetdelete({required BuildContext context}) {
  return showModalBottomSheet<void>(
    isScrollControlled: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      return SizedBox(
        height: 300,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Permanently Delete Your Account",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primary)),
                const SizedBox(height: 20),
                const Text(
                    "Dear User\nKindly Note your Blesslagana account ensures that you won't be able to retrieve the content or information that you've updated on APP",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.1,
                        height: 1.5)),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: Size(width, 40),
                        backgroundColor: primary),
                    onPressed: () async {
                      // ignore: use_build_context_synchronously
                      log("come");
                      userdelete().whenComplete(() async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.clear();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                            (route) => false);
                      });
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      );
    },
  );
}
