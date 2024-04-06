import 'package:blesslagna/color.dart';
import 'package:blesslagna/screen/loginScreen/login_screen.dart';
import 'package:blesslagna/screen/loginScreen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Image.asset('assets/intro.jpg'),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          Center(child: SvgPicture.asset('assets/line.svg')),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Discover Your Partner",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 14,
          ),
          const Text(
            "Find Your Perfect Partner on this \n application ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                    (route) => false),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: primary,
                    minimumSize: Size(width, 40)),
                child: const Text(
                  "Create an Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false),
            child: SizedBox(
              child: Text(
                "Log into Account",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, color: primary),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
