import 'dart:convert';
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Miscellaneous {
  Future sendFcmToken({required String fcmtoken}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('userid')!;
    try {
      var response = await http.post(
          Uri.parse('$baseUrlNode/api/v1/fcm/updateFCM'),
          body: {'token': fcmtoken, 'id': userid});

      var data = jsonDecode(response.body);
      if (data['sucess']) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future getChatList({required WidgetRef ref}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('userid')!;
    print(userid);
    try {
      var response = await http.get(Uri.parse(
          '$baseUrlNode/api/v1/chat/getChatroomDataByUserId?userId=$userid'));

      var data = chatlistModel.fromJson(json.decode(response.body));

      ref.watch(chatlistProvider.notifier).state = data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}

class chatlistModel {
  bool? success;
  List<Data>? data;
  String? message;

  chatlistModel({this.success, this.data, this.message});

  chatlistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class Data {
  String? latestChat;
  int? chatId;
  String? createdOn;
  String? senderId;
  String? receiverId;
  String? id;
  String? name;
  String? photo1;
  String? firebaseId;
  String? lastchattime;

  Data(
      {this.latestChat,
      this.chatId,
      this.createdOn,
      this.senderId,
      this.receiverId,
      this.id,
      this.name,
      this.photo1,
      this.lastchattime,
      this.firebaseId});

  Data.fromJson(Map<String, dynamic> json) {
    latestChat = json['latestChat'];
    chatId = json['chatId'];
    createdOn = json['createdOn'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    id = json['id'];
    name = json['name'];
    latestChat = json['latestChat'];
    lastchattime = json['latestChatTime'];
    photo1 = json['photo1'];
    firebaseId = json['firebase_id'];
  }
}
