import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future religioppudate({
  required String religion,
  required String cast,
  required String mangik,
  required String star,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  final response = await http
      .post(Uri.parse('$mainurl/updateReligiousPreference.php'), body: {
    'API_KEY': APIkey,
    'id': userid,
    'religion': religion,
    'cast': cast,
    'manglik_status': mangik,
    'star': star
  });

  log(religion + cast + mangik + star);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    toast(data['message']);
  } else {
    log('${response.statusCode}religioppudate');
  }
}
