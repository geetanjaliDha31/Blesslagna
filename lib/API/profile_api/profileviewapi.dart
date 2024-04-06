import 'dart:convert';
import 'dart:developer';
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future getreciptprofile({required WidgetRef ref, required String id}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String userid = prefs.getString('userid')!;
  var request =
      http.MultipartRequest('POST', Uri.parse('$mainurl/getProfileDetail.php'));

  request.fields.addAll({
    'matrimonial_id': id,
    'user_id': userid.toString(),
    'API_KEY': APIkey,
  });

  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    ref.watch(recipteuSerProvider.notifier).state =
        RecipteuserModel.fromJson(json.decode(responsedata.body));
  } else {
    ref.watch(recipteuSerProvider.notifier).state = RecipteuserModel();
    log("${response.statusCode}profileview");
    return null;
  }
}

class RecipteuserModel {
  String? response;
  bool? error;
  String? message;
  List<BasicDetailsArray>? basicDetailsArray;
  List<ReligiousArray>? religiousArray;
  List<EduOccupationArray>? eduOccupationArray;
  List<LifestyleDetailsArray>? lifestyleDetailsArray;
  List<LocationDetailsArray>? locationDetailsArray;
  List<FamilyDetailsArray>? familyDetailsArray;
  List<PreferenceArray>? preferenceArray;

  RecipteuserModel(
      {this.response,
      this.error,
      this.message,
      this.basicDetailsArray,
      this.religiousArray,
      this.eduOccupationArray,
      this.lifestyleDetailsArray,
      this.locationDetailsArray,
      this.familyDetailsArray,
      this.preferenceArray});

  RecipteuserModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    error = json['error'];
    message = json['message'];
    if (json['basic_details_array'] != null) {
      basicDetailsArray = <BasicDetailsArray>[];
      json['basic_details_array'].forEach((v) {
        basicDetailsArray!.add(new BasicDetailsArray.fromJson(v));
      });
    }
    if (json['religious_array'] != null) {
      religiousArray = <ReligiousArray>[];
      json['religious_array'].forEach((v) {
        religiousArray!.add(new ReligiousArray.fromJson(v));
      });
    }
    if (json['edu_occupation_array'] != null) {
      eduOccupationArray = <EduOccupationArray>[];
      json['edu_occupation_array'].forEach((v) {
        eduOccupationArray!.add(new EduOccupationArray.fromJson(v));
      });
    }
    if (json['lifestyle_details_array'] != null) {
      lifestyleDetailsArray = <LifestyleDetailsArray>[];
      json['lifestyle_details_array'].forEach((v) {
        lifestyleDetailsArray!.add(new LifestyleDetailsArray.fromJson(v));
      });
    }
    if (json['location_details_array'] != null) {
      locationDetailsArray = <LocationDetailsArray>[];
      json['location_details_array'].forEach((v) {
        locationDetailsArray!.add(new LocationDetailsArray.fromJson(v));
      });
    }
    if (json['family_details_array'] != null) {
      familyDetailsArray = <FamilyDetailsArray>[];
      json['family_details_array'].forEach((v) {
        familyDetailsArray!.add(new FamilyDetailsArray.fromJson(v));
      });
    }
    if (json['preference_array'] != null) {
      preferenceArray = <PreferenceArray>[];
      json['preference_array'].forEach((v) {
        preferenceArray!.add(new PreferenceArray.fromJson(v));
      });
    }
  }
}

class BasicDetailsArray {
  String? matrimonialId;
  String? name;
  String? height;
  String? age;
  String? maritalStatus;
  String? hobbies;
  String? weight;
  String? phoneno;
  String? birthtime;
  String? noOfChildren;
  String? motherTongue;
  String? language;
  String? birthplace;
  String? image;
  bool? isPaidMember;
  String? firebaseId;
  String? photo1;
  String? photo2;
  String? photo3;
  String? photo4;

  BasicDetailsArray(
      {this.matrimonialId,
      this.name,
      this.height,
      this.age,
      this.maritalStatus,
      this.hobbies,
      this.weight,
      this.phoneno,
      this.birthtime,
      this.noOfChildren,
      this.motherTongue,
      this.language,
      this.birthplace,
      this.image,
      this.isPaidMember,
      this.firebaseId,
      this.photo1,
      this.photo2,
      this.photo3,
      this.photo4});

