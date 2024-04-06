import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

Future getState({required WidgetRef ref, required String countryid}) async {
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/getStates.php'));

  request.fields.addAll({'API_KEY': APIkey, 'country_id': countryid});
  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    var data = json.decode(responsedata.body);
    ref.watch(onlystateProvider.notifier).state =
        StateModel.fromJson(json.decode(responsedata.body));

    ref.watch(stateProvider.notifier).state =
        data['states_array'][0]['state_name'];
  } else {
    log('${response.statusCode}getstate');
  }
}

class StateModel {
  String? response;
  bool? error;
  String? message;
  List<StatesArray>? statesArray;

  StateModel({this.response, this.error, this.message, this.statesArray});

  StateModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['states_array'] != null) {
      statesArray = <StatesArray>[];
      json['states_array'].forEach((v) {
        statesArray!.add(new StatesArray.fromJson(v));
      });
    }
  }
}

class StatesArray {
  int? stateId;
  String? stateName;

  StatesArray({this.stateId, this.stateName});

  StatesArray.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
  }
}
