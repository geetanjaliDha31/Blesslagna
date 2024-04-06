import 'package:blesslagna/API/drawer_api/myshortlistapi.dart';
import 'package:blesslagna/API/home_api/functionapi.dart';
import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:blesslagna/screen/widget/chating_screen.dart';
import 'package:blesslagna/screen/widget/profiledetails_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IShortlistScreen extends ConsumerStatefulWidget {
  final NewMatches newmatchdata;
  final PremiumMatches premiumMatches;
  final bool isPaidMember;

  const IShortlistScreen({
    super.key,
    required this.newmatchdata,
    required this.premiumMatches,
    required this.isPaidMember,
  });

  @override
  ConsumerState<IShortlistScreen> createState() => _IShortlistScreenState();
}

class _IShortlistScreenState extends ConsumerState<IShortlistScreen> {
  // ShortlistModel? shortlistdata;
  StateProvider shortlistloaderProvider = StateProvider((ref) => true);
  Future callApi() async {
    await getshortlistprofile(ref: ref).whenComplete(
        () => ref.watch(shortlistloaderProvider.notifier).state = false);
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(shortlistloaderProvider);
    final shortlist = ref.watch(shortlistprofileProvider);
    final shortlistempty = ref.watch(shortlistprofileemptyProvider);

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
            'I Shortlist Profile',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: primary),
          ),
        ),
        body: loader
            ? const Center(child: CircularProgressIndicator())
            : shortlistempty
                ? const Center(child: Text('No Data Found'))
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 30),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: shortlist.shortlistedProfile!.length,
                        itemBuilder: (context, index) {
                          var data = shortlist.shortlistedProfile![index];
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileDetailsScreen(
                                  comefrom: "",
                                  id: data.matrimonialId.toString(),
                                  newmatchdata: widget.newmatchdata,
                                  premiumMatches: widget.premiumMatches,
                                  isPaidMember: widget.isPaidMember,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // border: Border.all(width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl: data.image.toString(),
                                          key: UniqueKey(),
                                          cacheManager: customCacheManager,
                                          placeholder: (context, url) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: lightprimary,
                                            ),
                                            height: 185,
                                            width: 93,
                                          ),
                                          height: 185,
                                          width: 93,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
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
                                                Text(
                                                  data.location.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff7d7d7d)),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  data.matrimonialId.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff7d7d7d)),
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  child: Text(
                                                    "Designation : ${data.designation.toString()}",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xcc000000)),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                                horizontal: 8,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: const Color(
                                                              0xffF5F5F5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/star.svg',
                                                              colorFilter:
                                                                  ColorFilter.mode(
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
                                                                  fontSize: 12,
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
                                                                    builder:
                                                                        (context) =>
                                                                            ChatingScreen(
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
                                                                horizontal: 8,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: const Color(
                                                              0xffF5F5F5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/chat2.svg',
                                                              colorFilter:
                                                                  ColorFilter.mode(
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
                                                                  fontSize: 12,
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
                                                                horizontal: 8,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: const Color(
                                                              0xffF5F5F5),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.block,
                                                              color: primary,
                                                              size: 12,
                                                            ),
                                                            const SizedBox(
                                                                width: 2),
                                                            Text(
                                                              'Block',
                                                              style: TextStyle(
                                                                  fontSize: 12,
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
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          );
                        })),
      ),
    );
  }
}
