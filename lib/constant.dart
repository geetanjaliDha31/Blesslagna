import 'package:blesslagna/API/drawer_api/blockprofileapi.dart';
import 'package:blesslagna/API/drawer_api/iviewdprofile.dart';
import 'package:blesslagna/API/drawer_api/myshortlistapi.dart';
import 'package:blesslagna/API/drawer_api/myviewdprofile.dart';
import 'package:blesslagna/API/drawer_api/packageapi.dart';
import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/API/home_api/getrequestapi.dart';
import 'package:blesslagna/API/home_api/searchapi.dart';
import 'package:blesslagna/API/miscellaneous.dart';
import 'package:blesslagna/API/paramerter_api/cityparameter.dart';
import 'package:blesslagna/API/paramerter_api/countryparameter.dart';
import 'package:blesslagna/API/paramerter_api/stateparameter.dart';
import 'package:blesslagna/API/profile_api/profileviewapi.dart';
import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

//API Constant
// String mainurl = 'https://app.blesslagna.com/app_apis';
String mainurl = 'https://blesslagna.com/app/app_apis';
String APIkey = "sXZ7tdYP7hy2qZKD9cL";

//Toast
void toast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

//Zego Colud Constant
int appidzego = 1540761250;
String appsignzego =
    'a27e15bd7d8176111f1e20182045ebfdccac0479a0c5df0c32f7b288641c944e';
final navigatorKey = GlobalKey<NavigatorState>();

//chat Constat
const String wsUrl = 'ws://172.105.33.114:6060';

const String baseUrlNode = 'http://172.105.33.114:3003';

//User details and opossite user details Provider
StateProvider<RecipteuserModel> recipteuSerProvider =
    StateProvider((ref) => RecipteuserModel());
StateProvider<UserProfile> userdetailProvider =
    StateProvider((ref) => UserProfile());

StateProvider<NewMatchesModel> homedataProvider =
    StateProvider((ref) => NewMatchesModel());

StateProvider<ShortlistModel> shortlistprofileProvider =
    StateProvider((ref) => ShortlistModel());
StateProvider shortlistprofileemptyProvider = StateProvider((ref) => false);

StateProvider<IviewedProfileModel> iviewedprofileProvider =
    StateProvider((ref) => IviewedProfileModel());
StateProvider iviewedprofileemptyProvider = StateProvider((ref) => false);

StateProvider myviewedprofileProvider = StateProvider((ref) => MyViewedModel());
StateProvider myviewedprofileemptyProvider = StateProvider((ref) => false);

StateProvider<BlockProfileModel> blockprofileProvider =
    StateProvider((ref) => BlockProfileModel());

StateProvider blockprofileemptyProvider = StateProvider((ref) => false);

StateProvider<SerachGetbyID> searchProvider =
    StateProvider((ref) => SerachGetbyID());

StateProvider searchemptyProvider = StateProvider((ref) => false);

StateProvider<PackageModel> packageProvider =
    StateProvider((ref) => PackageModel());
StateProvider<RequestModel> requestProvider =
    StateProvider((ref) => RequestModel());

StateProvider loginProvider = StateProvider((ref) => false);
StateProvider otpverifyProvider = StateProvider((ref) => false);

StateProvider userprofilepicProvider = StateProvider((ref) => '');
StateProvider userdocumentpicProvider = StateProvider((ref) => '');

StateProvider<chatlistModel> chatlistProvider =
    StateProvider((ref) => chatlistModel());

//Parameter constant
List incomeitems = ['Select Income'];
List castitems = ['Select Cast'];
List countryitems = ['Select Country'];
List jobitems = ['Select Education'];
List mothertoungeitems = ['Mother Tounge'];
List heightitems = ['Height'];
List ageitems = ['Age'];
List bodytypeitems = ['Body Type'];
List skintoneitems = ['Skin Tone'];
List religioitems = ['Select Religon'];

StateProvider<CountriesModel> onlycountryProvider =
    StateProvider((ref) => CountriesModel());
StateProvider<StateModel> onlystateProvider =
    StateProvider((ref) => StateModel());
StateProvider<CityModel> onlycityProvider = StateProvider((ref) => CityModel());

final customCacheManager = CacheManager(Config('customCacheManager',
    stalePeriod: const Duration(minutes: 20), maxNrOfCacheObjects: 100));

StateProvider countrysearchProvider = StateProvider((ref) => '');
StateProvider statesearchProvider = StateProvider((ref) => '');
StateProvider citysearchProvider = StateProvider((ref) => '');
StateProvider maritalstatussearchProvider = StateProvider((ref) => '');
StateProvider mothertoungesearchProvider = StateProvider((ref) => '');
