import 'package:blesslagna/API/home_api/getrequestapi.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/widget/recevideinterestprofilescreen.dart';
import 'package:blesslagna/screen/widget/sendinterestprofilescreen.dart';
import 'package:blesslagna/screen/widget/skeleon/skeletonrequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyRequestScreen extends ConsumerStatefulWidget {
  const MyRequestScreen({super.key});

  @override
  ConsumerState<MyRequestScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends ConsumerState<MyRequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  StateProvider requestloaderProvider = StateProvider((ref) => true);
  RequestModel? requests;

  Future callApi() async {
    requests = await getirequest(ref: ref).whenComplete(() {
      if (mounted) {
        ref.watch(requestloaderProvider.notifier).state = false;
      }
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
    final loader = ref.watch(requestloaderProvider);
    SizeConfig().init(context);
    return RefreshIndicator(
      onRefresh: callApi,
      child: Scaffold(
          body: loader
              ? RequestSkeleton()
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
                              text: "Send Request",
                            ),
                            Tab(
                              text: "Received Request",
                            ),
                          ]),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 70,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            SendInterestProfile(
                              accept: requests!.acceptedSentArray!,
                              reject: requests!.rejectedSentArray!,
                              pending: requests!.pendingSentArray!,
                            ),
                            RecevideInterest(
                              accept: requests!.acceptedReceivedArray!,
                              reject: requests!.rejectedReceivedArray!,
                              pending: requests!.pendingReceivedArray!,
                              call: callApi,
                            )
                            // SendRequest(which: "recevied")
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
//  ListView.builder(
//       padding: const EdgeInsets.all(20),
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: 2,
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 // border: Border.all(width: 1, color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Color(
//                         0x3f000000,
//                       ), //New
//                       blurRadius: 1.0,
//                       offset: Offset(0, 0))
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset('assets/photo3.png'),
//                   const Spacer(),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Dhruv Chopra  29",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black),
//                           ),
//                           const Text(
//                             "Mumbai, Maharashtra",
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xff7d7d7d)),
//                           ),
//                           const SizedBox(height: 5),
//                           const Text(
//                             "Cast : Hindu\t\t\t\t\tSub-cast : Agri",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black),
//                           ),
//                           const SizedBox(height: 3),
//                           const Text(
//                             "Height : 5.5 ft\t\t\tWieght : 5.5 ft",
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black),
//                           ),
//                           const SizedBox(height: 3),
//                           const Text(
//                             "Designation : Software Engineer",
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xcc000000)),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             width: width / 2,
//                             height: 30,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(color: primary)),
//                             child: Center(
//                               child: Text(
//                                 'Pending',
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: primary),
//                               ),
//                             ),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20)
//           ],
//         );
//       },
//     )