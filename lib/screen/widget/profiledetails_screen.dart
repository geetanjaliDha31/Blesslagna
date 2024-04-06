import 'dart:developer';

import 'package:blesslagna/API/home_api/functionapi.dart';
import 'package:blesslagna/API/home_api/gethome.dart';

import 'package:blesslagna/API/profile_api/profileviewapi.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/widget/chating_screen.dart';
import 'package:blesslagna/screen/widget/expanison.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blesslagna/provider/sizedconflig.dart';

StateProvider currentimgProvider = StateProvider((ref) => 0);

class ProfileDetailsScreen extends ConsumerStatefulWidget {
  final String id, comefrom;
  final NewMatches newmatchdata;
  final PremiumMatches premiumMatches;
  final bool isPaidMember;

  const ProfileDetailsScreen({
    super.key,
    required this.id,
    required this.comefrom,
    required this.newmatchdata,
    required this.premiumMatches,
    required this.isPaidMember,
  });

  @override
  ConsumerState<ProfileDetailsScreen> createState() =>
      _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends ConsumerState<ProfileDetailsScreen> {
  StateProvider profileloaderProvider = StateProvider((ref) => true);
  StateProvider shortlistapp = StateProvider((ref) => false);
  StateProvider interestapp = StateProvider((ref) => false);

  List recipteimagedata = [];
  void callApi() async {
    Userfunction().addviewedprofile(recipientid: widget.id);
    await getreciptprofile(id: widget.id, ref: ref).whenComplete(() {
      final userdata = ref.watch(recipteuSerProvider);
      if (userdata.basicDetailsArray![0].photo1 != '') {
        recipteimagedata.add(userdata.basicDetailsArray![0].image);
      }
      if (userdata.basicDetailsArray![0].photo2 != '') {
        recipteimagedata.add(userdata.basicDetailsArray![0].photo2);
      }
      if (userdata.basicDetailsArray![0].photo3 != '') {
        recipteimagedata.add(userdata.basicDetailsArray![0].photo3);
      }
      if (userdata.basicDetailsArray![0].photo4 != '') {
        recipteimagedata.add(userdata.basicDetailsArray![0].photo4);
      }

      ref.watch(profileloaderProvider.notifier).state = false;
    });
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appshortlist = ref.watch(shortlistapp);
    final appinterestlist = ref.watch(interestapp);

    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    final loader = ref.watch(profileloaderProvider);
    final userdata = ref.watch(recipteuSerProvider);

    return Scaffold(
      body: loader
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      options: CarouselOptions(
                          height: SizeConfig.blockSizeVertical! * 50,
                          aspectRatio: 1 / 1,
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 10),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.easeInOut,
                          enlargeCenterPage: true,
                          scrollPhysics: recipteimagedata.length > 1
                              ? const ScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            ref.watch(currentimgProvider.notifier).state =
                                index;
                          }),
                      items: recipteimagedata.map((i) {
                        return Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 450,
                            child: Container(
                              height: 380,
                              width: width,
                              child: Image.network(
                                i.toString(),
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                  const SizedBox(height: 10),
                  widget.comefrom != "My" && widget.isPaidMember != true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                ref.watch(shortlistapp.notifier).state = true;
                                setState(() {});
                                Userfunction().shortlistprofile(
                                    recipientid:
                                        widget.newmatchdata.matrimonialId ??
                                            ''.toString());
                              },
                              child: widget.newmatchdata.isshortlisted! ||
                                      appshortlist
                                  ? CircleAvatar(
                                      backgroundColor: primary,
                                      child: Icon(CupertinoIcons.heart_fill,
                                          color: Colors.white))
                                  : CircleAvatar(
                                      backgroundColor: primary,
                                      child: SvgPicture.asset(
                                        'assets/heart.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                      radius: 25,
                                    ),
                            ),
                            const SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                ref.watch(interestapp.notifier).state = true;
                                setState(() {});
                                Userfunction().sendinterest(
                                    recipientid: widget
                                        .newmatchdata.matrimonialId
                                        .toString());
                              },
                              child: CircleAvatar(
                                  backgroundColor: primary,
                                  child: widget.newmatchdata.isinterest! ||
                                          appinterestlist
                                      ? Icon(CupertinoIcons.star_fill,
                                          color: Colors.white)
                                      : SvgPicture.asset(
                                          'assets/star.svg',
                                          height: 20,
                                          width: 20,
                                        ),
                                  radius: 25),
                            ),
                            const SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                log('come');
                                Userfunction().blockprofile(
                                    recipientid: widget
                                        .newmatchdata.matrimonialId
                                        .toString());
                              },
                              child: CircleAvatar(
                                backgroundColor: primary,
                                child: const Icon(
                                  Icons.block,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                radius: 25,
                              ),
                            ),
                            SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatingScreen(
                                      photo: userdata
                                          .basicDetailsArray![0].image
                                          .toString(),
                                      name: userdata.basicDetailsArray![0].name
                                          .toString(),
                                      oppsitid: userdata
                                          .basicDetailsArray![0].matrimonialId
                                          .toString(),
                                      opossitefirebaseid: userdata
                                          .basicDetailsArray![0].firebaseId
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: primary,
                                child: SvgPicture.asset(
                                  'assets/chat2.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  widget.comefrom != "My" && widget.isPaidMember
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                ref.watch(shortlistapp.notifier).state = true;
                                setState(() {});
                                Userfunction().shortlistprofile(
                                    recipientid:
                                        widget.premiumMatches.matrimonialId ??
                                            ''.toString());
                              },
                              child: widget.premiumMatches.isshortlisted! ||
                                      appshortlist
                                  ? CircleAvatar(
                                      backgroundColor: primary,
                                      child: Icon(CupertinoIcons.heart_fill,
                                          color: Colors.white))
                                  : CircleAvatar(
                                      backgroundColor: primary,
                                      child: SvgPicture.asset(
                                        'assets/heart.svg',
                                        height: 20,
                                        width: 20,
                                      ),
                                      radius: 25,
                                    ),
                            ),
                            const SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                ref.watch(interestapp.notifier).state = true;
                                setState(() {});
                                Userfunction().sendinterest(
                                    recipientid: widget
                                        .premiumMatches.matrimonialId
                                        .toString());
                              },
                              child: CircleAvatar(
                                  backgroundColor: primary,
                                  child: widget.premiumMatches.isinterest! ||
                                          appinterestlist
                                      ? Icon(CupertinoIcons.star_fill,
                                          color: Colors.white)
                                      : SvgPicture.asset(
                                          'assets/star.svg',
                                          height: 20,
                                          width: 20,
                                        ),
                                  radius: 25),
                            ),
                            const SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                log('come');
                                Userfunction().blockprofile(
                                    recipientid: widget
                                        .premiumMatches.matrimonialId
                                        .toString());
                              },
                              child: CircleAvatar(
                                backgroundColor: primary,
                                child: const Icon(
                                  Icons.block,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                radius: 25,
                              ),
                            ),
                            SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatingScreen(
                                      photo: userdata
                                          .basicDetailsArray![0].image
                                          .toString(),
                                      name: userdata.basicDetailsArray![0].name
                                          .toString(),
                                      oppsitid: userdata
                                          .basicDetailsArray![0].matrimonialId
                                          .toString(),
                                      opossitefirebaseid: userdata
                                          .basicDetailsArray![0].firebaseId
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: primary,
                                child: SvgPicture.asset(
                                  'assets/chat2.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      text: TextSpan(
                        text: userdata.basicDetailsArray![0].name.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  " | ${userdata.basicDetailsArray![0].age.toString()} | ${userdata.basicDetailsArray![0].height.toString()} ",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff636363))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${userdata.basicDetailsArray![0].matrimonialId.toString()} | ${userdata.eduOccupationArray![0].occupation.toString()}",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff636363)),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic Details',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        // SvgPicture.asset('assets/linesmall.svg'),
                        const SizedBox(height: 14),
                        BasicDetails(
                          id: widget.id,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Religion Details',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        const SizedBox(height: 14),
                        Religion()
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Education Details',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        const SizedBox(height: 14),
                        Education()
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LifeStyle Details',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        const SizedBox(height: 14),
                        LifeStyle()
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location Details',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        const SizedBox(height: 14),
                        Location()
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Family Details',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        const SizedBox(height: 14),
                        Familyexpansion()
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Partner Preference ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        const SizedBox(height: 14),
                        Partnerprefrenceexpansion()
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
