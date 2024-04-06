import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/Firebase_service/firebase_service.dart';
import 'package:blesslagna/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  Future<bool> login(
      {required String username,
      required String password,
      required BuildContext context,
      required WidgetRef ref}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse('$mainurl/loginWithPassword.php'));

    request.fields.addAll({
      'username': username,
      'password': password,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsedata.body);
      print('logindata:$data');
      if (!data['error']) {
        // if user firebase id present
        if (data['firebase_status']) {
          prefs.setString('userid', data['user_id']);
          prefs.setString('firebaseuserid', data['firebase_id']);
          prefs.setBool('logged', true);
          // ref.watch(userfirbaseidProvider.notifier).state = data['firebase_id'];
          toast(data['message']);
          return false;
        }
        // else create firebase id
        else {
          String userid = data['user_id'];
          try {
            FirbaseService()
                .singUpWithEmailAndPassword(
                    context: context,
                    email: data['email'].toString(),
                    password: password,
                    userid: userid)
                .then((value) {
              log('comeinfirebase');
              log(value.toString());
              if (value!.isNotEmpty) {
                prefs.setString('firebaseuserid', value.toString());
                // ref.watch(userfirbaseidProvider.notifier).state =
                //     value.toString();
                updatefirebase(firebaseid: value.toString(), userid: userid)
                    .then((value) {
                  if (!value) {
                    prefs.setBool('logged', true);
                  }
                });
              }
            });
            return false;
          } catch (e) {
            log(e.toString());
            return true;
          }
        }
      } else {
        toast(data['message']);
        return data['error'];
      }
      // toast(data['message']);
    } else {
      log('${response.statusCode}login');
      return true;
    }
  }

  Future<bool> forgotpassword({
    required String email,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainurl/sendOTP.php'));

    request.fields.addAll({
      'user_email': email,
      'API_KEY': APIkey,
    });
    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsedata.body);
      log(data.toString());
      toast(data['message']);
      print(data['error']);
      return data['error'];
    } else {
      log('${response.statusCode}forgotpassword');
      return true;
    }
  }

  Future<bool> verifyotp({
    required String email,
    required String otp,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainurl/verifyOTP.php'));

    request.fields.addAll({
      'user_email': email,
      'otp': otp,
      'API_KEY': APIkey,
    });
    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsedata.body);
      toast(data['message']);
      return data['error'];
    } else {
      log('${response.statusCode}forgotpassword');
      return true;
    }
  }

  Future<bool> mainforgotpassword({
    required String email,
    required String pass,
    required String confirmpass,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainurl/forgotPassword.php'));

    request.fields.addAll({
      'user_email': email,
      'new_password': pass,
      'confirm_password': confirmpass,
      'API_KEY': APIkey,
    });
    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(responsedata.body);
      toast(data['message']);
      return data['error'];
    } else {
      log('${response.statusCode}forgotpassword');
      return true;
    }
  }

  Future<bool> updatefirebase(
      {required String userid, required String firebaseid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var request =
        http.MultipartRequest('POST', Uri.parse('$mainurl/addFirebaseID.php'));

    request.fields.addAll({
      'user_id': userid,
      'firebaseid': firebaseid,
      'API_KEY': APIkey,
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      var data = json.decode(responsedata.body);
      toast(data['message']);
      prefs.setBool('logged', true);
      return data['false'];
    } else {
      toast('Something Went Wrong');
      log("${response.statusCode}sendinterest");
      return true;
    }
  }

  Future<bool> registration(
      {required String username,
      required String gender,
      required String useremail,
      required String maritalstatus,
      required String userlocation,
      required String usereligion,
      required String cast,
      required String userdob,
      required String password,
      required String confirmpassword,
      required String firbaseid,
      required String usermobile}) async {
    print("comeregister");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$mainurl/registerUser.php')); // Replace with your API endpoint
    request.fields.addAll({
      'API_KEY': APIkey,
      'fullname': username,
      'gender': gender,
      'email': useremail,
      'marital_status': maritalstatus,
      'location': userlocation,
      'religion': usereligion,
      'caste': cast,
      'dob': userdob,
      'password': password,
      'confirm_password': confirmpassword,
      'mobile': usermobile,
      'firebaseid': firbaseid
    });

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print("apicomeregister");
      var data = jsonDecode(responsedata.body);
      if (!data['error']) {
        prefs.setString('userid', data['user_id']);
        toast(data['message']);
      } else {
        toast(data['message']);
      }
      return data['error'];
    } else {
      // Handle any errors or other status codes here
      print('Error: ${response.statusCode}');
      return true;
    }
  }
}
