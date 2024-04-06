import 'package:blesslagna/API/home_api/functionapi.dart';
import 'package:blesslagna/API/home_api/getrequestapi.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/widget/chating_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecevideInterest extends ConsumerStatefulWidget {
  final List<ReceviedAcceptedSentArray> accept;
  final List<ReceviedRejectedSentArray> reject;
  final List<ReceviedPendingSentArray> pending;
  final Function call;
  const RecevideInterest(
      {super.key,
      required this.accept,
      required this.pending,
      required this.call,
      required this.reject});

  @override
  ConsumerState<RecevideInterest> createState() => _RecevideInterestState();
}

class _RecevideInterestState extends ConsumerState<RecevideInterest> {
  StateProvider typerequestProvider = StateProvider((ref) => 'Accept');
  @override
  Widget build(BuildContext context) {
    final type = ref.watch(typerequestProvider);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    ref.watch(typerequestProvider.notifier).state = 'Accept';
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          type == "Accept" ? primary : const Color(0xffF5F5F5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 5),
                      child: Text(
                        'Accepted',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: type == "Accept" ? Colors.white : primary,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.watch(typerequestProvider.notifier).state = 'Reject';
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          type == "Reject" ? primary : const Color(0xffF5F5F5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Text(
                        'Rejected',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: type == "Reject" ? Colors.white : primary,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.watch(typerequestProvider.notifier).state = 'Pending';
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          type == "Pending" ? primary : const Color(0xffF5F5F5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: type == "Pending" ? Colors.white : primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            type != "Accept"
                ? SizedBox.shrink()
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.accept.length,
                    itemBuilder: (context, index) {
                      var data = widget.accept[index];
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
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
                                      height: 198,
                                      width: 105,
                                    ),
                                    height: 198,
                                    width: 105,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data.name} ${data.age}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
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
                                        Text(
                                          data.matrimonialId.toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff7d7d7d)),
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
                                            "Designation : ${data.firebaseid}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xcc000000)),
                                          ),
                                        ),
                                        SizedBox(height: 14),
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
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xffF5F5F5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/star.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              primary,
                                                              BlendMode.srcIn),
                                                      height: 14,
                                                      width: 14,
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      'Interest',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: primary),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            GestureDetector(
                                              onTap: () {
                                                data.firebaseid.toString() == ""
                                                    ? toast("Sorry Not Connect")
                                                    : Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChatingScreen(
                                                                  photo: data
                                                                      .image
                                                                      .toString(),
                                                                  name: data
                                                                      .name
                                                                      .toString(),
                                                                  oppsitid: data
                                                                      .matrimonialId
                                                                      .toString(),
                                                                  opossitefirebaseid: data
                                                                      .firebaseid
                                                                      .toString(),
                                                                )));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xffF5F5F5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/chat2.svg',
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              primary,
                                                              BlendMode.srcIn),
                                                      height: 14,
                                                      width: 14,
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      'Chat',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xffF5F5F5),
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
                                                          fontWeight:
                                                              FontWeight.w400,
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
                          const SizedBox(height: 20),
                        ],
                      );
                    }),
            type != "Reject"
                ? SizedBox.shrink()
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.reject.length,
                    itemBuilder: (context, index) {
                      var data = widget.reject[index];
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
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
                                      height: 198,
                                      width: 105,
                                    ),
                                    height: 198,
                                    width: 105,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data.name} ${data.age}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
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
                                        Text(
                                          data.matrimonialId.toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff7d7d7d)),
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
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xcc000000)),
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }),
            type != "Pending"
                ? SizedBox.shrink()
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.pending.length,
                    itemBuilder: (context, index) {
                      var data = widget.pending[index];
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
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
                                      height: 198,
                                      width: 105,
                                    ),
                                    height: 198,
                                    width: 105,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data.name} ${data.age}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
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
                                        Text(
                                          data.matrimonialId.toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff7d7d7d)),
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
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xcc000000)),
                                          ),
                                        ),
                                        SizedBox(height: 14),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () => UserdoAction()
                                                  .acceptsentinterest(
                                                      recipientid: data
                                                          .matrimonialId
                                                          .toString())
                                                  .whenComplete(() => setState(
                                                        () {
                                                          widget.call;
                                                        },
                                                      )),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xffF5F5F5),
                                                ),
                                                child: Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.green),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            GestureDetector(
                                              onTap: () => UserdoAction()
                                                  .rejectsentinterest(
                                                      recipientid: data
                                                          .matrimonialId
                                                          .toString())
                                                  .whenComplete(
                                                      () => setState(() {
                                                            widget.call;
                                                          })),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xffF5F5F5),
                                                ),
                                                child: Text(
                                                  'Reject',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    })
          ],
        ),
      ),
    );
  }
}
