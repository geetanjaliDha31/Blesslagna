import 'package:blesslagna/API/home_api/functionapi.dart';
import 'package:blesslagna/API/home_api/gethome.dart' as newMatch;
import 'package:blesslagna/API/home_api/getallmatch.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/widget/chating_screen.dart';
import 'package:blesslagna/screen/widget/profiledetails_screen.dart';
import 'package:blesslagna/screen/widget/skeleon/skeletonmatchpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchScreen extends ConsumerStatefulWidget {
  final newMatch.NewMatches? newmatchdata;
  final newMatch.PremiumMatches? premiumMatches;
  final bool? isPaidMember;


  const MatchScreen({
    super.key,
    this.newmatchdata,
    this.premiumMatches,
    this.isPaidMember,
  });

  @override
  ConsumerState<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  StateProvider typematchProvider = StateProvider((ref) => 'All');
  StateProvider matchlodaerProvider = StateProvider((ref) => true);

  GetAllMatchModel? homedata;

  Future callApi() async {
    homedata = await getallnmatch(ref: ref).whenComplete(() {
      if (mounted) {
        ref.watch(matchlodaerProvider.notifier).state = false;
      }
    });
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // final homedata = ref.watch(allMatchdataProvider);

    final loader = ref.watch(matchlodaerProvider);
    final type = ref.watch(typematchProvider);
    return RefreshIndicator(
      onRefresh: callApi,
      child: Scaffold(
          body: loader
              ? FirstCardSkeleton()
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              ref.watch(typematchProvider.notifier).state =
                                  'All';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: type == "All"
                                    ? primary
                                    : const Color(0xffF5F5F5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 5),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: type == "All"
                                          ? Colors.white
                                          : primary),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ref.watch(typematchProvider.notifier).state =
                                  'New';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: type == "New"
                                    ? primary
                                    : const Color(0xffF5F5F5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                child: Text(
                                  'New Match',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: type == "New"
                                          ? Colors.white
                                          : primary),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ref.watch(typematchProvider.notifier).state =
                                  'Premium';
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: type == "Premium"
                                    ? primary
                                    : const Color(0xffF5F5F5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  'Premium Match',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: type == "Premium"
                                          ? Colors.white
                                          : primary),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      //listview
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: type == "All"
                              ? homedata!.allProfiles!.length
                              : type == "New"
                                  ? homedata!.newMatches!.length
                                  : homedata!.premiumMatches!.length,
                          itemBuilder: (context, index) {
                            return matchCard(
                                comefrom: '',
                                newmatchdata: widget.newmatchdata,
                                premiumMatches: widget.premiumMatches,
                                isPaidMember: widget.isPaidMember,
                                ref: ref,
                                width: width,
                                context: context,
                                data: type == "All"
                                    ? homedata!.allProfiles![index]
                                    : type == "New"
                                        ? homedata!.newMatches![index]
                                        : homedata!.premiumMatches![index]);
                          })
                    ],
                  ),
                )),
    );
  }
}

// StateProvider shortlistapp = StateProvider((ref) => false);
Widget matchCard({
  // required Function fun,
  required comefrom,
  required data,
  required BuildContext context,
  required double width,
  required newmatchdata,
  required premiumMatches,
  required isPaidMember,
  required WidgetRef ref,
}) {
  SizeConfig().init(context);
  return InkWell(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileDetailsScreen(
          comefrom: "",
          id: data.matrimonialId.toString(),
          newmatchdata: newmatchdata,
          premiumMatches: premiumMatches,
          isPaidMember: isPaidMember,
        ),
      ),
    ),
    child: Stack(
      children: [
        Padding(
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: data.image.toString(),
                    key: UniqueKey(),
                    cacheManager: customCacheManager,
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
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
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(10),
                //           bottomLeft: Radius.circular(10)),
                //       image: DecorationImage(
                //           fit: BoxFit.fill,
                //           image: NetworkImage(
                //             data.image.toString(),
                //           ))),
                //   height: 200,
                //   width: 105,
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data.name} ${data.age} ",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: width / 2,
                          child: Text(
                            data.location.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff7d7d7d)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: width / 2,
                          child: Text(
                            data.matrimonialId.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff7d7d7d)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Cast : ${data.caste}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "Height : ${data.height}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 3),
                        SizedBox(
                          width: width / 2,
                          child: Text(
                            "Designation : ${data.designation}",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xcc000000)),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Userfunction().sendinterest(
                                  recipientid: data.matrimonialId.toString()),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/star.svg',
                                      colorFilter: ColorFilter.mode(
                                          primary, BlendMode.srcIn),
                                      height: 14,
                                      width: 14,
                                    ),
                                    Text(
                                      'Interest',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 2),
                            GestureDetector(
                              onTap: () {
                                data.firebaseid == ""
                                    ? toast("Sorry Not Connect")
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatingScreen(
                                                  photo: data.image,
                                                  name: data.name,
                                                  oppsitid: data.matrimonialId,
                                                  opossitefirebaseid:
                                                      data.firebaseid,
                                                )));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/chat2.svg',
                                      colorFilter: ColorFilter.mode(
                                          primary, BlendMode.srcIn),
                                      height: 14,
                                      width: 14,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                width: SizeConfig.blockSizeHorizontal! * 2),
                            GestureDetector(
                              onTap: () => Userfunction().blockprofile(
                                  recipientid: data.matrimonialId.toString()),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.block,
                                      color: primary,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      'Block',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
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
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
