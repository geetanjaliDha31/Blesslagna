import 'dart:developer';
import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/Firebase_service/fcmtokengen.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sidebar_provider.dart';
import 'package:blesslagna/provider/zegoservices.dart';
import 'package:blesslagna/screen/navigationScreen/chat_screen.dart';
import 'package:blesslagna/screen/navigationScreen/home_screen.dart';
import 'package:blesslagna/screen/navigationScreen/match_screen.dart';
import 'package:blesslagna/screen/navigationScreen/myrequest_screen.dart';
import 'package:blesslagna/screen/navigationScreen/search_screen.dart';
import 'package:blesslagna/screen/profileupdateScreen/profile_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/packages_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  ConsumerState<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState
    extends ConsumerState<BottomNavigationScreen> {
  StateProvider userdetailloaderProvider = StateProvider((ref) => true);
  int _selectedIndex = 0;
  List<Widget> screens = [
    const HomePage(),
    const MatchScreen(),
    const SearchScreen(),
    const MyRequestScreen(),
    const ChatScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  callApi() async {
    print('come');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('userid')!;
    String firebaseid = prefs.getString('firebaseuserid')!;
    log('userid:$userid firebaseid:$firebaseid');
    onUserLogin(userid: firebaseid, name: "name");
    // await gethome(ref: ref);
    await getuserprofile(id: userid, ref: ref).whenComplete(
        () => ref.watch(userdetailloaderProvider.notifier).state = false);
  }

  @override
  void initState() {
    super.initState();
    sendUserNotificationPermission();
    setupInteractedMessage(context: context, ref: ref);
    callApi();
    // onUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(userdetailloaderProvider);
    final userdetails = ref.watch(userdetailProvider);
    return loader
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            drawer: sidebar(context: context, ref: ref),
            appBar: AppBar(
              elevation: 0,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: primary,
                      size: 24, // Changing Drawer Icon Size
                    ),
                    onPressed: () {
                      log(userdetails.basicDetailsArray![0].image.toString());
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userdetails.basicDetailsArray![0].name.toString(),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  userdetails.basicDetailsArray![0].isPaidMember!
                      ? InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PackageScreen(
                                        comefrom: '',
                                      ))),
                          child: Text(
                            'Become a premium Member',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: primary),
                          ),
                        )
                      : Text(
                          "${userdetails.locationDetailsArray![0].city}, ${userdetails.locationDetailsArray![0].state}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff7d7d7d)),
                        ),
                ],
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(
                          userdetails.basicDetailsArray![0].image.toString()),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const ProfileScreen()));
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 8),
                //     child: Icon(CupertinoIcons.bell, color: primary),
                //   ),
                // )
              ],
            ),
            body: DoubleBackToCloseApp(
              snackBar: SnackBar(
                content: Center(
                    child: Text(
                  'Tap back again to leave',
                  style: TextStyle(color: Colors.white),
                )),
                backgroundColor: primary,
                duration: Duration(
                  seconds: 2,
                ),
                behavior: SnackBarBehavior.fixed,
              ),
              child: Center(
                child: screens.elementAt(_selectedIndex),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/home.svg',
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 0 ? primary : Colors.grey.shade500,
                        BlendMode.srcIn),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/match.svg',
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 1 ? primary : Colors.grey.shade500,
                        BlendMode.srcIn),
                  ),
                  label: 'Matches',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/search.svg',
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 2 ? primary : Colors.grey.shade500,
                        BlendMode.srcIn),
                    // color:
                    //     _selectedIndex == 2 ? primary : Colors.grey.shade500
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/request.svg',
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 3 ? primary : Colors.grey.shade500,
                        BlendMode.srcIn),
                  ),
                  label: 'My request',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/chat.svg',
                    colorFilter: ColorFilter.mode(
                        _selectedIndex == 4 ? primary : Colors.grey.shade500,
                        BlendMode.srcIn),
                  ),
                  label: 'Chat',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: primary,
              unselectedItemColor: Colors.grey.shade500,
              onTap: _onItemTapped,
            ),
          );
  }
}
