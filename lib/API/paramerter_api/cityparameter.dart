import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:http/http.dart' as http;
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future getcity({required WidgetRef ref, required String stateid}) async {
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/getCities.php'));

  request.fields.addAll({'API_KEY': APIkey, 'state_id': stateid});
  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    print(stateid);
    var data = json.decode(responsedata.body);
    ref.watch(onlycityProvider.notifier).state =
        CityModel.fromJson(json.decode(responsedata.body));

    ref.watch(cityProvider.notifier).state =
        data['cities_array'][0]['city_name'];
  } else {
    log('${response.statusCode}getcity');
  }
}

class CityModel {
  String? response;
  bool? error;
  String? message;
  List<CitiesArray>? citiesArray;

  CityModel({this.response, this.error, this.message, this.citiesArray});

  CityModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['cities_array'] != null) {
      citiesArray = <CitiesArray>[];
      json['cities_array'].forEach((v) {
        citiesArray!.add(new CitiesArray.fromJson(v));
      });
    }
  }
}

class CitiesArray {
  int? cityId;
  String? cityName;

  CitiesArray({this.cityId, this.cityName});

  CitiesArray.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
  }
}
