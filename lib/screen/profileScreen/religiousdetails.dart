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

class Religiousdetails extends ConsumerStatefulWidget {
  final String comefrom;
  const Religiousdetails({super.key, required this.comefrom});

  @override
  ConsumerState<Religiousdetails> createState() => _ReligiousdetailsState();
}

TextEditingController subcast2 = TextEditingController();
TextEditingController horoscope = TextEditingController();
TextEditingController star = TextEditingController();
TextEditingController gotra = TextEditingController();
TextEditingController namereligious = TextEditingController();
TextEditingController moonsign = TextEditingController();
// TextEditingController manglik = TextEditingController();
// TextEditingController cast2 = TextEditingController();

class _ReligiousdetailsState extends ConsumerState<Religiousdetails> {
  // final List religons = ["Select Religon", "Hindu", "Muslim", "Bhudhha"];

  final List mangliklist = ["Are You Manglik", "Yes", "No"];
  String? mangliktype = "Are You Manglik";
  StateProvider editablereligion = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context) {
    // final religontype2 = ref.watch(religionProvider);
    final userdetails = ref.watch(userdetailProvider);
    final casttype = ref.watch(castProvider);
    final edit = ref.watch(editablereligion);
    final religontype = ref.watch(religionProvider);

    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.comefrom == ''
              ? GestureDetector(
                  onTap: () {
                    ref.watch(editablereligion.notifier).state = !edit;
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: edit
                            ? SvgPicture.asset('assets/cross.svg')
                            : SvgPicture.asset('assets/edit.svg')),
                  ),
                )
              : SizedBox.shrink(),
          widget.comefrom == ''
              ? const SizedBox.shrink()
              : RichText(
                  text: TextSpan(
                    text: 'Religious ',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xD9131313)),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Information',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: primary)),
                    ],
                  ),
                ),
          const SizedBox(height: 24),
          //religion dropdown with condition
          !edit && widget.comefrom == ''
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
                        .map((item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    value: religontype,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
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
          //       value: religontype,
          //       onChanged: (value) {
          //         ref.watch(religionProvider.notifier).state = value;
          //       },
          //     ),
          //   ),
          // ),
          const SizedBox(height: 24),
          Row(
            children: [
              //cast dropdown with condition
              !edit && widget.comefrom == ''
                  ? defaultcontainer(
                      text: userdetails.religiousArray![0].caste.toString(),
                    )
                  : Container(
                      height: 70,
                      width: width / 2.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff9A9A9A)),
                          borderRadius: BorderRadius.circular(8)),
                      child: SearchChoices.single(
                        items: castitems
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        value: casttype,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        hint: "Select Cast",
                        searchHint: "Search for Cast",
                        onChanged: (newValue) {
                          setState(() {
                            log(newValue as String);
                            ref.watch(castProvider.notifier).state = newValue;
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
              //       value: casttype,
              //       onChanged: (value) {
              //         setState(() {
              //           log(value as String);
              //           ref.watch(castProvider.notifier).state = value;
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
                    enabled: widget.comefrom == ""
                        ? edit
                            ? true
                            : false
                        : true,
                    readOnly: widget.comefrom == ""
                        ? edit
                            ? false
                            : true
                        : false,
                    controller: subcast2,
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
                        widget.comefrom == ''
                            ? userdetails.religiousArray![0].subcaste.toString()
                            : "Subcast ",
                        style: TextStyle(
                          fontSize: 14,
                          color: textcolor,
                        ),
                      ),
                      //hint text
                      hintText: "Sub-Cast",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: lighttext),
                      //suffix
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 24),
          //horoscope textfield
          TextFormField(
            controller: horoscope,
            enabled: widget.comefrom == ""
                ? edit
                    ? true
                    : false
                : true,
            readOnly: widget.comefrom == ""
                ? edit
                    ? false
                    : true
                : false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

              //label
              floatingLabelStyle: TextStyle(
                  color: textcolor, fontSize: 14, fontWeight: FontWeight.w400),
              label: Text(
                widget.comefrom == ''
                    ? userdetails.religiousArray![0].horoscope.toString()
                    : "HoroScope ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: "HoroScope",
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              // star textfield
              SizedBox(
                  width: width / 2.4,
                  child: TextFormField(
                    enabled: widget.comefrom == ""
                        ? edit
                            ? true
                            : false
                        : true,
                    readOnly: widget.comefrom == ""
                        ? edit
                            ? false
                            : true
                        : false,
                    controller: star,
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
                        widget.comefrom == ''
                            ? userdetails.religiousArray![0].star.toString()
                            : "Star ",
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
                    enabled: widget.comefrom == ""
                        ? edit
                            ? true
                            : false
                        : true,
                    readOnly: widget.comefrom == ""
                        ? edit
                            ? false
                            : true
                        : false,
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
                        widget.comefrom == ''
                            ? userdetails.religiousArray![0].gotra.toString()
                            : "Gotra ",
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
          const SizedBox(height: 24),
          // manglik dropdown
          !edit && widget.comefrom == ''
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
                      value: mangliktype,
                      onChanged: (value) {
                        setState(() {
                          mangliktype = value as String;
                          ref.watch(manglikProvider.notifier).state = value;
                        });
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          //moonsign textfield
          TextFormField(
            controller: moonsign,
            enabled: widget.comefrom == ""
                ? edit
                    ? true
                    : false
                : true,
            readOnly: widget.comefrom == ""
                ? edit
                    ? false
                    : true
                : false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

              //label
              floatingLabelStyle: TextStyle(
                  color: textcolor, fontSize: 14, fontWeight: FontWeight.w400),
              label: Text(
                widget.comefrom == ''
                    ? userdetails.religiousArray![0].moonsign.toString()
                    : "Moonsign ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: "Moonsign",
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          widget.comefrom == '' && edit
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
              : const SizedBox.shrink()
        ],
      ),
    );
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
        .whenComplete(() {
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
        subcast2.clear();
        horoscope.clear();
        star.clear();
        gotra.clear();
        moonsign.clear();
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
