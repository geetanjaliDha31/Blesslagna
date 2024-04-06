import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future gethome({required WidgetRef ref}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  var request = http.MultipartRequest(
      'POST', Uri.parse('$mainurl/getHomeScreenDetails.php'));

  request.fields.addAll({
    'user_id': userid.toString(),
    'API_KEY': APIkey,
  });

  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    ref.watch(homedataProvider.notifier).state =
        NewMatchesModel.fromJson(json.decode(responsedata.body));
  } else {
    ref.watch(homedataProvider.notifier).state = NewMatchesModel();
    log("${response.statusCode}getbanner");
    return null;
  }
}

class NewMatchesModel {
  String? response;
  bool? error;
  String? message;
  List<NewMatches>? newMatches;
  List<PremiumMatches>? premiumMatches;
  List<UserDetails>? userDetails;
  List<SuccessStories>? successStories;

  NewMatchesModel(
      {this.response,
      this.error,
      this.message,
      this.newMatches,
      this.premiumMatches,
      this.userDetails,
      this.successStories});

  NewMatchesModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['new_matches'] != null) {
      newMatches = <NewMatches>[];
      json['new_matches'].forEach((v) {
        newMatches!.add(NewMatches.fromJson(v));
      });
    }
    if (json['premium_matches'] != null) {
      premiumMatches = <PremiumMatches>[];
      json['premium_matches'].forEach((v) {
        premiumMatches!.add(PremiumMatches.fromJson(v));
      });
    }
    if (json['user_details'] != null) {
      userDetails = <UserDetails>[];
      json['user_details'].forEach((v) {
        userDetails!.add(UserDetails.fromJson(v));
      });
    }
    if (json['success_stories'] != null) {
      successStories = <SuccessStories>[];
      json['success_stories'].forEach((v) {
        successStories!.add(SuccessStories.fromJson(v));
      });
    }
  }
}

class NewMatches {
  String? matrimonialId;
  String? name;
  String? height;
  String? age;
  String? location;
  String? caste;
  String? subcaste;
  String? designation;
  String? image;
  bool? isPaidMember;
  bool? isshortlisted;
  bool? isinterest;

  NewMatches(
      {this.matrimonialId,
      this.name,
      this.height,
      this.age,
      this.location,
      this.caste,
      this.subcaste,
      this.designation,
      this.image,
      this.isinterest,
      this.isshortlisted,
      this.isPaidMember});

  NewMatches.fromJson(Map<String, dynamic> json) {
    matrimonialId = json['matrimonial_id'];
    name = json['name'];
    height = json['height'];
    age = json['age'];
    location = json['location'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    designation = json['designation'];
    image = json['image'];
    isPaidMember = json['isPaidMember'];
    isinterest = json['interest_status'];
    isshortlisted = json['shortlist_status'];
  }
}

class PremiumMatches {
  String? matrimonialId;
  String? name;
  String? height;
  String? age;
  String? location;
  String? caste;
  String? subcaste;
  String? designation;
  String? image;
  bool? isPaidMember;
  bool? isshortlisted;
  bool? isinterest;

  PremiumMatches(
      {this.matrimonialId,
      this.name,
      this.height,
      this.age,
      this.location,
      this.caste,
      this.subcaste,
      this.designation,
      this.image,
      this.isinterest,
      this.isshortlisted,
      this.isPaidMember});

  PremiumMatches.fromJson(Map<String, dynamic> json) {
    matrimonialId = json['matrimonial_id'];
    name = json['name'];
    height = json['height'];
    age = json['age'];
    location = json['location'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    designation = json['designation'];
    image = json['image'];
    isPaidMember = json['isPaidMember'];
    isinterest = json['interest_status'];
    isshortlisted = json['shortlist_status'];
  }
}

class UserDetails {
  String? userName;
  String? profileImage;
  int? pendingInterest;
  int? pendingChat;
  int? pendingContact;
  String? location;

  UserDetails(
      {this.userName,
      this.profileImage,
      this.pendingInterest,
      this.pendingChat,
      this.pendingContact,
      this.location});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    profileImage = json['profile_image'];
    pendingInterest = json['pending_interest'];
    pendingChat = json['pending_chat'];
    pendingContact = json['pending_contact'];
    location = json['location'];
  }
}

class SuccessStories {
  String? title;
  String? description;
  String? image;

  SuccessStories({this.title, this.description, this.image});

  SuccessStories.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }
}
