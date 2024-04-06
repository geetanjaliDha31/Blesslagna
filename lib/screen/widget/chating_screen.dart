import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/navigationScreen/chatmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ChatingScreen extends ConsumerStatefulWidget {
  final String opossitefirebaseid, oppsitid, name, photo;
  const ChatingScreen(
      {super.key,
      required this.name,
      required this.opossitefirebaseid,
      required this.oppsitid,
      required this.photo});

  @override
  ConsumerState<ChatingScreen> createState() => _ChatingScreenState();
}

class _ChatingScreenState extends ConsumerState<ChatingScreen> {
  String userfirebaseid = '';
  String currentuser = '';
  late IOWebSocketChannel channel;
  bool connected = false;
  TextEditingController msgcontroller = TextEditingController();
  ScrollController scrollController = ScrollController();
  ScrollController scrollListViewController = ScrollController();
  List<ChatMessage> messages = [];

  String auth = "YLzefMtZLrJnhpttxNKBFbkmxupeeBpDQcZWpPDRLgUYwmVZQh";

  String userName = "username", status = "Online";

  // Future callApi() async {
  //   if (widget.opossitefirebaseid == "") {
  //     toast('Sorry Not Connect');
  //     Navigator.pop(context);
  //   } else {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();

  //     userfirebaseid = prefs.getString('firebaseuserid')!;

  //     log('oppositfirebaseid:${widget.opossitefirebaseid}');
  //   }
  // }

