import 'package:blesslagna/API/paramerter_api/cityparameter.dart';
import 'package:blesslagna/API/paramerter_api/stateparameter.dart';
import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateuserdata/updateuser.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/findid.dart';
import 'package:blesslagna/provider/showloader.dart';
import 'package:blesslagna/provider/timefunction.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationDetailsUpdate extends ConsumerStatefulWidget {
  const LocationDetailsUpdate({super.key});

  @override
  ConsumerState<LocationDetailsUpdate> createState() =>
      _LocationDetailsUpdateState();
}

class _LocationDetailsUpdateState extends ConsumerState<LocationDetailsUpdate> {
  List<String> countrystringList = [];
  List<String> statestringList = [];
  List<String> citystringList = [];
  TextEditingController address = TextEditingController();
  TimeOfDay? timecall;
  StateProvider editablelocation = StateProvider((ref) => false);
  StateProvider editablecountry = StateProvider((ref) => false);
  StateProvider editablestate = StateProvider((ref) => false);
  StateProvider editablecity = StateProvider((ref) => false);
  StateProvider editableresidance = StateProvider((ref) => false);
  final List residancelist = ["Select Residance", "NRI", "INDIAN"];
  String? residancetype = "Select Residance";

  @override
  void initState() {
    final userdetails = ref.read(userdetailProvider);
    address.text = userdetails.locationDetailsArray![0].address.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final edit = ref.watch(editablelocation);
    final editcontry = ref.watch(editablecountry);
    final editstate = ref.watch(editablestate);
    final editcity = ref.watch(editablecity);
    final editresidance = ref.watch(editableresidance);
    final countrytype = ref.watch(countryProvider);
    final country = ref.watch(onlycountryProvider);

    final statetype = ref.watch(stateProvider);
    final state = ref.watch(onlystateProvider);

    final citytype = ref.watch(cityProvider);
    final city = ref.watch(onlycityProvider);

    final userdetails = ref.watch(userdetailProvider);

    double width = MediaQuery.of(context).size.width;

    countrystringList = country.countriesArray!
        .map((item) => item.countryName.toString())
        .toList();
    statestringList =
        state.statesArray!.map((item) => item.stateName.toString()).toList();
    citystringList =
        city.citiesArray!.map((item) => item.cityName.toString()).toList();
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref.watch(editablelocation.notifier).state = !edit;
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
                      text: userdetails.locationDetailsArray![0].country
                          .toString())
                  :
                  // Container(
                  //     height: 70,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: const Color(0xff9A9A9A)),
                  //       borderRadius: BorderRadius.circular(8)),
                  //   child: SearchChoices.single(
                  //     items: countrystringList
                  //         .map((item) => DropdownMenuItem(
                  //             value: item, child: Text(item)))
                  //         .toList(),
                  //     value: !editcontry
                  //         ? country.countriesArray!.contains(userdetails
                  //                 .locationDetailsArray![0].country
                  //                 .toString())
                  //             ? userdetails.locationDetailsArray![0].country
                  //                 .toString()
                  //             : countrytype
                  //         : countrytype,
                  //     hint: "Select Country",
                  //     searchHint: "Search for country",
                  //     onChanged: (newValue) {
                  //       ref.watch(editablecountry.notifier).state = true;
                  //       showloader(context: context);
                  //       ref.watch(countryProvider.notifier).state =
                  //           newValue as String;
                  //       String id = findIdByName(
                  //           name: newValue.toString(),
                  //           list: country.countriesArray!,
                  //           type: "1");
                  //       getState(countryid: id.toString(), ref: ref)
                  //           .whenComplete(() {
                  //         statestringList = state.statesArray!
                  //             .map((item) => item.stateName.toString())
                  //             .toList();
                  //         Navigator.pop(context);
                  //         setState(() {});
                  //       });
                  //     },
                  //     isExpanded: true,
                  //     displayClearIcon:
                  //         false, // Whether to display a clear icon
                  //     underline: Container(), // To remove underline
                  //     searchInputDecoration: InputDecoration(
                  //       hintText: "Search...",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),

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

                          value: !editcontry
                              ? country.countriesArray!.contains(userdetails
                                      .locationDetailsArray![0].country
                                      .toString())
                                  ? userdetails.locationDetailsArray![0].country
                                      .toString()
                                  : countrytype
                              : countrytype,

