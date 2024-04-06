import 'package:blesslagna/API/paramerter_api/cityparameter.dart';
import 'package:blesslagna/API/paramerter_api/countryparameter.dart';
import 'package:blesslagna/API/paramerter_api/formparameterapi.dart';
import 'package:blesslagna/API/paramerter_api/stateparameter.dart';
import 'package:blesslagna/Firebase_service/fcmtokengen.dart';
import 'package:blesslagna/firebase_options.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Set the background message handler for Firebase Messaging
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e) {
    log(e.toString());
  }
  if (!kDebugMode) {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.startFlexibleUpdate();
      }
    }).catchError((e) {});
  }
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  runApp(ProviderScope(
      child: MyApp(
    navigatorKey: navigatorKey,
  )));
}

class MyApp extends ConsumerStatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  callApi() async {
    getparameter(ref: ref);
    if (mounted) {
      getCountry(ref: ref).whenComplete(() {
        if (mounted) {
          getState(countryid: '101', ref: ref).whenComplete(() {
            if (mounted) {
              getcity(ref: ref, stateid: '4008');
            }
          });
        }
      });
    }
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Blesslagna',
        navigatorKey: widget.navigatorKey,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: primary),
            useMaterial3: false,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
            ),
            fontFamily: 'poppins'),
        home: SplashScreen());
  }
}
