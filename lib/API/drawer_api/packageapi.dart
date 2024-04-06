import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

Future getipackeges({required WidgetRef ref}) async {
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/getPackages.php'));

  request.fields.addAll({
    'API_KEY': APIkey,
  });

  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    ref.watch(packageProvider.notifier).state =
        PackageModel.fromJson(json.decode(responsedata.body));
  } else {
    ref.watch(packageProvider.notifier).state = PackageModel();
    log("${response.statusCode}getshortlist");
    return null;
  }
}

class PackageModel {
  String? response;
  bool? error;
  String? message;
  List<PackagesArray>? packagesArray;

  PackageModel({this.response, this.error, this.message, this.packagesArray});

  PackageModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['packages_array'] != null) {
      packagesArray = <PackagesArray>[];
      json['packages_array'].forEach((v) {
        packagesArray!.add(PackagesArray.fromJson(v));
      });
    }
  }
}

class PackagesArray {
  String? packageId;
  String? packageName;
  String? packAmount;
  int? totalInterest;
  int? totalChat;
  int? totalContact;
  String? duration;

  PackagesArray(
      {this.packageId,
      this.packageName,
      this.packAmount,
      this.totalInterest,
      this.totalChat,
      this.totalContact,
      this.duration});

  PackagesArray.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    packageName = json['package_name'];
    packAmount = json['pack_amount'];
    totalInterest = json['total_interest'];
    totalChat = json['total_chat'];
    totalContact = json['total_contact'];
    duration = json['duration'];
  }
}