                          onChanged: (value) {
                            ref.watch(editablecountry.notifier).state = true;
                            showloader(context: context);
                            ref.watch(countryProvider.notifier).state =
                                value as String;
                            String id = findIdByName(
                                name: value.toString(),
                                list: country.countriesArray!,
                                type: "1");
                            getState(countryid: id.toString(), ref: ref)
                                .whenComplete(() {
                              Navigator.pop(context);
                              setState(() {});
                            });
                          },
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              //state dropdown
              !edit
                  ? defaultcontainer(
                      text:
                          userdetails.locationDetailsArray![0].state.toString())
                  :
                  // Container(
                  //     height: 70,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: const Color(0xff9A9A9A)),
                  //       borderRadius: BorderRadius.circular(8)),
                  //   child: SearchChoices.single(
                  //     items: statestringList
                  //         .map((item) => DropdownMenuItem(
                  //             value: item, child: Text(item)))
                  //         .toList(),
                  //     value: editstate
                  //         ? state.statesArray!.contains(userdetails
                  //                 .locationDetailsArray![0].state
                  //                 .toString())
                  //             ? userdetails.locationDetailsArray![0].state
                  //                 .toString()
                  //             : statetype
                  //         : statetype,
                  //     hint: "Select State",
                  //     searchHint: "Search for state",
                  //     onChanged: (newValue) {
                  //       ref.watch(editablestate.notifier).state = true;
                  //       showloader(context: context);
                  //       ref.watch(stateProvider.notifier).state =
                  //           newValue as String;
                  //       print('location${newValue.toString()}');
                  //       String id = findIdByName(
                  //           name: newValue.toString(),
                  //           list: state.statesArray!,
                  //           type: "2");
                  //       print('location$id');
                  //       getcity(stateid: id.toString(), ref: ref)
                  //           .whenComplete(() {
                  //         Navigator.pop(context);
                  //         setState(() {});
                  //       });
                  //     },
                  //     isExpanded: true,
                  //     displayClearIcon:
                  //         false, // Whether to display a clear icon
                  //     underline: Container(), // To remove underline
                  //     searchInputDecoration: InputDecoration(
                  //       hintText: "Search...",
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                          value: editstate
                              ? state.statesArray!.contains(userdetails
                                      .locationDetailsArray![0].state
                                      .toString())
                                  ? userdetails.locationDetailsArray![0].state
                                      .toString()
                                  : statetype
                              : statetype,
                          onChanged: (value) {
                            ref.watch(editablestate.notifier).state = true;
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
                              Navigator.pop(context);
                              setState(() {});
                            });
                          },
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              //city dropdown
              !edit
                  ? defaultcontainer(
                      text:
                          userdetails.locationDetailsArray![0].city.toString())
                  :
                  // Container(
                  //     height: 70,
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: const Color(0xff9A9A9A)),
                  //         borderRadius: BorderRadius.circular(8)),
                  //     child: SearchChoices.single(
                  //       items: citystringList
                  //           .map((item) => DropdownMenuItem(
                  //               value: item, child: Text(item)))
                  //           .toList(),
                  //       value: !editcity
                  //           ? city.citiesArray!.contains(userdetails
                  //                   .locationDetailsArray![0].city
                  //                   .toString())
                  //               ? userdetails.locationDetailsArray![0].city
                  //                   .toString()
                  //               : citytype
                  //           : citytype,
                  //       hint: "Select State",
                  //       searchHint: "Search for state",
                  //       onChanged: (newValue) {
                  //         ref.watch(cityProvider.notifier).state =
                  //             newValue as String;
                  //       },
                  //       isExpanded: true,
                  //       displayClearIcon:
                  //           false, // Whether to display a clear icon
                  //       underline: Container(), // To remove underline
                  //       searchInputDecoration: InputDecoration(
                  //         hintText: "Search...",
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(8.0),
                  //         ),
                  //       ),
                  //     ),
                  //   ),

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
                          value: !editcity
                              ? city.citiesArray!.contains(userdetails
                                      .locationDetailsArray![0].city
                                      .toString())
                                  ? userdetails.locationDetailsArray![0].city
                                      .toString()
                                  : citytype
                              : citytype,
                          onChanged: (value) {
                            ref.watch(cityProvider.notifier).state =
                                value as String;
                          },
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.locationDetailsArray![0].address
                          .toString())
                  : TextFormField(
                      controller: address,
                      maxLines: 3,
                      //border

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff9A9A9A)),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),

                        //label
                        floatingLabelStyle: TextStyle(
                            color: textcolor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        label: Text(
                          "Addresss ",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'Shiv nagar....',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              const SizedBox(height: 20),
              // TextFormField(
              //   //border
              //   keyboardType: TextInputType.number,
              //   // controller: phone,
              //   readOnly: true,
              //   enabled: false,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //         borderSide: const BorderSide(color: Color(0xff9A9A9A)),
              //         borderRadius: BorderRadius.circular(8)),
              //     focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(8)),

              //     //label
              //     floatingLabelStyle: TextStyle(
              //         color: textcolor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400),
              //     label: Text(
              //       userdetails.locationDetailsArray![0].phone.toString(),
              //       style: TextStyle(
              //         fontSize: 14,
              //         color: textcolor,
              //       ),
              //     ),
              //     //hint text
              //     hintText: phoneno,
              //     hintStyle: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //         color: lighttext),
              //     //suffix
              //   ),
              // ),
              const SizedBox(height: 20),
              //time to call time picker
              !edit
                  ? defaultcontainer(
                      text: userdetails.locationDetailsArray![0].timeToCall
                          .toString())
                  : InkWell(
                      onTap: () async {
                        timecall = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context, //context of current state
                        ).whenComplete(() {
                          setState(() {});
                        });
                      },
                      child: Container(
                        width: width,
                        height: 60,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: !edit
                            ? BoxDecoration(
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
                              )
                            : BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff9A9A9A)),
                                borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            children: [
                              Text(
                                timecall == null
                                    ? userdetails
                                        .locationDetailsArray![0].timeToCall
                                        .toString()
                                    : formatTimeOfDay(timecall!),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                CupertinoIcons.clock,
                                size: 20,
                                color: Color(0xff9A9A9A),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.locationDetailsArray![0].residence
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
                          value: !editresidance
                              ? residancelist.contains(userdetails
                                      .locationDetailsArray![0].residence
                                      .toString())
                                  ? userdetails
                                      .locationDetailsArray![0].residence
                                      .toString()
                                  : residancetype
                              : residancetype,
                          onChanged: (value) {
                            ref.watch(editableresidance.notifier).state = true;
                            setState(() {
                              residancetype = value as String;
                              ref.watch(nriProvider.notifier).state = value;
                            });
                          },
                        ),
                      ),
                    ),
              SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: edit
            ? ElevatedButton(
                onPressed: () => locationdetailsupdatefuncationbtn(),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: primary,
                    minimumSize: Size(width, 50)),
                child: const Text(
                  "Update",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ))
            : SizedBox.shrink());
  }

  locationdetailsupdatefuncationbtn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final countrytype = ref.watch(countryProvider);
    final userdetails = ref.watch(userdetailProvider);
    final statetype = ref.watch(stateProvider);
    final citytype = ref.watch(cityProvider);
    final nriornot = ref.watch(nriProvider);
    UpdateUser()
        .updatelocation(
            country: countrytype == ""
                ? userdetails.locationDetailsArray![0].country.toString()
                : countrytype,
            state: statetype == ""
                ? userdetails.locationDetailsArray![0].state.toString()
                : statetype,
            city: citytype == ""
                ? userdetails.locationDetailsArray![0].city.toString()
                : citytype,
            address: address.text == ""
                ? userdetails.locationDetailsArray![0].address.toString()
                : address.text,
            timetocall: timecall == 'null'
                ? userdetails.locationDetailsArray![0].timeToCall.toString()
                : timecall.toString(),
            residence: nriornot == ""
                ? userdetails.locationDetailsArray![0].residence.toString()
                : nriornot,
            mobile: userdetails.basicDetailsArray![0].phoneno.toString())
        .whenComplete(() {
      ref.watch(editablelocation.notifier).state = false;
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
        address.clear();
      });
    });
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
