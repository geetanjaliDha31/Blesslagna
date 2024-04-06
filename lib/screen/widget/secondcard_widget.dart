import 'package:blesslagna/API/home_api/functionapi.dart';
import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/widget/profiledetails_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecondCard extends ConsumerStatefulWidget {
  final PremiumMatches preminumatches;
  final NewMatches newmatchdata;
  final bool isPaidMemeber;
  const SecondCard({
    super.key,
    required this.preminumatches,
    required this.newmatchdata,
    required this.isPaidMemeber,
  });

  @override
  ConsumerState<SecondCard> createState() => _SecondCardState();
}

class _SecondCardState extends ConsumerState<SecondCard> {
  StateProvider shortlistapp = StateProvider((ref) => false);
  StateProvider interestapp = StateProvider((ref) => false);
  @override
  Widget build(BuildContext context) {
    final appshortlist = ref.watch(shortlistapp);
    final appinterestlist = ref.watch(interestapp);
    SizeConfig().init(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailsScreen(
              comefrom: "",
              id: widget.preminumatches.matrimonialId.toString(),
              newmatchdata: widget.newmatchdata,
              premiumMatches: widget.preminumatches,
              isPaidMember: widget.isPaidMemeber,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            SizedBox(
              height: 230,
              child: Stack(
                children: [
                  Container(
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 1],
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.7, 1],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.preminumatches.image.toString(),
                      key: UniqueKey(),
                      cacheManager: customCacheManager,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightprimary,
                        ),
                        height: 200,
                        width: 180,
                      ),
                      height: 200,
                      width: 180,
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 24),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    "${widget.preminumatches.name}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  " | ${widget.preminumatches.age} | ${widget.preminumatches.height}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${widget.preminumatches.location}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 0.5),
                            ),
                            Text(
                              widget.preminumatches.matrimonialId.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 0.5),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                left: 2,
                top: 2,
                child: widget.preminumatches.isPaidMember!
                    ? SvgPicture.asset(
                        'assets/premium.svg',
                      )
                    : const SizedBox.shrink()),
            Positioned(
              bottom: 8,
              left: 25,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      ref.watch(shortlistapp.notifier).state = true;
                      setState(() {});
                      Userfunction().shortlistprofile(
                          recipientid:
                              widget.preminumatches.matrimonialId.toString());
                    },
                    child: widget.preminumatches.isshortlisted! || appshortlist
                        ? CircleAvatar(
                            backgroundColor: primary,
                            child: Icon(CupertinoIcons.heart_fill,
                                color: Colors.white))
                        : CircleAvatar(
                            backgroundColor: primary,
                            child: SvgPicture.asset('assets/heart.svg'),
                          ),
                  ),
                  const SizedBox(width: 2),
                  InkWell(
                    onTap: () {
                      ref.watch(interestapp.notifier).state = true;
                      setState(() {});
                      Userfunction().sendinterest(
                          recipientid:
                              widget.preminumatches.matrimonialId.toString());
                    },
                    child: CircleAvatar(
                      backgroundColor: primary,
                      child: widget.preminumatches.isinterest! ||
                              appinterestlist
                          ? Icon(CupertinoIcons.star_fill, color: Colors.white)
                          : SvgPicture.asset(
                              'assets/star.svg',
                            ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  InkWell(
                    onTap: () => Userfunction().blockprofile(
                        recipientid:
                            widget.preminumatches.matrimonialId.toString()),
                    child: CircleAvatar(
                      backgroundColor: primary,
                      child: const Icon(
                        Icons.block,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 10),
    //   child: InkWell(
    //     onTap: () => Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => ProfileDetailsScreen(
    //                   id: preminumatches.matrimonialId.toString(),
    //                 ))),
    //     child: Container(
    //         height: 230,
    //         width: 195,
    //         decoration: const BoxDecoration(
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(20),
    //               topRight: Radius.circular(20),
    //               bottomLeft: Radius.circular(5),
    //               bottomRight: Radius.circular(5)),
    //           color: Colors.white,
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.grey,
    //               offset: Offset(0.0, 1.0), //(x,y)
    //               blurRadius: 6.0,
    //             )
    //           ],
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Stack(
    //               children: [
    //                 SizedBox(
    //                   height: SizeConfig.blockSizeVertical! * 18,
    //                   child: Container(
    //                     height: SizeConfig.blockSizeVertical! * 18,
    //                     width: SizeConfig.blockSizeHorizontal! * 50,
    //                     decoration: BoxDecoration(
    //                       borderRadius: const BorderRadius.only(
    //                           topLeft: Radius.circular(20),
    //                           topRight: Radius.circular(20)),
    //                     ),
    //                     child: Image(
    //                       image: NetworkImage(preminumatches.image.toString()),
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                 ),
    //                 preminumatches.isPaidMember!
    //                     ? Positioned(
    //                         left: 8,
    //                         top: 2,
    //                         child: SvgPicture.asset('assets/premium.svg'))
    //                     : const SizedBox.shrink(),
    //                 Positioned(
    //                     bottom: 0,
    //                     left: 32,
    //                     child: Row(
    //                       children: [
    //                         InkWell(
    //                           onTap: () => Userfunction().shortlistprofile(
    //                               recipientid:
    //                                   preminumatches.matrimonialId.toString()),
    //                           child: CircleAvatar(
    //                             backgroundColor: primary,
    //                             child: preminumatches.isinterest!
    //                                 ? Icon(
    //                                     CupertinoIcons.heart_fill,
    //                                     color: Colors.white,
    //                                   )
    //                                 : SvgPicture.asset('assets/heart.svg'),
    //                           ),
    //                         ),
    //                         const SizedBox(width: 2),
    //                         InkWell(
    //                           onTap: () => Userfunction().sendinterest(
    //                               recipientid:
    //                                   preminumatches.matrimonialId.toString()),
    //                           child: CircleAvatar(
    //                             backgroundColor: primary,
    //                             child: preminumatches.isshortlisted!
    //                                 ? Icon(CupertinoIcons.star_fill,
    //                                     color: Colors.white)
    //                                 : SvgPicture.asset('assets/star.svg'),
    //                           ),
    //                         ),
    //                         const SizedBox(width: 2),
    //                         InkWell(
    //                           onTap: () => Userfunction().blockprofile(
    //                               recipientid:
    //                                   preminumatches.matrimonialId.toString()),
    //                           child: CircleAvatar(
    //                               backgroundColor: primary,
    //                               child: const Icon(
    //                                 Icons.block,
    //                                 color: Colors.white,
    //                               )

    //                               // SvgPicture.asset('assets/chat2.svg'),
    //                               ),
    //                         ),
    //                       ],
    //                     ))
    //               ],
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 8),
    //               child: Text(
    //                 "${preminumatches.name} | ${preminumatches.age}  | ${preminumatches.height}'",
    //                 style: const TextStyle(
    //                     fontSize: 14,
    //                     fontWeight: FontWeight.w400,
    //                     color: Colors.black,
    //                     letterSpacing: 0.5),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 8),
    //               child: Text(
    //                 "${preminumatches.location}",
    //                 style: const TextStyle(
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w400,
    //                     color: Color(0x99000000),
    //                     letterSpacing: 0.5),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 8),
    //               child: Text(
    //                 "${preminumatches.matrimonialId}",
    //                 style: const TextStyle(
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w400,
    //                     color: Colors.black,
    //                     letterSpacing: 0.5),
    //               ),
    //             ),
    //           ],
    //         )),
    //   ),
    // );
  }
}
