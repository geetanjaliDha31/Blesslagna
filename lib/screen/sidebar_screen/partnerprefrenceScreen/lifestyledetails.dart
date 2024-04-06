import 'dart:developer';

import 'package:blesslagna/API/paramerter_api/cityparameter.dart';
import 'package:blesslagna/API/paramerter_api/stateparameter.dart';
import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateperefrence_api/locationpp.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/findid.dart';
import 'package:blesslagna/provider/showloader.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LifestyleDetailsPP extends ConsumerStatefulWidget {
  const LifestyleDetailsPP({super.key});

  @override
  ConsumerState<LifestyleDetailsPP> createState() => _LifestyleDetailsPPState();
}

class _LifestyleDetailsPPState extends ConsumerState<LifestyleDetailsPP> {
  StateProvider editableflifestylepp = StateProvider((ref) => false);
  final List residancelist = ["Select Residance", "NRI", "INDIAN"];
  String? residancetype = "Select Residance";
  String countryid = '';
  String stateid = '';
  String cityid = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final edit = ref.watch(editableflifestylepp);

    final countrytype = ref.watch(countryProvider);
    final country = ref.watch(onlycountryProvider);

    final statetype = ref.watch(stateProvider);
    final state = ref.watch(onlystateProvider);

    final citytype = ref.watch(cityProvider);
    final city = ref.watch(onlycityProvider);

    final userdetails = ref.watch(userdetailProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ref.watch(editableflifestylepp.notifier).state = !edit;
                setState(() {});
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: edit
                        ? SvgPicture.asset('assets/cross.svg')
                        : SvgPicture.asset('assets/edit.svg')),
              ),
            ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Select Country"
                        : userdetails.preferenceArray![0]
                                    .locationPreferenceArray![0].country
                                    .toString() ==
                                ""
                            ? "Select Country"
                            : userdetails.preferenceArray![0]
                                .locationPreferenceArray![0].country
                                .toString())
                : DropdownButtonHideUnderline(
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

                        value:
                            //  !editcontry
                            //     ? country.countriesArray!.contains(userdetails
                            //             .locationDetailsArray![0].country
                            //             .toString())
                            //         ? userdetails.locationDetailsArray![0].country
                            //             .toString()
                            //         : countrytype
                            //     :
                            countrytype,

                        onChanged: (value) {
                          // ref.watch(editablecountry.notifier).state = true;
                          showloader(context: context);
                          ref.watch(countryProvider.notifier).state =
                              value as String;
                          String id = findIdByName(
                              name: value.toString(),
                              list: country.countriesArray!,
                              type: "1");
                          getState(countryid: id.toString(), ref: ref)
                              .whenComplete(() {
                            countryid = id;
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Select State"
                        : userdetails.preferenceArray![0]
                                    .locationPreferenceArray![0].state
                                    .toString() ==
                                ""
                            ? "Select State"
                            : userdetails.preferenceArray![0]
                                .locationPreferenceArray![0].state
                                .toString())
                : DropdownButtonHideUnderline(
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
                        value:
                            // editstate
                            //     ? state.statesArray!.contains(userdetails
                            //             .locationDetailsArray![0].state
                            //             .toString())
                            //         ? userdetails.locationDetailsArray![0].state
                            //             .toString()
                            //         : statetype
                            //     :
                            statetype,
                        onChanged: (value) {
                          // ref.watch(editablestate.notifier).state = true;
                          showloader(context: context);
                          ref.watch(stateProvider.notifier).state =
                              value as String;
                          print(value);
                          String id = findIdByName(
                              name: value.toString(),
                              list: state.statesArray!,
                              type: "2");
                          print('location$id');
                          getcity(stateid: id.toString(), ref: ref)
                              .whenComplete(() {
                            stateid = id;
                            Navigator.pop(context);
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Select City"
                        : userdetails.preferenceArray![0]
                                    .locationPreferenceArray![0].city
                                    .toString() ==
                                ""
                            ? "Select City"
                            : userdetails.preferenceArray![0]
                                .locationPreferenceArray![0].city
                                .toString())
                : DropdownButtonHideUnderline(
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
                        items: city.citiesArray!
                            .map((item) => DropdownMenuItem(
                                  value: item.cityName,
                                  child: Text(
                                    item.cityName.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value:
                            // !editcity
                            //     ? city.citiesArray!.contains(userdetails
                            //             .locationDetailsArray![0].city
                            //             .toString())
                            //         ? userdetails.locationDetailsArray![0].city.toString()
                            //         : citytype
                            //     :
                            citytype,
                        onChanged: (value) {
                          ref.watch(cityProvider.notifier).state =
                              value as String;

                          String id = findIdByName(
                              name: value.toString(),
                              list: city.citiesArray!,
                              type: "3");
                          log("cityid$id");
                          cityid = id;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Select Residence"
                        : userdetails.preferenceArray![0]
                                    .locationPreferenceArray![0].residence
                                    .toString() ==
                                ""
                            ? "Select Residence"
                            : userdetails.preferenceArray![0]
                                .locationPreferenceArray![0].residence
                                .toString())
                : DropdownButtonHideUnderline(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
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
                        items: residancelist
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
                        value:
                            // !editresidance
                            //     ? residancelist.contains(userdetails
                            //             .locationDetailsArray![0].residence
                            //             .toString())
                            //         ? userdetails.locationDetailsArray![0].residence
                            //             .toString()
                            //         : residancetype
                            //     :

                            residancetype,
                        onChanged: (value) {
                          // ref.watch(editableresidance.notifier).state = true;
                          setState(() {
                            residancetype = value as String;
                            ref.watch(nriProvider.notifier).state = value;
                          });
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: edit
          ? ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                var userid = prefs.getString('userid');
                if (edit) {
                  locationppupdate(
                          countryid: countryid,
                          stateid: stateid,
                          city: cityid,
                          residence: ref.watch(nriProvider).toString())
                      .whenComplete(() {
                    setState(() {
                      getuserprofile(ref: ref, id: userid.toString());
                      ref.watch(editableflifestylepp.notifier).state = false;
                    });
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: primary,
                  minimumSize: Size(MediaQuery.of(context).size.width, 50)),
              child: const Text(
                "Update",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ))
          : const SizedBox.shrink(),
    );
  }

  defaultcontainer({required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: Color(
                0x3f000000,
              ), //New
              blurRadius: 1.0,
              offset: Offset(0, 0))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
