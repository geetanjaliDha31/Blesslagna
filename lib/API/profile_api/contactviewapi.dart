import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<String> contactview({required String recipientid}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getString('userid');
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/viewContact.php'));

  request.fields.addAll({
    'user_id': userid.toString(),
    'contact_user_id': recipientid,
    'API_KEY': APIkey,
  });

  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    var data = json.decode(responsedata.body);
    toast(data['message']);
    return data['contact_no'] ?? '';
  } else {
    toast('Something Went Wrong');
    log("${response.statusCode}sendinterest");
    return '';
  }
}
