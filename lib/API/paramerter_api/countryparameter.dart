import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future getCountry({required WidgetRef ref}) async {
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/getCountries.php'));

  request.fields.addAll({
    'API_KEY': APIkey,
  });
  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    ref.watch(onlycountryProvider.notifier).state =
        CountriesModel.fromJson(json.decode(responsedata.body));
  } else {
    log('${response.statusCode}getcountry');
  }
}

class CountriesModel {
  String? response;
  bool? error;
  String? message;
  List<CountriesArray>? countriesArray;

  CountriesModel(
      {this.response, this.error, this.message, this.countriesArray});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['countries_array'] != null) {
      countriesArray = <CountriesArray>[];
      json['countries_array'].forEach((v) {
        countriesArray!.add(new CountriesArray.fromJson(v));
      });
    }
  }
}

class CountriesArray {
  String? countryId;
  String? countryName;

  CountriesArray({this.countryId, this.countryName});

  CountriesArray.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
  }
}
