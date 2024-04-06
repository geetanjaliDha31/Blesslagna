import 'dart:convert';
import 'dart:developer';

import 'package:blesslagna/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future userdelete() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var url = Uri.parse("$mainurl/deleteAccount.php");

    var response = await http.post(url, body: {
      'API_KEY': APIkey,
      'user_id': userid,
    });

    if (response.statusCode == 200) {
      FirebaseAuth.instance.currentUser!.delete();
      var data = jsonDecode(response.body);
      print(data);
      // toast(data['message']);
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
    }
  } catch (e) {
    log("come2");
    log(e.toString());
  }
}
