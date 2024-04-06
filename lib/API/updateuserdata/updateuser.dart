import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateUser {
  Future updatebasicdata({
    required String username,
    required String height,
    required String dobuser,
    required String mothertounge,
    required String languagekonwn,
    required String marriedstatus,
    required String userphoneno,
    required String gender,
    // required String hobbies,
    // required String weight,
    // required String brithplace,
    // required String brithtime,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updatePersonalDetails.php");
      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'id': userid,
        'fullname': username,
        'height': height,
        'dob': dobuser,
        'marital_status': marriedstatus,
        'mother_tounge': mothertounge,
        'mobile':userphoneno,
        'languages': languagekonwn,
        'gender':gender,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updatereligion({
    required String religion,
    required String cast,
    required String subcast,
    required String horoscope,
    required String star,
    required String gotra,
    required String manglik,
    required String moonsign,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updateReligiousDetails.php");
      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'id': userid,
        'religion': religion,
        'cast': cast,
        'subcast': subcast,
        'manglik_status': manglik,
        'star': star,
        'horoscope': horoscope,
        'gotra': gotra,
        'moonsign': moonsign,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateeducation({
    required String education,
    required String occupation,
    required String employeein,
    required String designation,
    required String annualincome,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updateEducationDetails.php");
      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'id': userid,
        'education': education,
        'occupation': occupation,
        'annual_income': annualincome,
        'employee_in': employeein,
        'designation': designation,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updatelifestyle({
    required String bodytype,
    required String skintone,
    required String blood,
    required String eating,
    required String smoking,
    required String drink,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updateLifestyleDetails.php");
      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'id': userid,
        'body_type': bodytype,
        'skin_type': skintone,
        'blood_group': bodytype,
        'eating_habit': eating,
        'smoking_habit': smoking,
        'drinking_habit': drink,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updatelocation({
    required String country,
    required String state,
    required String city,
    required String address,
    required String timetocall,
    required String residence,
    required String mobile,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updateLocationDetails.php");
      log(country + state + city + address + timetocall + residence + mobile);
      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'id': userid,
        'country': country,
        'state': state,
        'city': city,
        'address': address,
        'mobile': mobile,
        'phone': mobile,
        'time_to_call': timetocall,
        'residence': residence,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updatefamiliy({
    required String familytype,
    required String mothername,
    required String motherjob,
    required String fathername,
    required String fatherjob,
    required String noofbro,
    required String noofsister,
    required String noofmarriedbro,
    required String noofmarriedsis,
    required String aboutfamily,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updateFamilyDetails.php");

      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'id': userid,
        'family_type': familytype,
        'father_name': fathername,
        'father_occupation': fatherjob,
        'mother_name': mothername,
        'mother_occupation': motherjob,
        'no_of_brothers': noofbro,
        'no_of_sisters': noofsister,
        'no_married_brothers': noofmarriedbro,
        'no_married_sisters': noofmarriedsis,
        'about_family': aboutfamily,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future addphoto({photo1, photo2, photo3}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updateFamilyDetails.php");

      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'user_id': userid,
        'photo_1': photo1,
        "photo_2": photo2,
        "photo_3": photo3
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateuserphoto({
    required String photo0,
    required String photo1,
    required String photo2,
    required String photo3,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updateProfilePhotos.php");
      // log("photo0:$photo0");
      // log("photo1:$photo1");
      // log("photo2:$photo2");
      log("photo3:$userid");

      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'user_id': userid,
        'photo_0': photo0,
        'photo_1': photo1,
        'photo_2': photo2,
        'photo_3': photo3,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
        print('PHOTO UPLOAD SUCESS');
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future givepermission({
    required String photopermission,
    required String phonepermission,
    required String emailpermission,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/updateProfileSettings.php");

      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'user_id': userid,
        'pic_visibilibity': photopermission,
        "contact_visibilibity": phonepermission,
        "email_visibilibity": emailpermission
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deletephoto({
    required String index,
    required WidgetRef ref
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getString('userid');
      var url = Uri.parse("$mainurl/deletePhoto.php");

      var response = await http.post(url, body: {
        'API_KEY': APIkey,
        'user_id': userid,
        'photo_index': index,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        toast(data['message']);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var userid = prefs.getString('userid');
        getuserprofile(id: userid.toString(), ref: ref);
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