  BasicDetailsArray.fromJson(Map<String, dynamic> json) {
    matrimonialId = json['matrimonial_id'];
    name = json['name'];
    height = json['height'];
    age = json['age'];
    maritalStatus = json['marital_status'];
    phoneno = json['phone'];
    hobbies = json['hobbies'];
    weight = json['weight'];
    birthtime = json['birthtime'];
    noOfChildren = json['no_of_children'];
    motherTongue = json['mother_tongue'];
    language = json['language'];
    birthplace = json['birthplace'];
    image = json['image'];
    isPaidMember = json['isPaidMember'];
    firebaseId = json['firebase_id'];
    photo1 = json['photo1'];
    photo2 = json['photo2'];
    photo3 = json['photo3'];
    photo4 = json['photo4'];
  }
}

class ReligiousArray {
  String? religion;
  String? caste;
  String? subcaste;
  String? manglik;
  String? star;
  String? horoscope;
  String? gotra;
  String? moonsign;

  ReligiousArray(
      {this.religion,
      this.caste,
      this.subcaste,
      this.manglik,
      this.star,
      this.horoscope,
      this.gotra,
      this.moonsign});

  ReligiousArray.fromJson(Map<String, dynamic> json) {
    religion = json['religion'];
    caste = json['caste'];
    subcaste = json['subcaste'];
    manglik = json['manglik'];
    star = json['star'];
    horoscope = json['horoscope'];
    gotra = json['gotra'];
    moonsign = json['moonsign'];
  }
}

class EduOccupationArray {
  String? education;
  String? employeeIn;
  String? annualIncome;
  String? occupation;
  String? designation;

  EduOccupationArray(
      {this.education,
      this.employeeIn,
      this.annualIncome,
      this.occupation,
      this.designation});

  EduOccupationArray.fromJson(Map<String, dynamic> json) {
    education = json['education'];
    employeeIn = json['employee_in'];
    annualIncome = json['annual_income'];
    occupation = json['occupation'];
    designation = json['designation'];
  }
}

class LifestyleDetailsArray {
  String? bodyType;
  String? skinTone;
  String? bloodGroup;
  String? eatingHabbit;
  String? smokingHabbit;
  String? drinkingHabbit;

  LifestyleDetailsArray(
      {this.bodyType,
      this.skinTone,
      this.bloodGroup,
      this.eatingHabbit,
      this.smokingHabbit,
      this.drinkingHabbit});

  LifestyleDetailsArray.fromJson(Map<String, dynamic> json) {
    bodyType = json['body_type'];
    skinTone = json['skin_tone'];
    bloodGroup = json['blood_group'];
    eatingHabbit = json['eating_habbit'];
    smokingHabbit = json['smoking_habbit'];
    drinkingHabbit = json['drinking_habbit'];
  }
}

class LocationDetailsArray {
  String? country;
  String? state;
  String? city;
  String? address;
  String? phone;
  String? timeToCall;
  String? residence;

  LocationDetailsArray(
      {this.country,
      this.state,
      this.city,
      this.address,
      this.phone,
      this.timeToCall,
      this.residence});

  LocationDetailsArray.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    phone = json['phone'];
    timeToCall = json['time_to_call'];
    residence = json['residence'];
  }
}

class FamilyDetailsArray {
  String? familyType;
  String? fathersName;
  String? fathersOccupation;
  String? mothersName;
  String? mothersOccupation;
  String? noOfBrothers;
  String? noOfMarriedBrothers;
  String? noOfSisters;
  String? noOfMarriedSisters;
  String? aboutFamily;

  FamilyDetailsArray(
      {this.familyType,
      this.fathersName,
      this.fathersOccupation,
      this.mothersName,
      this.mothersOccupation,
      this.noOfBrothers,
      this.noOfMarriedBrothers,
      this.noOfSisters,
      this.noOfMarriedSisters,
      this.aboutFamily});

