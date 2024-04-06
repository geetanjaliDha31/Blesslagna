import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/profileupdateScreen/basicdetailsupdate.dart';
import 'package:blesslagna/screen/profileupdateScreen/educationupdate.dart';
import 'package:blesslagna/screen/profileupdateScreen/familiydetailsupdate.dart';
import 'package:blesslagna/screen/profileupdateScreen/liftestyledetailsupdate.dart';
import 'package:blesslagna/screen/profileupdateScreen/locationdetailupdate.dart';
import 'package:blesslagna/screen/profileupdateScreen/photoscreen.dart';
import 'package:blesslagna/screen/profileupdateScreen/profilepermission.dart';
import 'package:blesslagna/screen/profileupdateScreen/religiousdetailsupdate.dart';
import 'package:blesslagna/screen/sidebar_screen/packages_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final userdetails = ref.watch(userdetailProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 34),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        userdetails.basicDetailsArray![0].image.toString()),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userdetails.basicDetailsArray![0].name.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: primary),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        userdetails.basicDetailsArray![0].matrimonialId
                            .toString(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 3),
                      InkWell(
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
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              TabBar(
                  isScrollable: true,
                  labelColor: primary,
                  labelStyle: TextStyle(
                      color: primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  indicatorColor: primary,
                  indicatorWeight: 5,
                  unselectedLabelColor: Colors.black,
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: "Basic",
                    ),
                    Tab(
                      text: "Religious",
                    ),
                    Tab(
                      text: "Education",
                    ),
                    Tab(
                      text: "Lifestyle",
                    ),
                    Tab(
                      text: "Location",
                    ),
                    Tab(
                      text: "Family",
                    ),
                    Tab(
                      text: "Photo",
                    ),
                    Tab(
                      text: "Profile Permission",
                    ),
                  ]),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 72,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    BasicDetailsUpdate(),
                    ReligiousDetailUpdate(),
                    EducationDetailsUpdate(),
                    LifestyleDetailsUpdate(),
                    LocationDetailsUpdate(),
                    FamiliyDetailUpdate(),
                    PhotoScreen(),
                    ProfilPermission(),
                  ],
                  // children: [
                  //   const BasicDetails(comefrom: ''),
                  //   const Religiousdetails(comefrom: ''),
                  //   const EducationDetails(comefrom: ''),
                  //   const LifeStyleDetails(comefrom: ''),
                  //   const LocationDetails(comefrom: ''),
                  //   const FamilyDetails(comefrom: ''),
                  //   PhotoScreen(),
                  //   ProfilPermission()
                  // ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
