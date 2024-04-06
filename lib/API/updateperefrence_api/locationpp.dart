import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:blesslagna/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future locationppupdate({
  required String countryid,
  required String stateid,
  required String city,
  required String residence,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  final response = await http
      .post(Uri.parse('$mainurl/updateLocationPreference.php'), body: {
    'API_KEY': APIkey,
    'id': userid,
    'country': countryid,
    'state': stateid,
    'city': city,
    'residence': residence
  });

  log(countryid + stateid + city + residence);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    toast(data['message']);
  } else {
    log('${response.statusCode}locationppupdate');
  }
}
