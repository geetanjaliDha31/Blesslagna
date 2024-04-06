import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:blesslagna/screen/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  StateProvider userlogged = StateProvider((ref) => false);
  callApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ref.watch(userlogged.notifier).state = prefs.getBool("logged") ?? false;
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logged = ref.watch(userlogged);
    return AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset(
          "assets/logo.png",
          height: 300,
          width: 300,
        ),
        nextScreen:
            logged ? const BottomNavigationScreen() : const IntroScreen(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.white);
  }
}
