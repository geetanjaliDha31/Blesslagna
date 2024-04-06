import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<bool> createprofile({
  required WidgetRef ref,
  required String userid,
  required String username,
  required String height,
  required String dob,
  required String maritalstatus,
  required String hobbies,
  required String weight,
  required String birthtime,
  required String noofchildren,
  required String mothertounge,
  required String language,
  required String brithplace,
  required String profilecreateby,
  required String religion,
  required String cast,
  required String subcast,
  required String manglikstatus,
  required String star,
  required String horoscope,
  required String gotra,
  required String moonsign,
  required String education,
  required String occupation,
  required String annualincome,
  required String employeein,
  required String designation,
  required String bodytype,
  required String skintype,
  required String bloodgroup,
  required String eatinghabit,
  required String smokinghabit,
  required String drinkinghabit,
  required String country,
  required String state,
  required String city,
  required String address,
  required String mobile,
  required String phone,
  required String timetocall,
  required String residence,
  required String familytype,
  required String fathername,
  required String fatheroccupation,
  required String mothername,
  required String motheroccupation,
  required String noofbrothers,
  required String noofsisters,
  required String nomarriedbrothers,
  required String nomarriedsisters,
  required String aboutfamily,
  required String userimage,
  required String userdocument,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/createProfile.php'));

  print(
      "userid : $userid \n$username + $height + $dob + $maritalstatus + $language + $mothertounge + $religion + $cast + $education + $occupation +$annualincome + $country + $state + $city");
  print("userdoc:$userdocument");
  print("userimage:$userimage");

  log("Time to call:$timetocall");
  log("birth Time:$birthtime");
  log("blood grp:$bloodgroup");

  // add file to multipart

  // add form data
  request.fields.addAll({
    'API_KEY': APIkey,
    'id': userid,
    'fullname': username,
    'height': height,
    'dob': dob,
    'marital_status': maritalstatus,
    'hobbies': hobbies,
    'weight': weight,
    'birth_time': birthtime,
    'no_of_children': noofchildren,
    'mother_tounge': mothertounge,
    'languages': language,
    'birth_place': brithplace,
    'profile_created_by': profilecreateby,
    'religion': religion,
    'cast': cast,
    'subcast': subcast,
    'manglik_status': manglikstatus,
    'star': star,
    'horoscope': horoscope,
    'gotra': gotra,
    'moonsign': moonsign,
    'education': education,
    'occupation': occupation,
    'annual_income': annualincome,
    'employee_in': employeein,
    'designation': designation,
    'body_type': bodytype,
    'skin_type': skintype,
    'blood_group': bloodgroup,
    'eating_habit': eatinghabit,
    'smoking_habit': smokinghabit,
    'drinking_habit': drinkinghabit,
    'country': country,
    'state': state,
    'city': city,
    'address': address,
    'mobile': mobile,
    'phone': phone,
    'time_to_call': timetocall,
    'residence': residence,
    'family_type': familytype,
    'father_name': fathername,
    'father_occupation': fatheroccupation,
    'mother_name': mothername,
    'mother_occupation': motheroccupation,
    'no_of_brothers': noofbrothers,
    'no_of_sisters': noofsisters,
    'no_married_brothers': nomarriedbrothers,
    'no_married_sisters': nomarriedsisters,
    'about_family': aboutfamily,
    'profile_photo': userimage,
    'user_document': userdocument
  });

  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  print(responsedata.body);

  if (response.statusCode == 200) {
    print("apicomecreateuser");
    var data = jsonDecode(responsedata.body);
    if (!data['error']) {
      prefs.setString('userid', data['user_id']);
      toast(data['message']);
      return true;
    } else {
      toast(data['message']);
      return false;
    }
  } else {
    // Handle any errors or other status codes here
    log('Error: ${response.statusCode}createprofile');
    return false;
  }
}
