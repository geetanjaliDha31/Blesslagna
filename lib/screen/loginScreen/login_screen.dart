import 'dart:developer';
import 'package:blesslagna/API/login_api/login.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/zegoservices.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:blesslagna/screen/loginScreen/register_screen.dart';
import 'package:blesslagna/screen/widget/forgotpassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

StateProvider obsureProvider = StateProvider((ref) => true);
TextEditingController _username = TextEditingController();
TextEditingController _password = TextEditingController();

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final obsurestat = ref.watch(obsureProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: GradientAppBar(
          gradient: grident,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: SvgPicture.asset(
              'assets/Signup.svg',
              height: 180,
            )),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                //border
                controller: _username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),

                    //label
                    floatingLabelStyle: TextStyle(
                        color: textcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    label: Text(
                      "Username  ",
                      style: TextStyle(
                        fontSize: 14,
                        color: textcolor,
                      ),
                    ),
                    //hint text
                    hintText: 'Enter Your Email Id/Phone no./ID',
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: lighttext),
                    //suffix
                    suffixIcon: const Icon(CupertinoIcons.envelope)),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                //border
                controller: _password,
                obscureText: obsurestat,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),

                    //label
                    floatingLabelStyle: TextStyle(
                        color: textcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    label: Text(
                      "Password  ",
                      style: TextStyle(
                        fontSize: 14,
                        color: textcolor,
                      ),
                    ),
                    //hint text
                    hintText: 'Enter Your Password',
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: lighttext),
                    //suffix
                    suffixIcon: InkWell(
                        onTap: () =>
                            ref.watch(obsureProvider.notifier).state = false,
                        child: obsurestat
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash_fill))),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword())),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0x66000000)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () => loginbtnfunction(context: context, ref: ref),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: primary,
                    minimumSize: Size(width, 50)),
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                )),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen())),
              child: RichText(
                text: TextSpan(
                  text: 'Don’t Have an Account?  ',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xD9131313)),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: primary)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loginbtnfunction(
      {required BuildContext context, required WidgetRef ref}) async {
    if (_username.text.isNotEmpty) {
      if (_password.text.isNotEmpty) {
        await Login()
            .login(
                username: _username.text,
                password: _password.text,
                ref: ref,
                context: context)
            .then((value) async {
          if (!value) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            String userfirebaseid = prefs.getString('firebaseuserid')!;
            log(' $userfirebaseid');
            onUserLogin(userid: userfirebaseid, name: userfirebaseid)
                .whenComplete(() {
              _username.clear();
              _password.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigationScreen()),
                  (route) => false);
            });
          }
        });
      } else {
        toast('Enter Password');
      }
    } else {
      toast('Enter Username');
    }
  }
}
