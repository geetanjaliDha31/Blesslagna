// Widget showImage(BuildContext context) {
//   return CircleAvatar(
//       radius: 33, backgroundImage: MemoryImage(base64Decode(base64String)));
// }

String findIdByName(
    {required String name, required List list, required String type}) {
  if (type == "1") {
    for (var item in list) {
      if (item.countryName == name) {
        return item.countryId;
      }
    }
  } else if (type == '2') {
    print(name);
    for (var item in list) {
      if (item.stateName == name) {
        return item.stateId.toString();
      }
    }
  } else if (type == '3') {
    print(name);
    for (var item in list) {
      if (item.cityName == name) {
        return item.cityId.toString();
      }
    }
  }
  return "";
  // Return -1 if the name is not found
}

bool is18OrOlder(String birthDateStr) {
  // Split the birthDate string to get year, month, and day
  List<String> parts = birthDateStr.split('-');
  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Calculate age
  int age = currentDate.year - year;
  if (currentDate.month < month ||
      (currentDate.month == month && currentDate.day < day)) {
    age--;
  }

  // Check if the age is 18 or older
  return age >= 18;
}
