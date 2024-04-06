import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future basicppupdate({
  required String skintype,
  required String mothertounge,
  required String martitalstatus,
  required String agefrom,
  required String ageto,
  required String heightfrom,
  required String heightto,
  required String eattype,
  required String drinktype,
  required String generalexpectations,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  final response =
      await http.post(Uri.parse('$mainurl/updateBasicPreference.php'), body: {
    'API_KEY': APIkey,
    'id': userid,
    'looking_for': martitalstatus,
    'skin_type': skintype,
    'mother_tounge': mothertounge,
    'from_age': agefrom,
    'to_age': ageto,
    'from_height': heightfrom,
    'to_height': heightto,
    'eating_habit': eattype,
    'drinking_habit': drinktype,
    'general_expectations': generalexpectations,
  });

  log(
    skintype +
        mothertounge +
        martitalstatus +
        agefrom +
        ageto +
        heightfrom +
        heightto +
        eattype +
        drinktype +
        generalexpectations,
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    toast(data['message']);
  } else {
    log('${response.statusCode}basicppupdate');
  }
}
