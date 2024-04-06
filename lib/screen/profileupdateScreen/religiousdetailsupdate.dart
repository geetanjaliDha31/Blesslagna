import 'dart:developer';
import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateuserdata/updateuser.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReligiousDetailUpdate extends ConsumerStatefulWidget {
  const ReligiousDetailUpdate({super.key});

  @override
  ConsumerState<ReligiousDetailUpdate> createState() =>
      _ReligiousDetailUpdateState();
}

class _ReligiousDetailUpdateState extends ConsumerState<ReligiousDetailUpdate> {
  String? selectedValue;

  List<String> caststringList = [];
  final List mangliklist = ["Are You Manglik", "Yes", "No"];
  String? mangliktype = "Are You Manglik";
  StateProvider editablereligious = StateProvider((ref) => false);
  StateProvider editablereligion = StateProvider((ref) => false);
  StateProvider editablecast = StateProvider((ref) => false);
  StateProvider editablemanglik = StateProvider((ref) => false);
  TextEditingController subcast2 = TextEditingController();
  TextEditingController horoscope = TextEditingController();
  TextEditingController star = TextEditingController();
  TextEditingController gotra = TextEditingController();
  TextEditingController namereligious = TextEditingController();
  TextEditingController moonsign = TextEditingController();

  @override
  void initState() {
    final userdetails = ref.read(userdetailProvider);
    subcast2.text = userdetails.religiousArray![0].subcaste.toString();
    horoscope.text = userdetails.religiousArray![0].horoscope.toString();
    star.text = userdetails.religiousArray![0].star.toString();
    gotra.text = userdetails.religiousArray![0].gotra.toString();
    namereligious.text = userdetails.religiousArray![0].religion.toString();
    moonsign.text = userdetails.religiousArray![0].moonsign.toString();
    caststringList = castitems.map((item) => item.toString()).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final edit = ref.watch(editablereligious);
    final editreligion = ref.watch(editablereligion);
    final editcast = ref.watch(editablecast);
    final editmanglik = ref.watch(editablemanglik);
    double width = MediaQuery.of(context).size.width;
    final userdetails = ref.watch(userdetailProvider);
    final religontype = ref.watch(religionProvider);
    final casttype = ref.watch(castProvider);

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref.watch(editablereligious.notifier).state = !edit;
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
                      text: userdetails.religiousArray![0].religion.toString(),
                    )
                  : Container(
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff9A9A9A)),
                          borderRadius: BorderRadius.circular(8)),
                      child: SearchChoices.single(
                        items: religioitems
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        value: !editreligion
                            ? religioitems.contains(userdetails
                                    .religiousArray![0].religion
                                    .toString())
                                ? userdetails.religiousArray![0].religion
                                    .toString()
                                : religontype
                            : religontype,
                        hint: "Select Height",
                        searchHint: "Search for Height",
                        onChanged: (newValue) {
                          ref.watch(editablereligion.notifier).state = true;
                          ref.watch(religionProvider.notifier).state = newValue;
                        },
                        isExpanded: true,
                        displayClearIcon:
                            false, // Whether to display a clear icon
                        underline: Container(), // To remove underline
                        searchInputDecoration: InputDecoration(
                          hintText: "Search...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
              // DropdownButtonHideUnderline(
              //   child: Container(
              //     margin: EdgeInsets.symmetric(horizontal: 2),
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
              //       items: religioitems
              //           .map((item) => DropdownMenuItem(
              //                 value: item,
              //                 child: Text(
              //                   item,
              //                   style: const TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w400,
              //                   ),
              //                 ),
              //               ))
              //           .toList(),
              //       value: !editreligion
              //           ? religioitems.contains(userdetails
              //                   .religiousArray![0].religion
              //                   .toString())
              //               ? userdetails.religiousArray![0].religion.toString()
              //               : religontype
              //           : religontype,
              //       onChanged: (value) {
              //         ref.watch(editablereligion.notifier).state = true;
              //         ref.watch(religionProvider.notifier).state = value;
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),
              !edit
                  ? Row(
                      children: [
                        defaultcontainerwidth(
                            text: userdetails.religiousArray![0].caste
                                .toString()),
                        SizedBox(
                          width: 16,
                        ),
                        defaultcontainerwidth(
                            text: userdetails.religiousArray![0].subcaste
                                .toString())
                      ],
                    )
                  : Row(
                      children: [
                        // cast dropdown with condition
                        !edit
                            ? defaultcontainer(
                                text: userdetails.religiousArray![0].religion
                                    .toString(),
                              )
                            : Container(
                                height: 70,
                                width: width / 2.4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff9A9A9A)),
                                    borderRadius: BorderRadius.circular(8)),
                                child: SearchChoices.single(
                                  items: caststringList
                                      .map((item) => DropdownMenuItem(
                                          value: item, child: Text(item)))
                                      .toList(),
                                  value: !editcast
                                      ? castitems.contains(userdetails
                                              .religiousArray![0].subcaste
                                              .toString())
                                          ? userdetails
                                              .religiousArray![0].subcaste
                                              .toString()
                                          : casttype
                                      : casttype,
                                  hint: "Select Cast",
                                  searchHint: "Search for cast",
                                  onChanged: (newValue) {
                                    ref.watch(editablecast.notifier).state =
                                        true;
                                    setState(() {
                                      log(newValue as String);
                                      ref.watch(castProvider.notifier).state =
                                          newValue;
                                    });
                                  },
                                  isExpanded: true,
                                  displayClearIcon:
                                      false, // Whether to display a clear icon
                                  underline: Container(), // To remove underline
                                  searchInputDecoration: InputDecoration(
                                    hintText: "Search...",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                        // DropdownButtonHideUnderline(
                        //   child: Container(
                        //     margin: EdgeInsets.symmetric(horizontal: 2),
                        //     width: width / 2.4,
                        //     height: 60,
                        //     decoration: BoxDecoration(
                        //         border:
                        //             Border.all(color: const Color(0xff9A9A9A)),
                        //         borderRadius: BorderRadius.circular(8)),
                        //     child: DropdownButton2(
                        //       // buttonDecoration: shadowdecoration,
                        //       isExpanded: true,
                        //       buttonStyleData: const ButtonStyleData(
                        //         padding: EdgeInsets.symmetric(horizontal: 16),
                        //         height: 40,
                        //         width: 140,
                        //       ),
                        //       items: castitems
                        //           .map((item) => DropdownMenuItem(
                        //                 value: item,
                        //                 child: Text(
                        //                   item,
                        //                   style: const TextStyle(
                        //                     color: Colors.black,
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.w400,
                        //                   ),
                        //                 ),
                        //               ))
                        //           .toList(),
                        //       value: !editcast
                        //           ? castitems.contains(userdetails
                        //                   .religiousArray![0].subcaste
                        //                   .toString())
                        //               ? userdetails.religiousArray![0].subcaste
                        //                   .toString()
                        //               : casttype
                        //           : casttype,
                        //       onChanged: (value) {
                        //         ref.watch(editablecast.notifier).state = true;
                        //         setState(() {
                        //           log(value as String);
                        //           ref.watch(castProvider.notifier).state =
                        //               value;
                        //         });
                        //       },
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(width: 16),
                        //sub cast textfield
                        SizedBox(
                          width: width / 2.4,
                          child: TextFormField(
                            //border
                            keyboardType: TextInputType.text,
                            controller: subcast2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff9A9A9A)),
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),

                              //label
                              floatingLabelStyle: TextStyle(
                                  color: textcolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              label: Text(
                                "Sub Cast",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textcolor,
                                ),
                              ),
                              //hint text
                              hintText: "Sub Cast",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              //suffix
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.religiousArray![0].horoscope.toString())
                  : TextFormField(
                      controller: horoscope,
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
                          "HoroScope ",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: "HoroScope",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              SizedBox(height: 20),
              !edit
                  ? Row(
                      children: [
                        defaultcontainerwidth(
                            text:
                                userdetails.religiousArray![0].star.toString()),
                        SizedBox(
                          width: 16,
                        ),
                        defaultcontainerwidth(
                            text:
                                userdetails.religiousArray![0].gotra.toString())
                      ],
                    )
                  : Row(
                      children: [
                        // star textfield
                        SizedBox(
                            width: width / 2.4,
                            child: TextFormField(
                              controller: star,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff9A9A9A)),
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),

                                //label
                                floatingLabelStyle: TextStyle(
                                    color: textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                label: Text(
                                  "Star ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textcolor,
                                  ),
                                ),
                                //hint text
                                hintText: "Star",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: lighttext),
                                //suffix
                              ),
                            )),
                        const SizedBox(width: 16),
                        // gotra textfield
                        SizedBox(
                            width: width / 2.4,
                            child: TextFormField(
                              controller: gotra,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff9A9A9A)),
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),

                                //label
                                floatingLabelStyle: TextStyle(
                                    color: textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                label: Text(
                                  "Gotra ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textcolor,
                                  ),
                                ),
                                //hint text
                                hintText: "Gotra",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: lighttext),
                                //suffix
                              ),
                            )),
                      ],
                    ),
              SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.religiousArray![0].manglik.toString(),
                    )
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
                          items: mangliklist
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
                          value: !editmanglik
                              ? mangliklist.contains(userdetails
                                      .religiousArray![0].manglik
                                      .toString())
                                  ? userdetails.religiousArray![0].manglik
                                      .toString()
                                  : mangliktype
                              : mangliktype,
                          onChanged: (value) {
                            ref.watch(editablemanglik.notifier).state = true;
                            setState(() {
                              mangliktype = value as String;
                              ref.watch(manglikProvider.notifier).state = value;
                            });
                          },
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.religiousArray![0].moonsign.toString(),
                    )
                  : TextFormField(
                      controller: moonsign,
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
                          "Moonsign ",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: "Moonsign",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: edit
            ? ElevatedButton(
                onPressed: () => religiondetailsupdatefuncationbtn(),
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

  religiondetailsupdatefuncationbtn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final casttype = ref.watch(castProvider);
    final userdetails = ref.watch(userdetailProvider);
    final religontype = ref.watch(religionProvider);

    UpdateUser()
        .updatereligion(
            religion: religontype.toString() == "Select Religon"
                ? userdetails.religiousArray![0].religion.toString()
                : religontype.toString(),
            cast: casttype == "Select Cast"
                ? userdetails.religiousArray![0].caste.toString()
                : casttype,
            subcast: subcast2.text == ""
                ? userdetails.religiousArray![0].subcaste.toString()
                : subcast2.text,
            horoscope: horoscope.text == ""
                ? userdetails.religiousArray![0].horoscope.toString()
                : horoscope.text,
            star: star.text == ""
                ? userdetails.religiousArray![0].star.toString()
                : star.text,
            gotra: gotra.text == ""
                ? userdetails.religiousArray![0].gotra.toString()
                : gotra.text,
            manglik: mangliktype.toString(),
            moonsign: moonsign.text == ""
                ? userdetails.religiousArray![0].moonsign.toString()
                : moonsign.text)
        .whenComplete(() async {
      ref.watch(editablereligious.notifier).state = false;
      // subcast2.clear();
      // horoscope.clear();
      // star.clear();
      // gotra.clear();
      // moonsign.clear();
      await getuserprofile(id: userid.toString(), ref: ref);
      setState(() {});
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

  defaultcontainerwidth({required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: MediaQuery.of(context).size.width / 2.4,
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
