import 'package:blesslagna/API/drawer_api/iviewdprofile.dart';
import 'package:blesslagna/API/drawer_api/myviewdprofile.dart';
import 'package:blesslagna/API/home_api/functionapi.dart';
import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:blesslagna/screen/widget/chating_screen.dart';
import 'package:blesslagna/screen/widget/profiledetails_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IViewedProfile extends ConsumerStatefulWidget {
  final NewMatches newmatchdata;
  final PremiumMatches premiumMatches;
  final bool isPaidMember;

  const IViewedProfile({
    super.key,
    required this.newmatchdata,
    required this.premiumMatches,
    required this.isPaidMember,
  });

  @override
  ConsumerState<IViewedProfile> createState() => _IViewedProfileState();
}

class _IViewedProfileState extends ConsumerState<IViewedProfile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  StateProvider viewdloaderProvider = StateProvider((ref) => true);
  Future callApi() async {
    await getiviewprofileprofile(ref: ref).whenComplete(() async {
      await getmyviewprofileprofile(ref: ref).whenComplete(
          () => ref.watch(viewdloaderProvider.notifier).state = false);
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    callApi();
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
    final loader = ref.watch(viewdloaderProvider);
    final iviewdprofile = ref.watch(iviewedprofileProvider);
    final myviewdprofile = ref.watch(myviewedprofileProvider);
    final iviewdprofileempty = ref.watch(iviewedprofileemptyProvider);
    final myviewdprofileempty = ref.watch(myviewedprofileemptyProvider);

    return RefreshIndicator(
      onRefresh: callApi,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
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
          title: Text(
            'I Viewed Profile',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: primary),
          ),
        ),
        body: loader
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: [
                    TabBar(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        isScrollable: false,
                        labelColor: primary,
                        labelStyle: TextStyle(
                            color: primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 25),
                        indicatorColor: primary,
                        indicatorWeight: 5,
                        unselectedLabelColor: Colors.black,
                        controller: tabController,
                        tabs: const [
                          Tab(
                            text: "I Viewed Profile",
                          ),
                          Tab(
                            text: "My Viewd Profile",
                          ),
                        ]),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 76,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          iviewdprofileempty
                              ? const Center(
                                  child: Text("No Profile You Viewed Yet"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount:
                                      iviewdprofile.viewedProfile!.length,
                                  itemBuilder: (context, index) {
                                    var data =
                                        iviewdprofile.viewedProfile![index];
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileDetailsScreen(
                                            comefrom: "",
                                            id: data.matrimonialId.toString(),
                                            newmatchdata: widget.newmatchdata,
                                            premiumMatches:
                                                widget.premiumMatches,
                                            isPaidMember: widget.isPaidMember,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(width: 1, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color(
                                                    0x3f000000,
                                                  ), //New
                                                  blurRadius: 1.0,
                                                  offset: Offset(0, 0))
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      data.image.toString(),
                                                  key: UniqueKey(),
                                                  cacheManager:
                                                      customCacheManager,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: lightprimary,
                                                    ),
                                                    height: 200,
                                                    width: 93,
                                                  ),
                                                  height: 200,
                                                  width: 93,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 13,
                                                          vertical: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${data.name.toString()}  ${data.age.toString()}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                        child: Text(
                                                          data.location
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: Color(
                                                                  0xff7d7d7d)),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                        child: Text(
                                                          data.matrimonialId
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: Color(
                                                                  0xff7d7d7d)),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "Cast : ${data.caste.toString()}",
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        "Height : ${data.height.toString()}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2,
                                                        child: Text(
                                                          "Designation : ${data.designation.toString()}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: Color(
                                                                  0xcc000000)),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () => Userfunction()
                                                                .sendinterest(
                                                                    recipientid: data
                                                                        .matrimonialId
                                                                        .toString()),
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: const Color(
                                                                    0xffF5F5F5),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/star.svg',
                                                                    colorFilter: ColorFilter.mode(
                                                                        primary,
                                                                        BlendMode
                                                                            .srcIn),
                                                                    height: 14,
                                                                    width: 14,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 2),
                                                                  Text(
                                                                    'Interest',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            primary),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 6),
                                                          GestureDetector(
                                                            onTap: () {
                                                              data.firebaseid
                                                                          .toString() ==
                                                                      ""
                                                                  ? toast(
                                                                      "Sorry Not Connect")
                                                                  : Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ChatingScreen(
                                                                                photo: data.image.toString(),
                                                                                name: data.name.toString(),
                                                                                oppsitid: data.matrimonialId.toString(),
                                                                                opossitefirebaseid: data.firebaseid.toString(),
                                                                              )));
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: const Color(
                                                                    0xffF5F5F5),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/chat2.svg',
                                                                    colorFilter: ColorFilter.mode(
                                                                        primary,
                                                                        BlendMode
                                                                            .srcIn),
                                                                    height: 14,
                                                                    width: 14,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 2),
                                                                  Text(
                                                                    'Chat',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            primary),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 6),
                                                          GestureDetector(
                                                            onTap: () => Userfunction()
                                                                .blockprofile(
                                                                    recipientid: data
                                                                        .matrimonialId
                                                                        .toString()),
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: const Color(
                                                                    0xffF5F5F5),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.block,
                                                                    color:
                                                                        primary,
                                                                    size: 12,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 2),
                                                                  Text(
                                                                    'Block',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            primary),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          myviewdprofileempty
                              ? const Center(
                                  child: Text('No One View Your Profile'))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      myviewdprofile.viewedProfile!.length,
                                  itemBuilder: (context, index) {
                                    var data =
                                        myviewdprofile.viewedProfile![index];
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileDetailsScreen(
                                            comefrom: "",
                                            id: data.matrimonialId.toString(),
                                            newmatchdata: widget.newmatchdata,
                                            premiumMatches:
                                                widget.premiumMatches,
                                            isPaidMember: widget.isPaidMember,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            // border: Border.all(width: 1, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color(
                                                    0x3f000000,
                                                  ), //New
                                                  blurRadius: 1.0,
                                                  offset: Offset(0, 0))
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      data.image.toString(),
                                                    ),
                                                  ),
                                                ),
                                                height: 155,
                                                width: 93,
                                              ),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${data.name.toString()}  ${data.age.toString()}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2,
                                                        child: Text(
                                                          data.location
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xff7d7d7d)),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Text(
                                                          data.matrimonialId
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xff7d7d7d)),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        "Cast : ${data.caste.toString()}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                        "Height : ${data.height.toString()}",
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const SizedBox(height: 3),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2,
                                                        child: Text(
                                                          "Designation : ${data.designation.toString()}",
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xcc000000)),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () => Userfunction()
                                                                .sendinterest(
                                                                    recipientid: data
                                                                        .matrimonialId
                                                                        .toString()),
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: const Color(
                                                                    0xffF5F5F5),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/star.svg',
                                                                    colorFilter: ColorFilter.mode(
                                                                        primary,
                                                                        BlendMode
                                                                            .srcIn),
                                                                    height: 14,
                                                                    width: 14,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 2),
                                                                  Text(
                                                                    'Interest',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            primary),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 6),
                                                          GestureDetector(
                                                            onTap: () {
                                                              data.firebaseid
                                                                          .toString() ==
                                                                      ""
                                                                  ? toast(
                                                                      "Sorry Not Connect")
                                                                  : Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ChatingScreen(
                                                                                photo: data.image,
                                                                                name: data.name,
                                                                                oppsitid: data.matrimonialId.toString(),
                                                                                opossitefirebaseid: data.firebaseid.toString(),
                                                                              )));
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: const Color(
                                                                    0xffF5F5F5),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/chat2.svg',
                                                                    colorFilter: ColorFilter.mode(
                                                                        primary,
                                                                        BlendMode
                                                                            .srcIn),
                                                                    height: 14,
                                                                    width: 14,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 2),
                                                                  Text(
                                                                    'Chat',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            primary),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 6),
                                                          GestureDetector(
                                                            onTap: () => Userfunction()
                                                                .blockprofile(
                                                                    recipientid: data
                                                                        .matrimonialId
                                                                        .toString()),
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: const Color(
                                                                    0xffF5F5F5),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.block,
                                                                    color:
                                                                        primary,
                                                                    size: 12,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 2),
                                                                  Text(
                                                                    'Block',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color:
                                                                            primary),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
