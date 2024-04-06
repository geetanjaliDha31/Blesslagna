import 'package:blesslagna/API/home_api/functionapi.dart';
import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:blesslagna/screen/widget/chating_screen.dart';
import 'package:blesslagna/screen/widget/profiledetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResult extends ConsumerStatefulWidget {
  final NewMatches newmatchdata;
  final PremiumMatches premiumMatches;
  final bool isPaidMember;

  const SearchResult({
    super.key,
    required this.newmatchdata,
    required this.premiumMatches,
    required this.isPaidMember,
  });

  @override
  ConsumerState<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends ConsumerState<SearchResult> {
  @override
  Widget build(BuildContext context) {
    final searchlist = ref.watch(searchProvider);
    return Scaffold(
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
          'Search',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: primary),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchlist.resultArray!.length,
            itemBuilder: (context, index) {
              var data = searchlist.resultArray![index];
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    data.image.toString(),
                                  ))),
                          height: 178,
                          width: 93,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.name.toString()}  ${data.age.toString()}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
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
                                  width: MediaQuery.of(context).size.width / 2,
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
                                  "Cast : ${data.caste.toString()}",
                                  overflow: TextOverflow.ellipsis,
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
                                      color: Color(0xcc000000)),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Userfunction().sendinterest(
                                          recipientid:
                                              data.matrimonialId.toString()),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                            const SizedBox(width: 2),
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
                                    SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () {
                                        data.firbaseid.toString() == ""
                                            ? toast("Sorry Not Connect")
                                            : Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatingScreen(
                                                            photo:
                                                                data
                                                                    .image
                                                                    .toString(),
                                                            name:
                                                                data
                                                                    .name
                                                                    .toString(),
                                                            oppsitid: data
                                                                .matrimonialId
                                                                .toString(),
                                                            opossitefirebaseid:
                                                                data.firbaseid
                                                                    .toString())));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                    SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () => Userfunction().blockprofile(
                                          recipientid:
                                              data.matrimonialId.toString()),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
              );
            }),
      ),
    );
  }
}
