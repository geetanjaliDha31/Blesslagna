import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:blesslagna/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future eductionppupdate({
  required String eduction,
  required String occupation,
  required String annualincome,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  final response = await http
      .post(Uri.parse('$mainurl/updateEducationPreference.php'), body: {
    'API_KEY': APIkey,
    'id': userid,
    'education': eduction,
    'occupation': occupation,
    'annual_income': annualincome,
  });
  log(eduction + occupation + annualincome);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    toast(data['message']);
  } else {
    log('${response.statusCode}locationppupdate');
  }
}
