import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchApi {
  Future getbyid({required String id, required WidgetRef ref}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainurl/searchProfileByID.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'searched_id': id.toString(),
      'API_KEY': APIkey,
    });

    print(id);
    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print(json.decode(responsedata.body));
      ref.watch(searchProvider.notifier).state =
          SerachGetbyID.fromJson(json.decode(responsedata.body));
    } else {
      ref.watch(searchProvider.notifier).state = SerachGetbyID();
      log("${response.statusCode}getrequest");
      return null;
    }
  }

  Future<String> getsearch(
      {religon,
      gender,
      cast,
      agefrom,
      ageto,
      heightfrom,
      heightto,
      eduction,
      marital,
      mother,
      country,
      state,
      city,
      required WidgetRef ref}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainurl/getSearchedProfile.php'));

    List<String> educationlist = splitAndConvertToLowerCase(eduction);
    log(educationlist.toString());
    List<String> countrylist = splitAndConvertToLowerCase(country);
    log(countrylist.toString());
    List<String> statelist = splitAndConvertToLowerCase(state);
    log(statelist.toString());
    List<String> citylist = splitAndConvertToLowerCase(city);
    log(citylist.toString());
    List<String> maretalist = splitAndConvertToLowerCase(marital);
    log(maretalist.toString());
    List<String> motherlist = splitAndConvertToLowerCase(mother);
    log(motherlist.toString());

    request.fields.addAll({
      'religion': religon.toString(),
      'gender': gender.toString(),
      'cast': cast.toString(),
      'age_from': agefrom.toString(),
      'age_to': ageto.toString(),
      'height_from': heightfrom.toString(),
      'height_to': heightto.toString(),
      'education[]': splitAndConvertToLowerCase(eduction).toString(),
      'country': splitAndConvertToLowerCase(country).toString(),
      'state': splitAndConvertToLowerCase(state).toString(),
      'city': splitAndConvertToLowerCase(city).toString(),
      'marital_status': splitAndConvertToLowerCase(marital).toString(),
      'mother_tongue': splitAndConvertToLowerCase(mother).toString(),
      'user_id': userid.toString(),
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      if (jsonDecode(responsedata.body)['error']) {
        toast(jsonDecode(responsedata.body)['message']);
        ref.watch(searchProvider.notifier).state = SerachGetbyID();
        return '';
      } else {
        print(json.decode(responsedata.body));
        ref.watch(searchProvider.notifier).state =
            SerachGetbyID.fromJson(json.decode(responsedata.body));
        return 'come';
      }
    } else {
      ref.watch(searchProvider.notifier).state = SerachGetbyID();
      log("${response.statusCode}getrequest");
      return '';
    }
  }
}

class SerachGetbyID {
  String? response;
  bool? error;
  String? message;
  List<ResultArray>? resultArray;

  SerachGetbyID({this.response, this.error, this.message, this.resultArray});

  SerachGetbyID.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['result_array'] != null) {
      resultArray = <ResultArray>[];
      json['result_array'].forEach((v) {
        resultArray!.add(ResultArray.fromJson(v));
      });
    }
  }
}

class ResultArray {
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
  String? firbaseid;

  ResultArray(
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
      this.firbaseid});

  ResultArray.fromJson(Map<String, dynamic> json) {
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
    firbaseid = json['firebase_id'];
  }
}

List<String> splitAndConvertToLowerCase(String input) {
  // Split the input string by comma and trim whitespace
  List<String> parts =
      input.split(',').map((String part) => part.trim()).toList();

  // Convert each part to lowercase
  List<String> result = parts.map((String part) => part.toLowerCase()).toList();

  return result;
}
