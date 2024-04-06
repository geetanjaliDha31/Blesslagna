import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<GetAllMatchModel?> getallnmatch({required WidgetRef ref}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/getAllProfiles.php'));

  request.fields.addAll({
    'user_id': userid.toString(),
    'API_KEY': APIkey,
  });

  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    // ref.watch(allMatchdataProvider.notifier).state =
    //     GetAllMatchModel.fromJson(json.decode(responsedata.body));
    return GetAllMatchModel.fromJson(json.decode(responsedata.body));
  } else {
    // ref.watch(allMatchdataProvider.notifier).state = GetAllMatchModel();
    log("${response.statusCode}getmatch");
    return null;
  }
}

class GetAllMatchModel {
  String? response;
  bool? error;
  String? message;
  List<AllProfiles>? allProfiles;
  List<NewMatches>? newMatches;
  List<PremiumMatches>? premiumMatches;

  GetAllMatchModel(
      {this.response,
      this.error,
      this.message,
      this.allProfiles,
      this.newMatches,
      this.premiumMatches});

  GetAllMatchModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['all_profiles'] != null) {
      allProfiles = <AllProfiles>[];
      json['all_profiles'].forEach((v) {
        allProfiles!.add(new AllProfiles.fromJson(v));
      });
    }
    if (json['new_matches'] != null) {
      newMatches = <NewMatches>[];
      json['new_matches'].forEach((v) {
        newMatches!.add(new NewMatches.fromJson(v));
      });
    }
    if (json['premium_matches'] != null) {
      premiumMatches = <PremiumMatches>[];
      json['premium_matches'].forEach((v) {
        premiumMatches!.add(new PremiumMatches.fromJson(v));
      });
    }
  }
}

class AllProfiles {
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
  bool? isblock;
  String? firebaseid;

  AllProfiles(
      {this.matrimonialId,
      this.name,
      this.height,
      this.age,
      this.location,
      this.caste,
      this.subcaste,
      this.designation,
      this.image,
      this.firebaseid,
      this.isshortlisted,
      this.isblock,
      this.isPaidMember});

  AllProfiles.fromJson(Map<String, dynamic> json) {
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
    firebaseid = json['firebase_id'];
    isshortlisted = json['shortlist_status'];
    isblock = json['blocked_status'];
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
  bool? isblock;
  String? firebaseid;

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
      this.isshortlisted,
      this.isblock,
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
    firebaseid = json['firebase_id'];
    isshortlisted = json['shortlist_status'];
    isblock = json['blocked_status'];
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
  bool? interestStatus;
  bool? shortlistStatus;
  String? firebaseid;
  bool? isshortlisted;
  bool? isblock;

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
      this.isPaidMember,
      this.isshortlisted,
      this.isblock,
      this.interestStatus,
      this.shortlistStatus});

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
    interestStatus = json['interest_status'];
    shortlistStatus = json['shortlist_status'];
    firebaseid = json['firebase_id'];
    isshortlisted = json['shortlist_status'];
    isblock = json['blocked_status'];
  }
}
