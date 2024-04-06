import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Userfunction {
  Future sendinterest({required String recipientid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainurl/sendInterest.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'recipient_id': recipientid,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      toast(data['message']);
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return null;
    }
  }

  Future shortlistprofile({required String recipientid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainurl/shortlistProfile.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'shortlist_user_id': recipientid,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      toast(data['message']);
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return null;
    }
  }

  Future blockprofile({required String recipientid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainurl/blockProfile.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'block_user_id': recipientid,
      'API_KEY': APIkey,
    });

    log('userid:$userid && recpetid:$recipientid');
    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      toast(data['message']);
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return null;
    }
  }

  Future unblockprofile({required String recipientid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainurl/unblockProfile.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'block_user_id': recipientid,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      toast(data['message']);
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return null;
    }
  }

  Future addviewedprofile({required String recipientid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainurl/addViewedProfile.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'viewed_user_id': recipientid,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      log(data['message']);
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return null;
    }
  }
}

class UserdoAction {
  Future acceptsentinterest({required String recipientid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainurl/acceptSentInterest.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'recipient_id': recipientid,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      toast(data['message']);
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return null;
    }
  }

  Future rejectsentinterest({required String recipientid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainurl/rejectSentInterest.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'recipient_id': recipientid,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      toast(data['message']);
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return null;
    }
  }

  Future deletesentinterest({required String recipientid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainurl/deleteSentInterest.php'));

    request.fields.addAll({
      'user_id': userid.toString(),
      'recipient_id': recipientid,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      toast(data['message']);
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return null;
    }
  }
}