  // This is what you're looking for!
  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  onPressSend() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('userid')!;
    if (msgcontroller.text.trim().isEmpty) return;
    if (connected == true) {
      Map<String, dynamic> msg = {
        'auth': auth,
        'cmd': 'send',
        'userid': widget.oppsitid,
        'msgtext': msgcontroller.text,
        'senderid': userid,
        'type': 'text',
      };

      messages.add(ChatMessage(
          messageContent: msgcontroller.text,
          // userId: widget.oppsitid,
          time: DateTime.now().toString(),
          isme: true));
      setState(() {});
      channel.sink.add(jsonEncode(msg)); //send message to reciever channel
    } else {
      log('this is hit');
      channelconnect();
      // write("Websocket is not connected.");
    }
    _scrollDown();
    msgcontroller.clear();
    setState(() {});
  }

  channelconnect() async {
    //function to connect
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('userid')!;
    log(userid);
    try {
      channel = IOWebSocketChannel.connect(
          "$wsUrl/?senderId=${userid}&receiverId=${widget.oppsitid}"); //channel IP : Port

      channel.stream.listen(
        (message) async {
          if (!mounted) return;
          var msgdatadecoded = json.decode(message);
          log(msgdatadecoded.toString());
          log(msgdatadecoded['cmd'].toString());

          if (msgdatadecoded['cmd'] == "connected") {
            connected = true;
            setState(() {});
          } else if (msgdatadecoded["cmd"] == "send") {
            log("in send ");

            msgcontroller.clear();
          } else if (msgdatadecoded['cmd'] == "error") {
          } else if (msgdatadecoded['cmd'] == 'chat') {
            log("${msgdatadecoded["data"].length}");
            for (var data in msgdatadecoded["data"]) {
              log("inside loop");
              messages.add(ChatMessage(
                  //on message recieve, add data to model
                  messageContent: data["msg"],
                  time: data["createdOn"].toString(),
                  // userId: data["userid"].toString(),
                  isme: data["addedBy"].toString() == userid ? true : false));
            }
            log("in chats ");
            setState(() {});
            Future.delayed(const Duration(milliseconds: 200), () {
              _scrollDown();
            });
          } else if (msgdatadecoded['cmd'] == 'receive') {
            // message = message.replaceAll(RegExp("'"), '"');
            // log('line120');
            // log(userid.toString());
            // log(msgdatadecoded['receiverId'].toString());
            // log(((msgdatadecoded["senderId"] != widget.oppsitid).toString()));
            // log(((msgdatadecoded["receiverId"] != userid).toString()));
            if (msgdatadecoded["senderId"] != widget.oppsitid ||
                msgdatadecoded['receiverId'] != userid) return;
            // log('line123');

            // log("in receive ");

            messages.add(ChatMessage(
                //on message recieve, add data to model
                time: msgdatadecoded["time"].toString(),
                messageContent: msgdatadecoded["msg"],
                // userId: msgdatadecoded["userid"],
                isme: msgdatadecoded["addedBy"] == userid ? true : false));

            setState(() {});
            _scrollDown();
          }
        },
        onDone: () {
          //if WebSocket is disconnected

          if (!mounted) return;
          setState(() {
            connected = false;
          });
        },
        onError: (error) {},
      );
    } catch (e) {
      log("error on connecting to websocket.");
      log(e.toString());
    }
  }

  @override
  void initState() {
    // callApi();
    channelconnect();
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userdetails = ref.watch(userdetailProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            Center(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.photo),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                // Text(
                //   'online',
                //   style: TextStyle(
                //       fontSize: 10,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.grey.shade400),
                // ),
              ],
            ),
          ],
        ),
        actions: [
          ZegoSendCallInvitationButton(
            icon: ButtonIcon(
                icon: Icon(
                  Icons.videocam,
                  color: Colors.grey.shade500,
                ),
                backgroundColor: Colors.transparent),
            buttonSize: Size(50, 50),
            iconSize: Size(50, 50),
            isVideoCall: true,
            resourceID: "Zego_call", // For offline call notification
            invitees: [
              ZegoUIKitUser(
                id: userfirebaseid,
                name: userdetails.basicDetailsArray![0].name.toString(),
              ),
              ZegoUIKitUser(
                id: widget.opossitefirebaseid,
                name: widget.name,
              )
            ],
          ),
          ZegoSendCallInvitationButton(
            icon: ButtonIcon(
                icon: Icon(
                  Icons.call,
                  color: Colors.grey.shade500,
                ),
                backgroundColor: Colors.transparent),
            buttonSize: Size(50, 50),
            iconSize: Size(50, 50),
            isVideoCall: false,
            resourceID: "zegouikit_call", // For offline call notification
            invitees: [
              ZegoUIKitUser(
                id: currentuser,
                // id: userdetails.basicDetailsArray![0].name.toString(),
                name: userdetails.basicDetailsArray![0].name.toString(),
              ),
              ZegoUIKitUser(
                id: widget.opossitefirebaseid,
                // id: widget.name,
                name: widget.name,
              )
            ],
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  reverse: false,
                  controller: scrollListViewController,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 5,
                      ),
                      child: Stack(
                        alignment: !messages[index].isme
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        children: [
                          TextMessage(
                              time: messages[index].time,
                              message: messages[index].messageContent,
                              isMe: messages[index].isme)
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFECECEC),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: msgcontroller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          // filled: true,
                          constraints: BoxConstraints(maxHeight: 100),
                          // fillColor: Colors.red,

                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: primary,
                      fixedSize: const Size(30, 30),
                      shape: const CircleBorder(),
                    ),
                    onPressed: onPressSend,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ZegoSendCallInvitationButton actionButton(bool isVideo) =>
  //     ZegoSendCallInvitationButton(
  //       isVideoCall: isVideo,
  //       resourceID: "zegouikit_call",
  //       invitees: [
  //         ZegoUIKitUser(
  //           id: widget.userid,
  //           name: widget.username,
  //         ),
  //       ],
  //     );
}

class TextMessage extends StatelessWidget {
  const TextMessage(
      {super.key,
      required this.message,
      required this.isMe,
      required this.time});

  final String message, time;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
      margin:
          EdgeInsets.only(top: 10, left: !isMe ? 10 : 0, right: isMe ? 10 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 20 : 0),
          topRight: Radius.circular(!isMe ? 20 : 0),
          bottomLeft: const Radius.circular(20),
          bottomRight: const Radius.circular(20),
        ),
        color: (!isMe ? Colors.grey.shade200 : primary),
      ),
      padding: const EdgeInsets.all(10),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 15, color: !isMe ? Colors.black : Colors.white),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 60,
                child: Text(
                  DateFormat("hh:mm").format(DateTime.parse(time).toLocal()),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: isMe ? Colors.white : const Color(0xFF5A5A5A),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
