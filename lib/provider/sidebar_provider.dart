import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/webview.dart';
import 'package:blesslagna/screen/sidebar_screen/blockprofile_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/ishortlist_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/iviewedprofile_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/packages_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrence_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/setting_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/userpackagedetails.dart';
import 'package:blesslagna/screen/widget/profiledetails_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget sidebar({required BuildContext context, required WidgetRef ref}) {
  final userdetails = ref.watch(userdetailProvider);
  final homedata = ref.watch(homedataProvider);

  return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //   radius: 35,
                  //   backgroundImage: NetworkImage(userdetails
                  //       .commonDetailsArray![0].profileImage
                  //       .toString()),
                  // ),
                  const SizedBox(height: 8),
                  Text(
                    userdetails.commonDetailsArray![0].userName.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        color: primary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    userdetails.commonDetailsArray![0].matrimonialId.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.chat_bubble, size: 20),
                      const SizedBox(width: 5),
                      Text(
                          'Chat ( ${userdetails.commonDetailsArray![0].pendingChat.toString()} )'),
                      const VerticalDivider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      const Icon(CupertinoIcons.phone_fill, size: 20),
                      const SizedBox(width: 5),
                      Text(
                          'Call ( ${userdetails.commonDetailsArray![0].pendingContact.toString()} )')
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.person, color: primary),
                title: const Text(
                  ' My Profile ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileDetailsScreen(
                        comefrom: "My",
                        id: userdetails.commonDetailsArray![0].matrimonialId
                            .toString(),
                        newmatchdata: homedata.newMatches![0],
                        premiumMatches: homedata.premiumMatches![0],
                        isPaidMember: homedata.premiumMatches![0].isPaidMember!,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/sidebar/2.svg'),
                title: const Text(
                  ' Subcription ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PackageScreen(
                        comefrom: '',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera_front_rounded, color: primary),
                title: const Text(
                  ' Partner Perference ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PartnerPrefernces(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/sidebar/3.svg'),
                title: const Text(
                  'My Shortlist Profile ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IShortlistScreen(
                        newmatchdata: homedata.newMatches![0],
                        premiumMatches: homedata.premiumMatches![0],
                        isPaidMember: homedata.premiumMatches![0].isPaidMember!,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/sidebar/4.svg'),
                title: const Text(
                  ' Profile Viewed ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IViewedProfile(
                        newmatchdata: homedata.newMatches![0],
                        premiumMatches: homedata.premiumMatches![0],
                        isPaidMember: homedata.premiumMatches![0].isPaidMember!,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/sidebar/5.svg'),
                title: const Text(
                  ' Blocked Profile ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlockProfile(
                        newmatchdata: homedata.newMatches![0],
                        premiumMatches: homedata.premiumMatches![0],
                        isPaidMember: homedata.premiumMatches![0].isPaidMember!,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/sidebar/7.svg'),
                title: const Text(
                  ' Settings ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/sidebar/8.svg'),
                title: const Text(
                  ' About Us ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset('assets/sidebar/2.svg'),
                title: const Text(
                  ' Your Subcription ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xCC121212)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserPackageDetails(),
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'BlessLagna V.0.1',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ));
}
