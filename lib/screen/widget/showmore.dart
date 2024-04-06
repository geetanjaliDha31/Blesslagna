import 'dart:developer';

import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sidebar_provider.dart';
import 'package:blesslagna/screen/navigationScreen/match_screen.dart';
import 'package:blesslagna/screen/profileupdateScreen/profile_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/packages_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowMoreScreen extends ConsumerStatefulWidget {
  final NewMatches? newmatchdata;
  final PremiumMatches? premiumMatches;
  final bool? isPaidMember;

  final data;
  const ShowMoreScreen({
    super.key,
    required this.data,
    this.premiumMatches,
    this.newmatchdata,
    this.isPaidMember,
  });

  @override
  ConsumerState<ShowMoreScreen> createState() => _ShowMoreScreenState();
}

class _ShowMoreScreenState extends ConsumerState<ShowMoreScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final userdetails = ref.watch(userdetailProvider);
    return Scaffold(
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
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  userdetails.basicDetailsArray![0].name.toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.black,
                )
              ],
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
            child: CircleAvatar(
              radius: 14,
              backgroundImage: NetworkImage(
                  userdetails.basicDetailsArray![0].image.toString()),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(CupertinoIcons.bell, color: primary),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 5),
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            log(widget.data.length.toString());
            return matchCard(
              comefrom: "show",
              ref: ref,
              width: width,
              context: context,
              newmatchdata: widget.newmatchdata,
              premiumMatches: widget.premiumMatches,
              isPaidMember: widget.isPaidMember,
              data: widget.data[index],
            );
          },
        ),
      ),
    );
  }
}
