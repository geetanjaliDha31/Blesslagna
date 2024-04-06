import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:blesslagna/API/home_api/searchapi.dart';
import 'package:blesslagna/API/paramerter_api/cityparameter.dart';
import 'package:blesslagna/API/paramerter_api/stateparameter.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/findid.dart';
import 'package:blesslagna/provider/showloader.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:blesslagna/screen/widget/multiselecte.dart';
import 'package:blesslagna/screen/widget/searchresultpage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:search_choices/search_choices.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final NewMatches? newmatchdata;
  final PremiumMatches? premiumMatches;
  final bool? isPaidMember;
  const SearchScreen({
    super.key,
    this.newmatchdata,
    this.premiumMatches,
    this.isPaidMember,
  });

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchid = TextEditingController();
  TextEditingController agefrom = TextEditingController();
  TextEditingController ageto = TextEditingController();

  final List categorys = ["Select Gender", "Male", "Female", "TransGender"];
  String? categorytypes = "Select Gender";

  final List mariedstatus = [
    "Marital Status",
    "Never Married",
    "Divorced",
    "Window",
  ];

  StateProvider heighProviders1 = StateProvider((ref) => 'Height');
  StateProvider heighProviders2 = StateProvider((ref) => 'Height');
  StateProvider ageProviders1 = StateProvider((ref) => 'Age');
  StateProvider ageProviders2 = StateProvider((ref) => 'Age');
  List<String> selectedItems = [];
  List<String> selectedcastItems = [];

  void _showMultiSelect({required String tyoe}) async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API

    //educatiom
    if (tyoe == 'education') {
      final List items = jobitems;
      final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelect(items: items, type: 'education');
        },
      );
      selectedItems = results!;
    }
    //country
    // else if (tyoe == 'country') {
    //   final List items = ref.watch(onlycountryProvider).countriesArray!;
    //   final List<String>? results = await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return MultiSelect(items: items, type: 'country');
    //     },
    //   );
    //   selectedItems = results!;
    // }
    // //state
    // else if (tyoe == 'state') {
    //   final List items = ref.watch(onlystateProvider).statesArray!;
    //   final List<String>? results = await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return MultiSelect(items: items, type: 'state');
    //     },
    //   );
    //   selectedItems = results!;
    // }
    // //city
    // else if (tyoe == 'city') {
    //   final List items = ref.watch(onlycityProvider).citiesArray!;
    //   final List<String>? results = await showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return MultiSelect(items: items, type: 'city');
    //     },
    //   );
    //   selectedItems = results!;
    // }
    //city
    else if (tyoe == 'marital') {
      final List items = mariedstatus;
      final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelect(items: items, type: 'marital');
        },
      );
      selectedItems = results!;
    }
    //city
    else if (tyoe == 'mother') {
      final List items = mothertoungeitems;
      final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelect(items: items, type: 'mother');
        },
      );
      selectedItems = results!;
    }

    // Update UI
    // if (results != null) {
    //   setState(() {
    //     print(results);
    //     selectedItems = results;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final religontype = ref.watch(religionProvider);
    final casttype = ref.watch(castProvider);
    final education = ref.watch(educationProvider);
    final height1 = ref.watch(heighProviders1);
    final height2 = ref.watch(heighProviders2);
    final homedata = ref.watch(homedataProvider);
    final countrytype = ref.watch(countryProvider);
    final country = ref.watch(onlycountryProvider);
    final statetype = ref.watch(stateProvider);
    final state = ref.watch(onlystateProvider);
    final citytype = ref.watch(cityProvider);
    final city = ref.watch(onlycityProvider);
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search by ID',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: primary),
          ),
          const SizedBox(height: 20),
          TextFormField(
            //border

            controller: searchid,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              suffixIcon: GestureDetector(
                  onTap: () {
                    searchid.text.isEmpty
                        ? toast("Enter ID")
                        : SearchApi()
                            .getbyid(id: searchid.text, ref: ref)
                            .whenComplete(
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchResult(
                                    newmatchdata: homedata.newMatches![0],
                                    premiumMatches: homedata.premiumMatches![0],
                                    isPaidMember: widget.isPaidMember!,
                                  ),
                                ),
                              ),
                            );
                  },
                  child: Icon(Icons.search, color: primary)),
              //label
              floatingLabelStyle: TextStyle(
                  color: textcolor, fontSize: 14, fontWeight: FontWeight.w400),
              label: Text(
                "ID ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'Enter Id',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          const SizedBox(height: 20),
          Text(
            'Search',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: primary),
          ),
          const SizedBox(height: 20),
          Container(
            height: 70,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff9A9A9A)),
                borderRadius: BorderRadius.circular(8)),
            child: SearchChoices.single(
              items: religioitems
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              value: religontype,
              hint: "Select Religion",
              searchHint: "Search for Religion",
              onChanged: (newValue) {
                ref.watch(religionProvider.notifier).state = newValue;
              },
              isExpanded: true,
              displayClearIcon: false, // Whether to display a clear icon
              underline: Container(), // To remove underline
              searchInputDecoration: InputDecoration(
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                width: width / 2.4,
                child: DropdownButtonHideUnderline(
                  child: Container(
                    width: width / 2.3,
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff9A9A9A)),
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButton2(
                      // buttonDecoration: shadowdecoration,
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      items: categorys
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: categorytypes,
                      onChanged: (value) {
                        setState(() {
                          categorytypes = value as String;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Container(
                height: 70,
                width: width / 2.4,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                child: SearchChoices.single(
                  items: castitems
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  value: casttype,
                  hint: "Select Cast",
                  searchHint: "Search for Cast",
                  onChanged: (newValue) {
                    ref.watch(castProvider.notifier).state = newValue;
                  },
                  isExpanded: true,
                  displayClearIcon: false, // Whether to display a clear icon
                  underline: Container(), // To remove underline
                  searchInputDecoration: InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                height: 70,
                width: width / 2.4,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                child: SearchChoices.single(
                  items: ageitems
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  value: ref.watch(ageProviders1),
                  hint: "Select Age From",
                  searchHint: "Search for Age From",
                  onChanged: (newValue) {
                    ref.watch(ageProviders1.notifier).state =
                        newValue as String;
                  },
                  isExpanded: true,
                  displayClearIcon: false, // Whether to display a clear icon
                  underline: Container(), // To remove underline
                  searchInputDecoration: InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Container(
                height: 70,
                width: width / 2.4,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                child: SearchChoices.single(
                  items: ageitems
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  value: ref.watch(ageProviders2),
                  hint: "Select Age From",
                  searchHint: "Search for Age From",
                  onChanged: (newValue) {
                    ref.watch(ageProviders2.notifier).state =
                        newValue as String;
                  },
                  isExpanded: true,
                  displayClearIcon: false, // Whether to display a clear icon
                  underline: Container(), // To remove underline
                  searchInputDecoration: InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                height: 70,
                width: width / 2.4,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                child: SearchChoices.single(
                  items: heightitems
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  value: height1,
                  hint: "Select Height From",
                  searchHint: "Search for Height From",
                  onChanged: (newValue) {
                    ref.watch(heighProviders1.notifier).state =
                        newValue as String;
                  },
                  isExpanded: true,
                  displayClearIcon: false, // Whether to display a clear icon
                  underline: Container(), // To remove underline
                  searchInputDecoration: InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Container(
                height: 70,
                width: width / 2.4,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                child: SearchChoices.single(
                  items: heightitems
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  value: height2,
                  hint: "Select Height From",
                  searchHint: "Search for Height From",
                  onChanged: (newValue) {
                    ref.watch(heighProviders2.notifier).state =
                        newValue as String;
                  },
                  isExpanded: true,
                  displayClearIcon: false, // Whether to display a clear icon
                  underline: Container(), // To remove underline
                  searchInputDecoration: InputDecoration(
                    hintText: "Search...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _showMultiSelect(tyoe: 'marital'),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Text(
                  ref.watch(maritalstatussearchProvider).toString() == ""
                      ? "Select Marital Status"
                      : ref.watch(maritalstatussearchProvider).toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _showMultiSelect(tyoe: 'mother'),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Text(
                  ref.watch(mothertoungesearchProvider).toString() == ""
                      ? "Select Mother tounge"
                      : ref.watch(mothertoungesearchProvider).toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _showMultiSelect(tyoe: 'education'),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Text(
                  education == "" ? "Select Education" : education,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          DropdownButtonHideUnderline(
            child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff9A9A9A)),
                  borderRadius: BorderRadius.circular(8)),
              child: DropdownButton2(
                // buttonDecoration: shadowdecoration,
                isExpanded: true,
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                items: country.countriesArray!
                    .map((item) => DropdownMenuItem(
                          value: item.countryName,
                          child: Text(
                            item.countryName.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ))
                    .toList(),

                value: countrytype,

                onChanged: (value) {
                  showloader(context: context);
                  ref.watch(countryProvider.notifier).state = value as String;
                  String id = findIdByName(
                      name: value.toString(),
                      list: country.countriesArray!,
                      type: "1");
                  getState(countryid: id.toString(), ref: ref).whenComplete(
                    () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonHideUnderline(
            child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff9A9A9A)),
                  borderRadius: BorderRadius.circular(8)),
              child: DropdownButton2(
                // buttonDecoration: shadowdecoration,
                isExpanded: true,
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                items: state.statesArray!
                    .map((item) => DropdownMenuItem(
                          value: item.stateName,
                          child: Text(
                            item.stateName.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ))
                    .toList(),
                value: statetype,
                onChanged: (value) {
                  showloader(context: context);
                  ref.watch(stateProvider.notifier).state = value as String;
                  print(value);
                  String id = findIdByName(
                      name: value.toString(),
                      list: state.statesArray!,
                      type: "2");
                  print('location$id');
                  getcity(stateid: id.toString(), ref: ref).whenComplete(() {
                    Navigator.pop(context);
                    setState(() {});
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          DropdownButtonHideUnderline(
            child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff9A9A9A)),
                  borderRadius: BorderRadius.circular(8)),
              child: DropdownButton2(
                // buttonDecoration: shadowdecoration,
                isExpanded: true,
                hint: Text("Select City"),
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                items: city.citiesArray!
                    .map(
                      (item) => DropdownMenuItem(
                        value: item.cityName,
                        child: Text(
                          item.cityName.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: citytype,
                onChanged: (value) {
                  ref.watch(cityProvider.notifier).state = value as String;
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          // InkWell(
          //   onTap: () => _showMultiSelect(tyoe: 'country'),
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 2),
          //     width: MediaQuery.of(context).size.width,
          //     height: 60,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       border:
          //           Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          //       // child: _buildSelectedItems(selectedItems),
          //       child: Row(
          //         children: [
          //           Text(
          //             ref.watch(countrysearchProvider) == ""
          //                 ? "Select Country"
          //                 : ref.watch(countrysearchProvider).toString(),
          //             style: const TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w300,
          //             ),
          //           ),
          //           // _buildSelectedItems(selectedItems),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          // InkWell(
          //   onTap: () => _showMultiSelect(tyoe: 'state'),
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 2),
          //     width: MediaQuery.of(context).size.width,
          //     height: 60,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       border:
          //           Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
          //       borderRadius: BorderRadius.circular(8),
          //       // boxShadow: const [
          //       //   BoxShadow(
          //       //       color: Color(
          //       //         0x3f000000,
          //       //       ), //New
          //       //       blurRadius: 1.0,
          //       //       offset: Offset(0, 0))
          //       // ],
          //     ),
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          //       child: Text(
          //         ref.watch(statesearchProvider) == ""
          //             ? "Select State"
          //             : ref.watch(statesearchProvider).toString(),
          //         style: const TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w300,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          // InkWell(
          //   onTap: () => _showMultiSelect(tyoe: 'city'),
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 2),
          //     width: MediaQuery.of(context).size.width,
          //     height: 60,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       border:
          //           Border.all(width: 1, color: Colors.black.withOpacity(0.4)),
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          //       child: Text(
          //         ref.watch(citysearchProvider) == ""
          //             ? "Select City"
          //             : ref.watch(citysearchProvider).toString(),
          //         style: const TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w300,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                print(ref.watch(countryProvider));
                print(ref.watch(stateProvider));
                print(ref.watch(cityProvider));
                if (searchid.text.isNotEmpty) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => processingPopup(
                        context: context, msg: "Processing...."),
                  );
                  SearchApi().getbyid(id: searchid.text, ref: ref).whenComplete(
                    () {
                      Navigator.pop(context);
                    },
                  );
                } else {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => processingPopup(
                        context: context, msg: "Processing...."),
                  );
                  SearchApi()
                      .getsearch(
                    ref: ref,
                    religon: religontype,
                    gender: categorytypes,
                    cast: casttype,
                    agefrom: ref.watch(ageProviders1),
                    ageto: ref.watch(ageProviders2),
                    heightfrom: height1,
                    heightto: height2,
                    eduction: education,
                    marital: ref.watch(maritalstatussearchProvider),
                    mother: ref.watch(mothertoungesearchProvider),
                    country: ref.watch(countryProvider),
                    state: ref.watch(stateProvider),
                    city: ref.watch(cityProvider),
                  )
                      .then((value) {
                    if (value == 'come') {
                      Navigator.pop(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const SearcshResult(),
                      //   ),
                      // );
                    } else {
                      Navigator.pop(context);
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: primary,
                  minimumSize: Size(width, 50)),
              child: const Text(
                "Search",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              )),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}


       // DropdownButtonHideUnderline(
          //   child: Container(
          //     width: width,
          //     height: 60,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: const Color(0xff9A9A9A)),
          //         borderRadius: BorderRadius.circular(8)),
          //     child: DropdownButton2(
          //       // buttonDecoration: shadowdecoration,
          //       isExpanded: true,
          //       buttonStyleData: const ButtonStyleData(
          //         padding: EdgeInsets.symmetric(horizontal: 16),
          //         height: 40,
          //         width: 140,
          //       ),
          //       items: country.countriesArray!
          //           .map((item) => DropdownMenuItem(
          //                 value: item.countryName,
          //                 child: Text(
          //                   item.countryName.toString(),
          //                   style: const TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //               ))
          //           .toList(),

          //       value: countrytype,

          //       onChanged: (value) {
          //         showloader(context: context);
          //         ref.watch(countryProvider.notifier).state = value as String;
          //         String id = findIdByName(
          //             name: value.toString(),
          //             list: country.countriesArray!,
          //             type: "1");
          //         getState(countryid: id.toString(), ref: ref).whenComplete(() {
          //           Navigator.pop(context);
          //           setState(() {});
          //         });
          //       },
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          // //state dropdown
          // DropdownButtonHideUnderline(
          //   child: Container(
          //     width: width,
          //     height: 60,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: const Color(0xff9A9A9A)),
          //         borderRadius: BorderRadius.circular(8)),
          //     child: DropdownButton2(
          //       // buttonDecoration: shadowdecoration,
          //       isExpanded: true,
          //       buttonStyleData: const ButtonStyleData(
          //         padding: EdgeInsets.symmetric(horizontal: 16),
          //         height: 40,
          //         width: 140,
          //       ),
          //       items: state.statesArray!
          //           .map((item) => DropdownMenuItem(
          //                 value: item.stateName,
          //                 child: Text(
          //                   item.stateName.toString(),
          //                   style: const TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //               ))
          //           .toList(),
          //       value: statetype,
          //       onChanged: (value) {
          //         showloader(context: context);
          //         ref.watch(stateProvider.notifier).state = value as String;
          //         print(value);
          //         String id = findIdByName(
          //             name: value.toString(),
          //             list: state.statesArray!,
          //             type: "2");
          //         print('location$id');
          //         getcity(stateid: id.toString(), ref: ref).whenComplete(() {
          //           Navigator.pop(context);
          //           setState(() {});
          //         });
          //       },
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          // //city dropdown
          // DropdownButtonHideUnderline(
          //   child: Container(
          //     width: width,
          //     height: 60,
          //     decoration: BoxDecoration(
          //         border: Border.all(color: const Color(0xff9A9A9A)),
          //         borderRadius: BorderRadius.circular(8)),
          //     child: DropdownButton2(
          //       // buttonDecoration: shadowdecoration,
          //       isExpanded: true,
          //       buttonStyleData: const ButtonStyleData(
          //         padding: EdgeInsets.symmetric(horizontal: 16),
          //         height: 40,
          //         width: 140,
          //       ),
          //       items: city.citiesArray!
          //           .map((item) => DropdownMenuItem(
          //                 value: item.cityName,
          //                 child: Text(
          //                   item.cityName.toString(),
          //                   style: const TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w400,
          //                   ),
          //                 ),
          //               ))
          //           .toList(),
          //       value: citytype,
          //       onChanged: (value) {
          //         ref.watch(cityProvider.notifier).state = value as String;
          //       },
          //     ),
          //   ),
          // ),
