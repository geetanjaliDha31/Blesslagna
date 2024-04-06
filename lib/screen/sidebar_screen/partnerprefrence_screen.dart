import 'package:blesslagna/color.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/basicdetailspp.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/educationdetailspp.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/lifestyledetails.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/religiondetailspp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnerPrefernces extends ConsumerStatefulWidget {
  const PartnerPrefernces({super.key});

  @override
  ConsumerState<PartnerPrefernces> createState() => _PartnerPreferncesState();
}

class _PartnerPreferncesState extends ConsumerState<PartnerPrefernces>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
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
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
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
            title: Text('Partner Prefernces',
                style: TextStyle(
                    color: primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1))),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
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
                      text: "Location",
                    ),
                    Tab(
                      text: "Education",
                    ),
                  ]),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 72,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    BasicDetailsPP(),
                    ReligionDetailsPP(),
                    LifestyleDetailsPP(),
                    EducationDetailsPP(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
