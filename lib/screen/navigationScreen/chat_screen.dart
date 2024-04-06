import 'package:blesslagna/API/miscellaneous.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/widget/chating_screen.dart';
import 'package:blesslagna/screen/widget/skeleon/skeletonchat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// FutureProvider chatList =
//     FutureProvider((ref) async => await Miscellaneous().getChatList());

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  StateProvider chatscreenProvider = StateProvider((ref) => true);

  Future callApi() async {
    if (mounted) {
      await Miscellaneous().getChatList(ref: ref).whenComplete(
          () => ref.watch(chatscreenProvider.notifier).state = false);
    }
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(chatscreenProvider);
    final data = ref.watch(chatlistProvider);
    return RefreshIndicator(
      onRefresh: callApi,
      child: Scaffold(
        body:

            // Center(child: SvgPicture.asset("assets/comingsoon.svg"))
            loader
                ? SkeletonChatScreen()
                : data.data!.isEmpty
                    ? Center(child: Text("No Chat"))
                    : ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: data.data!.length,
                        itemBuilder: (c, index) => ChatCard(
                            matid: data.data![index].id.toString(),
                            firbaseid: data.data![index].firebaseId.toString(),
                            photo: data.data![index].photo1.toString(),
                            name: data.data![index].name.toString(),
                            status: data.data![index].latestChat.toString(),
                            time: data.data![index].lastchattime.toString() ==
                                    "null"
                                ? "2023-12-15T01:00:00.000Z"
                                : data.data![index].lastchattime.toString()),
                      ),
      ),
    );
  }

  Widget ChatCard(
      {required String name,
      required String status,
      required String photo,
      required String firbaseid,
      required String matid,
      required String time}) {
    String utcTime = time;

    DateTime dateTime = DateTime.parse(utcTime);
    String formattedTime = DateFormat('h:mm a').format(dateTime.toLocal());

    return InkWell(
      onTap: () => firbaseid == ""
          ? toast("Sorry Not Connect")
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatingScreen(
                      photo: photo == ""
                          ? 'https://img.freepik.com/free-vector/isolated-young-handsome-man-different-poses-white-background-illustration_632498-859.jpg'
                          : "http://app.blesslagna.com/$photo",
                      name: name,
                      oppsitid: matid,
                      opossitefirebaseid: firbaseid))),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: photo == ""
                ? NetworkImage(
                    "https://img.freepik.com/free-vector/isolated-young-handsome-man-different-poses-white-background-illustration_632498-859.jpg")
                : NetworkImage("http://app.blesslagna.com/$photo"),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              Text(
                matid,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Spacer(),
          Text(
            time != "2023-12-15T01:00:00.000Z" ? formattedTime : "",
            style: TextStyle(fontSize: 12, color: Color(0xff6a6a6a)),
          )
        ],
      ),
    );
  }
}
