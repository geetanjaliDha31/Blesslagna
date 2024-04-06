import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future getiviewprofileprofile({required WidgetRef ref}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/getViewedProfile.php'));

  request.fields.addAll({
    'user_id': userid.toString(),
    'API_KEY': APIkey,
  });

  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    var data = json.decode(responsedata.body);

    if (data['message'] == 'No data found') {
      ref.watch(iviewedprofileemptyProvider.notifier).state = true;
    } else {
      ref.watch(iviewedprofileProvider.notifier).state =
          IviewedProfileModel.fromJson(json.decode(responsedata.body));
    }
  } else {
    ref.watch(iviewedprofileProvider.notifier).state = IviewedProfileModel();
    log("${response.statusCode}getshortlist");
    return null;
  }
}

class IviewedProfileModel {
  String? response;
  bool? error;
  String? message;
  List<ViewedProfile>? viewedProfile;

  IviewedProfileModel(
      {this.response, this.error, this.message, this.viewedProfile});

  IviewedProfileModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['viewed_profile'] != null) {
      viewedProfile = <ViewedProfile>[];
      json['viewed_profile'].forEach((v) {
        viewedProfile!.add(new ViewedProfile.fromJson(v));
      });
    }
  }
}

class ViewedProfile {
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

  ViewedProfile(
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
      this.interestStatus,
      this.shortlistStatus,
      this.firebaseid});

  ViewedProfile.fromJson(Map<String, dynamic> json) {
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
  }
}
