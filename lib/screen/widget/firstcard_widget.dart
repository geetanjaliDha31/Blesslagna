import 'dart:developer';

import 'package:blesslagna/API/home_api/functionapi.dart';
import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/widget/profiledetails_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstCard extends ConsumerStatefulWidget {
  final NewMatches newmatchdata;
  final PremiumMatches premiumMatches;
  final bool isPaidMember;
  const FirstCard({
    super.key,
    required this.newmatchdata,
    required this.premiumMatches,
    required this.isPaidMember,
  });

  @override
  ConsumerState<FirstCard> createState() => _FirstCardState();
}

class _FirstCardState extends ConsumerState<FirstCard> {
  StateProvider shortlistapp = StateProvider((ref) => false);
  StateProvider interestapp = StateProvider((ref) => false);
  @override
  Widget build(BuildContext context) {
    final appshortlist = ref.watch(shortlistapp);
    final appinterestlist = ref.watch(interestapp);
    return InkWell(
      onTap: () {
        print(widget.isPaidMember);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileDetailsScreen(
              comefrom: "",
              id: widget.newmatchdata.matrimonialId.toString(),
              newmatchdata: widget.newmatchdata,
              premiumMatches: widget.premiumMatches,
              isPaidMember: widget.isPaidMember,
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
                      imageUrl: widget.newmatchdata.image.toString(),
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
                                    "${widget.newmatchdata.name}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  " | ${widget.newmatchdata.age} | ${widget.newmatchdata.height}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${widget.newmatchdata.location}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 0.5),
                            ),
                            Text(
                              widget.newmatchdata.matrimonialId.toString(),
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
                child: widget.newmatchdata.isPaidMember!
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
                              widget.newmatchdata.matrimonialId.toString());
                    },
                    child: widget.newmatchdata.isshortlisted! || appshortlist
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
                              widget.newmatchdata.matrimonialId.toString());
                    },
                    child: CircleAvatar(
                      backgroundColor: primary,
                      child: widget.newmatchdata.isinterest! || appinterestlist
                          ? Icon(CupertinoIcons.star_fill, color: Colors.white)
                          : SvgPicture.asset(
                              'assets/star.svg',
                            ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  InkWell(
                    onTap: () {
                      log('come');
                      Userfunction().blockprofile(
                          recipientid:
                              widget.newmatchdata.matrimonialId.toString());
                    },
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
            ),
          ],
        ),
      ),
    );
  }
}

// class FirstCard extends ConsumerWidget {
//   final NewMatches newmatchdata;
//   const FirstCard({super.key, required this.newmatchdata});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appshortlist = ref.watch(shortlistapp);
//     return InkWell(
//       onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => ProfileDetailsScreen(
//                     id: newmatchdata.matrimonialId.toString(),
//                   ))),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         child: Stack(children: [
//           SizedBox(
//             height: 230,
//             child: Stack(
//               children: [
//                 Container(
//                   height: 200,
//                   width: 180,
//                   // foregroundDecoration: const BoxDecoration(
//                   //   gradient: LinearGradient(
//                   //     colors: [
//                   //       Colors.transparent,
//                   //       Colors.black,
//                   //     ],
//                   //     begin: Alignment.topCenter,
//                   //     end: Alignment.bottomCenter,
//                   //     stops: [0.5, 1],
//                   //   ),
//                   // ),
//                   decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [
//                           Colors.transparent,
//                           Colors.black,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         stops: [0.5, 1],
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(newmatchdata.image.toString()))),
//                   child: Align(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 24),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: 70,
//                                   child: Text(
//                                     "${newmatchdata.name}",
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 Text(
//                                   " | ${newmatchdata.age} | ${newmatchdata.height}",
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               "${newmatchdata.location}",
//                               style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.white,
//                                   letterSpacing: 0.5),
//                             ),
//                             Text(
//                               newmatchdata.matrimonialId.toString(),
//                               style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.white,
//                                   letterSpacing: 0.5),
//                             ),
//                           ]),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Positioned(
//           //     right: 2,
//           //     top: 2,
//           //     child: InkWell(
//           //         onTap: () => Userfunction().blockprofile(
//           //             recipientid: newmatchdata.matrimonialId.toString()),
//           //         child: const Padding(
//           //           padding: EdgeInsets.all(8.0),
//           //           child: Icon(Icons.block),
//           //         ))),
//           Positioned(
//               left: 2,
//               top: 2,
//               child: newmatchdata.isPaidMember!
//                   ? SvgPicture.asset(
//                       'assets/premium.svg',
//                     )
//                   : const SizedBox.shrink()),
//           Positioned(
//               bottom: 8,
//               left: 25,
//               child: Row(
//                 children: [
//                   InkWell(
//                     onTap: () => Userfunction().shortlistprofile(
//                         recipientid: newmatchdata.matrimonialId.toString()),
//                     child: newmatchdata.isinterest!
//                         ? CircleAvatar(
//                             backgroundColor: primary,
//                             child: Icon(CupertinoIcons.heart_fill,
//                                 color: Colors.white))
//                         : CircleAvatar(
//                             backgroundColor: primary,
//                             child: SvgPicture.asset('assets/heart.svg'),
//                           ),
//                   ),
//                   const SizedBox(width: 2),
//                   InkWell(
//                     onTap: () {
//                       ref.watch(shortlistapp.notifier).state = true;
//                       Userfunction().sendinterest(
//                           recipientid: newmatchdata.matrimonialId.toString());
//                     },
//                     child: CircleAvatar(
//                       backgroundColor: primary,
//                       child: newmatchdata.isshortlisted! || appshortlist
//                           ? Icon(CupertinoIcons.star_fill, color: Colors.white)
//                           : SvgPicture.asset(
//                               'assets/star.svg',
//                             ),
//                     ),
//                   ),
//                   const SizedBox(width: 2),
//                   InkWell(
//                     onTap: () => Userfunction().blockprofile(
//                         recipientid: newmatchdata.matrimonialId.toString()),
//                     child: CircleAvatar(
//                         backgroundColor: primary,
//                         child: const Icon(
//                           Icons.block,
//                           color: Colors.white,
//                         )),
//                   ),
//                 ],
//               ))
//         ]),
//       ),
//     );
//   }
// }
