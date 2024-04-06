import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<RequestModel?> getirequest({required WidgetRef ref}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/getInterest.php'));

  request.fields.addAll({
    'user_id': userid.toString(),
    'API_KEY': APIkey,
  });

  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    // ref.watch(requestProvider.notifier).state =
    //     RequestModel.fromJson(json.decode(responsedata.body));
    print(responsedata.body);
    log('match 200');
    return RequestModel.fromJson(json.decode(responsedata.body));
  } else {
    ref.watch(requestProvider.notifier).state = RequestModel();
    log("${response.statusCode}getrequest");
    log('match 202');
    return null;
  }
}

class RequestModel {
  String? response;
  bool? error;
  String? message;
  List<AcceptedSentArray>? acceptedSentArray;
  List<RejectedSentArray>? rejectedSentArray;
  List<PendingSentArray>? pendingSentArray;
  List<ReceviedAcceptedSentArray>? acceptedReceivedArray;
  List<ReceviedRejectedSentArray>? rejectedReceivedArray;
  List<ReceviedPendingSentArray>? pendingReceivedArray;

  RequestModel(
      {this.response,
      this.error,
      this.message,
      this.acceptedSentArray,
      this.rejectedSentArray,
      this.pendingSentArray,
      this.acceptedReceivedArray,
      this.rejectedReceivedArray,
      this.pendingReceivedArray});

  RequestModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['accepted_sent_array'] != null) {
      acceptedSentArray = <AcceptedSentArray>[];
      json['accepted_sent_array'].forEach((v) {
        acceptedSentArray!.add(new AcceptedSentArray.fromJson(v));
      });
    }
    if (json['rejected_sent_array'] != null) {
      rejectedSentArray = <RejectedSentArray>[];
      json['rejected_sent_array'].forEach((v) {
        rejectedSentArray!.add(new RejectedSentArray.fromJson(v));
      });
    }
    if (json['pending_sent_array'] != null) {
      pendingSentArray = <PendingSentArray>[];
      json['pending_sent_array'].forEach((v) {
        pendingSentArray!.add(new PendingSentArray.fromJson(v));
      });
    }
    if (json['accepted_received_array'] != null) {
      acceptedReceivedArray = <ReceviedAcceptedSentArray>[];
      json['accepted_received_array'].forEach((v) {
        acceptedReceivedArray!.add(new ReceviedAcceptedSentArray.fromJson(v));
      });
    }
    if (json['rejected_received_array'] != null) {
      rejectedReceivedArray = <ReceviedRejectedSentArray>[];
      json['rejected_received_array'].forEach((v) {
        rejectedReceivedArray!.add(new ReceviedRejectedSentArray.fromJson(v));
      });
    }
    if (json['pending_received_array'] != null) {
      pendingReceivedArray = <ReceviedPendingSentArray>[];
      json['pending_received_array'].forEach((v) {
        pendingReceivedArray!.add(new ReceviedPendingSentArray.fromJson(v));
      });
    }
  }
}

class PendingSentArray {
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
  bool? blockedStatus;
  String? firebaseId;

  PendingSentArray(
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
      this.blockedStatus,
      this.firebaseId});

  PendingSentArray.fromJson(Map<String, dynamic> json) {
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
    blockedStatus = json['blocked_status'];
    firebaseId = json['firebase_id'];
  }
}

class AcceptedSentArray {
  String? matrimonialId;
  String? name;
  String? height;
  String? age;
  String? location;
  String? caste;
  String? subcaste;
  String? designation;
  String? image;
  String? firebaseid;
  bool? isPaidMember;

  AcceptedSentArray(
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
      this.isPaidMember});

  AcceptedSentArray.fromJson(Map<String, dynamic> json) {
    matrimonialId = json['matrimonial_id'];
    name = json['name'];
    height = json['height'];
    age = json['age'];
    location = json['location'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    designation = json['designation'];
    image = json['image'];
    firebaseid = json['firebase_id'];
    isPaidMember = json['isPaidMember'];
  }
}

class RejectedSentArray {
  String? matrimonialId;
  String? name;
  String? height;
  String? age;
  String? location;
  String? caste;
  String? subcaste;
  String? designation;
  String? image;
  String? firebaseid;
  bool? isPaidMember;

  RejectedSentArray(
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
      this.isPaidMember});

  RejectedSentArray.fromJson(Map<String, dynamic> json) {
    matrimonialId = json['matrimonial_id'];
    name = json['name'];
    height = json['height'];
    age = json['age'];
    location = json['location'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    designation = json['designation'];
    image = json['image'];
    firebaseid = json['firebase_id'];
    isPaidMember = json['isPaidMember'];
  }
}

class ReceviedAcceptedSentArray {
  String? matrimonialId;
  String? name;
  String? height;
  String? age;
  String? location;
  String? caste;
  String? subcaste;
  String? designation;
  String? image;
  String? firebaseid;
  bool? isPaidMember;

  ReceviedAcceptedSentArray(
      {this.matrimonialId,
      this.name,
      this.height,
      this.age,
      this.location,
      this.caste,
      this.subcaste,
      this.designation,
      this.image,
      this.isPaidMember});

  ReceviedAcceptedSentArray.fromJson(Map<String, dynamic> json) {
    matrimonialId = json['matrimonial_id'];
    name = json['name'];
    height = json['height'];
    age = json['age'];
    location = json['location'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    designation = json['designation'];
    image = json['image'];
    firebaseid = json['firebase_id'];
    isPaidMember = json['isPaidMember'];
  }
}

class ReceviedRejectedSentArray {
  String? matrimonialId;
  String? name;
  String? height;
  String? age;
  String? location;
  String? caste;
  String? subcaste;
  String? designation;
  String? image;
  String? firebaseid;
  bool? isPaidMember;

  ReceviedRejectedSentArray(
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
      this.isPaidMember});

  ReceviedRejectedSentArray.fromJson(Map<String, dynamic> json) {
    matrimonialId = json['matrimonial_id'];
    name = json['name'];
    height = json['height'];
    age = json['age'];
    location = json['location'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    designation = json['designation'];
    image = json['image'];
    firebaseid = json['firebase_id'];
    isPaidMember = json['isPaidMember'];
  }
}

class ReceviedPendingSentArray {
  String? matrimonialId;
  String? name;
  String? height;
  String? age;
  String? location;
  String? caste;
  String? subcaste;
  String? designation;
  String? image;
  String? firebaseid;
  bool? isPaidMember;

  ReceviedPendingSentArray(
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
      this.isPaidMember});

  ReceviedPendingSentArray.fromJson(Map<String, dynamic> json) {
    matrimonialId = json['matrimonial_id'];
    name = json['name'];
    height = json['height'];
    age = json['age'];
    location = json['location'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    designation = json['designation'];
    image = json['image'];
    firebaseid = json['firebase_id'];
    isPaidMember = json['isPaidMember'];
  }
}
