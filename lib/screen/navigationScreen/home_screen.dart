import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/widget/firstcard_widget.dart';
import 'package:blesslagna/screen/widget/secondcard_widget.dart';
import 'package:blesslagna/screen/widget/showmore.dart';
import 'package:blesslagna/screen/widget/thridcard_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  // final NewMatches newmatchdata;

  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  StateProvider homepageloaderProvider = StateProvider((ref) => true);
  Future callApi() async {
    await gethome(ref: ref).whenComplete(
        () => ref.watch(homepageloaderProvider.notifier).state = false);
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homedata = ref.watch(homedataProvider);
    final loader = ref.watch(homepageloaderProvider);
    return RefreshIndicator(
      onRefresh: callApi,
      child: Scaffold(
          body: loader
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'New ',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xD9131313)),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Matches',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: primary)),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowMoreScreen(
                                            data: homedata.newMatches)));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'show More',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: primary),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 230,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: homedata.newMatches!.length,
                              itemBuilder: (context, index) {
                                return FirstCard(
                                  newmatchdata: homedata.newMatches![index],
                                  premiumMatches:
                                      homedata.premiumMatches![index],
                                  isPaidMember:
                                      homedata.newMatches![index].isPaidMember!,
                                );
                              }),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Premium ',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xD9131313)),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Matches',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: primary)),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowMoreScreen(
                                            data: homedata.premiumMatches)));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'show More',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: primary),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 230,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(5),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: homedata.premiumMatches!.length,
                              itemBuilder: (context, index) {
                                return SecondCard(
                                  preminumatches:
                                      homedata.premiumMatches![index],
                                  newmatchdata: homedata.newMatches![index],
                                  isPaidMemeber: homedata.premiumMatches![index].isPaidMember!,
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: RichText(
                            text: TextSpan(
                              text: 'Sucess ',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xD9131313)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Story',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: primary)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              initialPage: 0,
                              autoPlay: false,
                              // height: ,s
                              aspectRatio: 8 / 5.5,
                              autoPlayInterval: const Duration(seconds: 8),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: homedata.successStories!.map((i) {
                              return ThridCard(
                                data: i,
                              );
                            }).toList())
                      ]),
                )),
    );
  }
}
