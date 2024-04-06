import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:blesslagna/constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future getparameter({required WidgetRef ref}) async {
  log('come');
  var request = http.MultipartRequest(
      'POST', Uri.parse('$mainurl/getFormParameters.php'));

  request.fields.addAll({
    'API_KEY': APIkey,
  });
  http.StreamedResponse response = await request.send();
  var responsedata = await http.Response.fromStream(response);

  if (response.statusCode == 200) {
    var data = json.decode(responsedata.body);
    incomeitems.addAll(data['income_array']);
    castitems.addAll(data['caste_array']);
    jobitems.addAll(data['job_array']);
    mothertoungeitems.addAll(data['mother_tongue_array']);
    heightitems.addAll(data['height_array']);
    ageitems.addAll(data['age_array']);
    bodytypeitems.addAll(data['body_type_array']);
    skintoneitems.addAll(data['skin_type_array']);
    religioitems.addAll(data['religion_array']);
  } else {
    log('${response.statusCode}getparameter');
  }
}
