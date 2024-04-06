import 'package:blesslagna/API/drawer_api/blockprofileapi.dart';
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
// BlockProfile

class BlockProfile extends ConsumerStatefulWidget {
  final NewMatches newmatchdata;
  final PremiumMatches premiumMatches;
  final bool isPaidMember;

  const BlockProfile({
    super.key,
    required this.newmatchdata,
    required this.premiumMatches,
    required this.isPaidMember,
  });

  @override
  ConsumerState<BlockProfile> createState() => _BlockProfileState();
}

class _BlockProfileState extends ConsumerState<BlockProfile> {
  StateProvider blockloaderProvider = StateProvider((ref) => true);
  Future callApi() async {
    await getiblockprofileprofile(ref: ref).whenComplete(
        () => ref.watch(blockloaderProvider.notifier).state = false);
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final blockprofiles = ref.watch(blockprofileProvider);
    final blockprofileempty = ref.watch(blockprofileemptyProvider);
    final loader = ref.watch(blockloaderProvider);
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
              'Blocked Profile',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, color: primary),
            ),
          ),
          body: loader
              ? const Center(child: CircularProgressIndicator())
              : blockprofileempty
                  ? const Center(child: Text('No Data Found'))
                  : SingleChildScrollView(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: blockprofiles.blockedProfile!.length,
                        itemBuilder: (context, index) {
                          var data = blockprofiles.blockedProfile![index];
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                              height: 180,
                                              width: 93,
                                            ),
                                            height: 180,
                                            width: 93,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            child: InkWell(
                                              onTap: () => Userfunction()
                                                  .unblockprofile(
                                                      recipientid: data
                                                          .matrimonialId
                                                          .toString()),
                                              child: const Text(
                                                'Unblock',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
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
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  data.location.toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff7d7d7d)),
                                                ),
                                              ),
                                              Text(
                                                data.matrimonialId.toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff7d7d7d)),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                "Cast : ${data.caste.toString()}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                "Height : ${data.height.toString()}",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                "Designation : ${data.designation.toString()}",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Color(0xcc000000),
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
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
                                                                color: primary),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                  GestureDetector(
                                                    onTap: () {
                                                      data.firebase
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
                                                                            photo:
                                                                                data.image.toString(),
                                                                            name:
                                                                                data.name.toString(),
                                                                            oppsitid:
                                                                                data.matrimonialId.toString(),
                                                                            opossitefirebaseid:
                                                                                data.firebase.toString(),
                                                                          )));
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
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
                                                                color: primary),
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
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
                                                                color: primary),
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
                            ),
                          );
                        },
                      ),
                    )),
    );
  }
}



// Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             // border: Border.all(width: 1, color: Colors.grey),
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: const [
//               BoxShadow(
//                   color: Color(
//                     0x3f000000,
//                   ), //New
//                   blurRadius: 1.0,
//                   offset: Offset(0, 0))
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(children: [
//                 Image.asset('assets/photo3.png'),
//                 const Positioned.fill(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Unblock',
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                   ),
//                 )
//               ]),
//               const Spacer(),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Dhruv Chopra  29",
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black),
//                       ),
//                       const Text(
//                         "Mumbai, Maharashtra",
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xff7d7d7d)),
//                       ),
//                       const SizedBox(height: 5),
//                       const Text(
//                         "Cast : Hindu\t\t\t\t\tSub-cast : Agri",
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black),
//                       ),
//                       const SizedBox(height: 3),
//                       const Text(
//                         "Height : 5.5 ft\t\t\tWieght : 5.5 ft",
//                         style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black),
//                       ),
//                       const SizedBox(height: 3),
//                       const Text(
//                         "Designation : Software Engineer",
//                         style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xcc000000)),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 5),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: const Color(0xffF5F5F5),
//                             ),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   'assets/star.svg',
//                                   color: primary,
//                                   height: 14,
//                                   width: 14,
//                                 ),
//                                 const SizedBox(width: 2),
//                                 Text(
//                                   'Interest',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w400,
//                                       color: primary),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 5),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: const Color(0xffF5F5F5),
//                             ),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(
//                                   'assets/chat2.svg',
//                                   color: primary,
//                                   height: 14,
//                                   width: 14,
//                                 ),
//                                 const SizedBox(width: 2),
//                                 Text(
//                                   'Chat',
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w400,
//                                       color: primary),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     ]),
//               ),
//             ],
//           ),
//         ),
//       ),