  FamilyDetailsArray.fromJson(Map<String, dynamic> json) {
    familyType = json['family_type'];
    fathersName = json['fathers_name'];
    fathersOccupation = json['fathers_occupation'];
    mothersName = json['mothers_name'];
    mothersOccupation = json['mothers_occupation'];
    noOfBrothers = json['no_of_brothers'];
    noOfMarriedBrothers = json['no_of_married_brothers'];
    noOfSisters = json['no_of_sisters'];
    noOfMarriedSisters = json['no_of_married_sisters'];
    aboutFamily = json['about_family'];
  }
}

class PreferenceArray {
  List<BasicPreferenceArray>? basicPreferenceArray;
  List<ReligiousPreferenceArray>? religiousPreferenceArray;
  List<EduPreferenceArray>? eduPreferenceArray;
  List<LocationPreferenceArray>? locationPreferenceArray;

  PreferenceArray(
      {this.basicPreferenceArray,
      this.religiousPreferenceArray,
      this.eduPreferenceArray,
      this.locationPreferenceArray});

  PreferenceArray.fromJson(Map<String, dynamic> json) {
    if (json['basic_preference_array'] != null) {
      basicPreferenceArray = <BasicPreferenceArray>[];
      json['basic_preference_array'].forEach((v) {
        basicPreferenceArray!.add(new BasicPreferenceArray.fromJson(v));
      });
    }
    if (json['religious_preference_array'] != null) {
      religiousPreferenceArray = <ReligiousPreferenceArray>[];
      json['religious_preference_array'].forEach((v) {
        religiousPreferenceArray!.add(new ReligiousPreferenceArray.fromJson(v));
      });
    }
    if (json['edu_preference_array'] != null) {
      eduPreferenceArray = <EduPreferenceArray>[];
      json['edu_preference_array'].forEach((v) {
        eduPreferenceArray!.add(new EduPreferenceArray.fromJson(v));
      });
    }
    if (json['location_preference_array'] != null) {
      locationPreferenceArray = <LocationPreferenceArray>[];
      json['location_preference_array'].forEach((v) {
        locationPreferenceArray!.add(new LocationPreferenceArray.fromJson(v));
      });
    }
  }
}

class BasicPreferenceArray {
  String? lookingFor;
  String? fromAge;
  String? toAge;
  String? fromHeight;
  String? toheight;
  String? skintype;
  String? generalExpt;
  String? mothertounge;
  String? eatingHabit;
  String? drinkingHabit;

  BasicPreferenceArray(
      {this.lookingFor,
      this.fromAge,
      this.toAge,
      this.fromHeight,
      this.toheight,
      this.skintype,
      this.generalExpt,
      this.mothertounge,
      this.eatingHabit,
      this.drinkingHabit});

  BasicPreferenceArray.fromJson(Map<String, dynamic> json) {
    lookingFor = json['looking_for'];
    fromAge = json['from_age'];
    toAge = json['to_age'];
    fromHeight = json['from_height'];
    toheight = json['to_height'];
    skintype = json['skin_type'];
    generalExpt = json['general_expt'];
    mothertounge = json['mothertounge'];
    eatingHabit = json['eating_habit'];
    drinkingHabit = json['drinking_habit'];
  }
}

class ReligiousPreferenceArray {
  String? religon;
  String? caste;
  String? manglik;
  String? star;

  ReligiousPreferenceArray({this.religon, this.caste, this.manglik, this.star});

  ReligiousPreferenceArray.fromJson(Map<String, dynamic> json) {
    religon = json['religon'];
    caste = json['caste'];
    manglik = json['manglik'];
    star = json['star'];
  }
}

class EduPreferenceArray {
  String? education;
  String? occupation;
  String? income;

  EduPreferenceArray({this.education, this.occupation, this.income});

  EduPreferenceArray.fromJson(Map<String, dynamic> json) {
    education = json['education'];
    occupation = json['occupation'];
    income = json['annual_income'];
  }
}

class LocationPreferenceArray {
  String? countryId;
  String? country;
  String? stateId;
  String? state;
  String? cityId;
  String? city;
  String? residence;

  LocationPreferenceArray(
      {this.countryId,
      this.country,
      this.stateId,
      this.state,
      this.cityId,
      this.city,
      this.residence});

  LocationPreferenceArray.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    country = json['country'];
    stateId = json['state_id'];
    state = json['state'];
    cityId = json['city_id'];
    city = json['city'];
    residence = json['residence'];
  }
}
