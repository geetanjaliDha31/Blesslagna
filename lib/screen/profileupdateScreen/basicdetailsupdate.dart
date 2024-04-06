import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateuserdata/updateuser.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/timefunction.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicDetailsUpdate extends ConsumerStatefulWidget {
  const BasicDetailsUpdate({super.key});

  @override
  ConsumerState<BasicDetailsUpdate> createState() => _BasicDetailsUpdateState();
}

class _BasicDetailsUpdateState extends ConsumerState<BasicDetailsUpdate> {
  StateProvider editableheight = StateProvider((ref) => false);
  StateProvider editablegender = StateProvider((ref) => false);
  StateProvider editablemothert = StateProvider((ref) => false);
  StateProvider editablemaritalstatus = StateProvider((ref) => false);
  StateProvider editablefbasic = StateProvider((ref) => false);
  TextEditingController usernametext = TextEditingController();
  TextEditingController mobiletext = TextEditingController();
  TextEditingController hobbiestext = TextEditingController();
  TextEditingController weighttext = TextEditingController();
  TextEditingController brithplacetext = TextEditingController();
  TextEditingController languagekhowntext = TextEditingController();
  final List category = ["Select Gender", "Male", "Female", "TransGender"];
  String categorytype = "Select Gender";

  TimeOfDay? timebrith;
  final List mariedstatus = [
    "Marital Status",
    "Never Married",
    "Divorced",
    "Window",
  ];

  @override
  void initState() {
    final userdetails = ref.read(userdetailProvider);
    usernametext.text = userdetails.basicDetailsArray![0].name.toString();
    hobbiestext.text = userdetails.basicDetailsArray![0].hobbies.toString();
    weighttext.text = userdetails.basicDetailsArray![0].weight.toString();
    brithplacetext.text =
        userdetails.basicDetailsArray![0].birthplace.toString();
    languagekhowntext.text =
        userdetails.basicDetailsArray![0].language.toString();
    mobiletext.text = userdetails.basicDetailsArray![0].phoneno.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userdetails = ref.watch(userdetailProvider);
    final edit = ref.watch(editablefbasic);
    final width = MediaQuery.of(context).size.width;
    final height = ref.watch(heighProvider);
    final prefielddate = ref.read(selectdateProvider);
    final pickdate = ref.watch(selectdateProvider);
    final mothertounge = ref.watch(mothertoungeProvider);
    final mariedtypeuser = ref.watch(martitalstatusProvider);
    final editheight = ref.watch(editableheight);
    final editmother = ref.watch(editablemothert);
    final editmarital = ref.watch(editablemaritalstatus);
    final editgender = ref.watch(editablegender);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ref.watch(editablefbasic.notifier).state = !edit;
                setState(() {});
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                    text:
                        userdetails.basicDetailsArray![0].name.toString() == ""
                            ? "Name"
                            : userdetails.basicDetailsArray![0].name.toString())
                : TextFormField(
                    //border

                    keyboardType: TextInputType.text,
                    controller: usernametext,

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
                        "Name",
                        style: TextStyle(
                          fontSize: 14,
                          color: textcolor,
                        ),
                      ),
                      //hint text
                      hintText: "Name",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      //suffix
                    ),
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.basicDetailsArray![0].phoneno
                                .toString() ==
                            ""
                        ? "Mobile No."
                        : userdetails.basicDetailsArray![0].phoneno.toString())
                : TextFormField(
                    //border

                    keyboardType: TextInputType.text,
                    controller: mobiletext,

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
                        "Mobile No.",
                        style: TextStyle(
                          fontSize: 14,
                          color: textcolor,
                        ),
                      ),
                      //hint text
                      hintText: "Mobile No.",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      //suffix
                    ),
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.basicDetailsArray![0].hobbies
                                .toString() ==
                            ""
                        ? "Hobbies"
                        : userdetails.basicDetailsArray![0].hobbies.toString())
                : TextFormField(
                    //border
                    keyboardType: TextInputType.text,
                    controller: hobbiestext,
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
                        "Hobbies",
                        style: TextStyle(
                          fontSize: 14,
                          color: textcolor,
                        ),
                      ),
                      //hint text
                      hintText: "Hobbies",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      //suffix
                    ),
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.basicDetailsArray![0].gender.toString() ==
                            ""
                        ? "Select Gender"
                        : userdetails.basicDetailsArray![0].gender.toString())
                : Container(
                    height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff9A9A9A)),
                        borderRadius: BorderRadius.circular(8)),
                    child: SearchChoices.single(
                      items: category
                          .map((item) =>
                              DropdownMenuItem(value: item, child: Text(item)))
                          .toList(),
                      value: !editgender
                          ? category.contains(userdetails
                                  .basicDetailsArray![0].gender
                                  .toString())
                              ? userdetails.basicDetailsArray![0].gender
                                  .toString()
                              : categorytype
                          : categorytype,
                      hint: "Select Gender",
                      searchHint: "Search for Gender",
                      onChanged: (newValue) {
                        ref.watch(editablegender.notifier).state = true;
                        setState(() {
                          categorytype = newValue as String;
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
            //     margin: EdgeInsets.only(left: 2),
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
            //       items: category
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
            //       value: !editgender
            //           ? category.contains(userdetails
            //                   .basicDetailsArray![0].gender
            //                   .toString())
            //               ? userdetails.basicDetailsArray![0].gender.toString()
            //               : categorytype
            //           : categorytype,

            //       onChanged: (value) {
            //         ref.watch(editablegender.notifier).state = true;
            //         setState(() {
            //           categorytype = value as String;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            !edit
                ? Row(
                    children: [
                      defaultcontainerwidth(
                        text: userdetails.basicDetailsArray![0].height
                                    .toString() ==
                                ""
                            ? "Height"
                            : userdetails.basicDetailsArray![0].height
                                .toString(),
                      ),
                      const SizedBox(width: 14),
                      defaultcontainerwidth(
                        text: userdetails.basicDetailsArray![0].weight
                                    .toString() ==
                                ""
                            ? "Weight"
                            : userdetails.basicDetailsArray![0].weight
                                .toString(),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      //height dropdown with condition
                      Container(
                        height: 70,
                        width: width / 2.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9A9A9A)),
                            borderRadius: BorderRadius.circular(8)),
                        child: SearchChoices.single(
                          items: heightitems
                              .map((item) => DropdownMenuItem(
                                  value: item, child: Text(item)))
                              .toList(),
                          value: !editheight
                              ? heightitems.contains(userdetails
                                      .basicDetailsArray![0].height
                                      .toString())
                                  ? userdetails.basicDetailsArray![0].height
                                      .toString()
                                  : height
                              : height,
                          hint: "Select Height",
                          searchHint: "Search for Height",
                          onChanged: (newValue) {
                            ref.watch(editablegender.notifier).state = true;
                            setState(() {
                              categorytype = newValue as String;
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
                      //     margin: EdgeInsets.only(left: 2),
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
                      //       items: heightitems
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
                      //       value: !editheight
                      //           ? heightitems.contains(userdetails
                      //                   .basicDetailsArray![0].height
                      //                   .toString())
                      //               ? userdetails.basicDetailsArray![0].height
                      //                   .toString()
                      //               : height
                      //           : height,

                      //       onChanged: (value) {
                      //         ref.watch(editableheight.notifier).state = true;
                      //         ref.watch(heighProvider.notifier).state =
                      //             value as String;
                      //       },
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(width: 16),
                      //weight textfield
                      SizedBox(
                        width: width / 2.4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: weighttext,
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
                              "Weight ",
                              style: TextStyle(
                                fontSize: 14,
                                color: textcolor,
                              ),
                            ),
                            //hint text
                            hintText: "Weight",
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
                    text: userdetails.basicDetailsArray![0].birthplace
                                .toString() ==
                            ""
                        ? "Brith Place"
                        : userdetails.basicDetailsArray![0].birthplace
                            .toString())
                : TextFormField(
                    //border
                    keyboardType: TextInputType.text,
                    controller: brithplacetext,
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
                        "Birth Place",
                        style: TextStyle(
                          fontSize: 14,
                          color: textcolor,
                        ),
                      ),
                      //hint text
                      hintText: "Brith Place",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      //suffix
                    ),
                  ),
            SizedBox(height: 20),
            !edit
                ? Row(
                    children: [
                      defaultcontainerwidth(
                        text: userdetails.basicDetailsArray![0].age
                                    .toString() ==
                                ""
                            ? "Age"
                            : userdetails.basicDetailsArray![0].age.toString(),
                      ),
                      const SizedBox(width: 16),
                      defaultcontainerwidth(
                          text: userdetails.basicDetailsArray![0].birthtime
                                      .toString() ==
                                  ""
                              ? "Brith Time"
                              : userdetails.basicDetailsArray![0].birthtime
                                  .toString()),
                    ],
                  )
                : Row(
                    children: [
                      //brithdate datepicker with condition
                      Container(
                        width: width / 2.4,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9A9A9A)),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            children: [
                              Text(
                                prefielddate != ""
                                    ? prefielddate
                                    : pickdate == ""
                                        ? userdetails.basicDetailsArray![0].dob
                                            .toString()
                                        : pickdate,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () async {
                                  await _selectDate(
                                          context,
                                          ref,
                                          userdetails.basicDetailsArray![0].dob
                                              .toString())
                                      .whenComplete(() {
                                    setState(() {});
                                  });
                                },
                                child: const Icon(
                                  Icons.calendar_month,
                                  color: Color(0xff9A9A9A),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      //selecttime timepicker with condition
                      InkWell(
                        onTap: () async {
                          if (edit) {
                            timebrith = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context, //context of current state
                            ).whenComplete(() {
                              setState(() {});
                            });
                          }
                        },
                        child: Container(
                          width: width / 2.4,
                          height: 60,
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
                                  border: Border.all(
                                      color: const Color(0xff9A9A9A)),
                                  borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              children: [
                                Text(
                                  timebrith == null
                                      ? userdetails
                                          .basicDetailsArray![0].birthtime
                                          .toString()
                                      : formatTimeOfDay(timebrith!),

                                  // timebrith.toString(),
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
                    ],
                  ),
            SizedBox(height: 20),
            !edit
                ? Row(
                    children: [
                      defaultcontainerwidth(
                          text: userdetails.basicDetailsArray![0].motherTongue
                                      .toString() ==
                                  ""
                              ? "Mother Tongue"
                              : userdetails.basicDetailsArray![0].motherTongue
                                  .toString()),
                      SizedBox(
                        width: 16,
                      ),
                      defaultcontainerwidth(
                          text: userdetails.basicDetailsArray![0].language
                                      .toString() ==
                                  ""
                              ? "Language"
                              : userdetails.basicDetailsArray![0].language
                                  .toString())
                    ],
                  )
                : Row(
                    children: [
                      //mothertounge dropdown with condition

                      Container(
                        height: 70,
                        width: width / 2.4,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9A9A9A)),
                            borderRadius: BorderRadius.circular(8)),
                        child: SearchChoices.single(
                          items: mothertoungeitems
                              .map((item) => DropdownMenuItem(
                                  value: item, child: Text(item)))
                              .toList(),
                          value: !editmother
                              ? mothertoungeitems.contains(userdetails
                                      .basicDetailsArray![0].language
                                      .toString())
                                  ? userdetails.basicDetailsArray![0].language
                                      .toString()
                                  : mothertounge
                              : mothertounge,
                          hint: "Mother Tongue",

                          searchHint: "Search for Mother Tongue",
                          onChanged: (newValue) {
                            ref.watch(mothertoungeProvider.notifier).state =
                                newValue as String;
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
                      //     margin: EdgeInsets.only(left: 2),
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
                      //       items: mothertoungeitems
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
                      //       value: !editmother
                      //           ? mothertoungeitems.contains(userdetails
                      //                   .basicDetailsArray![0].language
                      //                   .toString())
                      //               ? userdetails.basicDetailsArray![0].language
                      //                   .toString()
                      //               : mothertounge
                      //           : mothertounge,
                      //       onChanged: (value) {
                      //         ref.watch(mothertoungeProvider.notifier).state =
                      //             value as String;
                      //       },
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(width: 16),
                      //language known textfield
                      SizedBox(
                        width: width / 2.5,
                        child: TextFormField(
                          //border

                          keyboardType: TextInputType.text,
                          controller: languagekhowntext,
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
                              "Languages Known ",
                              style: TextStyle(
                                fontSize: 14,
                                color: textcolor,
                              ),
                            ),
                            //hint text
                            hintText: "Languages Known",
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
            //married status with condition
            !edit
                ? defaultcontainer(
                    text: userdetails.basicDetailsArray![0].maritalStatus
                                .toString() ==
                            ""
                        ? "Marital Status"
                        : userdetails.basicDetailsArray![0].maritalStatus
                            .toString(),
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
                        items: mariedstatus
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
                        value: !editmarital
                            ? mariedstatus.contains(userdetails
                                    .basicDetailsArray![0].maritalStatus
                                    .toString())
                                ? userdetails
                                    .basicDetailsArray![0].maritalStatus
                                    .toString()
                                : mariedtypeuser
                            : mariedtypeuser,
                        onChanged: (value) {
                          ref.watch(editablemaritalstatus.notifier).state =
                              true;
                          ref.watch(martitalstatusProvider.notifier).state =
                              value as String;
                        },
                      ),
                    ),
                  ),
            SizedBox(height: 20)
          ],
        ),
      ),
      bottomNavigationBar: edit
          ? ElevatedButton(
              onPressed: () => basicdetailsupdatefuncationbtn(),
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
          : const SizedBox.shrink(),
    );
  }

  basicdetailsupdatefuncationbtn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final userdetails = ref.watch(userdetailProvider);
    final height = ref.watch(heighProvider);
    final mothertounge = ref.watch(mothertoungeProvider);
    final mariedtypeuser = ref.watch(martitalstatusProvider);
    UpdateUser()
        .updatebasicdata(
            username: usernametext.text == ""
                ? userdetails.basicDetailsArray![0].name.toString()
                : usernametext.text,
            height: height == ""
                ? userdetails.basicDetailsArray![0].height.toString()
                : height,
            dobuser: ref.read(selectdateProvider).toString() == ""
                ? userdetails.basicDetailsArray![0].age.toString()
                : ref.read(selectdateProvider).toString(),
            marriedstatus: mariedtypeuser == ""
                ? userdetails.basicDetailsArray![0].maritalStatus.toString()
                : mariedtypeuser,
            mothertounge: mothertounge == ""
                ? userdetails.basicDetailsArray![0].motherTongue.toString()
                : mothertounge,
            languagekonwn: languagekhowntext.text == ""
                ? userdetails.basicDetailsArray![0].language.toString()
                : languagekhowntext.text,
            userphoneno: mobiletext.text == ""
                ? userdetails.basicDetailsArray![0].phoneno.toString()
                : mobiletext.text,
            gender: categorytype == "Select Gender"
                ? userdetails.basicDetailsArray![0].gender.toString()
                : categorytype.toString())
        .whenComplete(() async {
      // usernametext.clear();
      // hobbiestext.clear();
      // brithplacetext.clear();
      // languagekhowntext.clear();
      await getuserprofile(id: userid.toString(), ref: ref);
      ref.watch(editablefbasic.notifier).state = false;
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

  DateTime selectedDate = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  bool is18Plus(DateTime date) {
    final now = DateTime.now();
    final age = now.year - date.year;
    if (now.month < date.month ||
        (now.month == date.month && now.day < date.day)) {}
    return age >= 18;
  }

  Future<void> _selectDate(BuildContext context, WidgetRef ref,
      String initialDateFromBackend) async {
    DateTime initialDateback = DateTime.parse(initialDateFromBackend);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDateback,
        firstDate: DateTime(1920),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      if (is18Plus(picked)) {
        setState(() {
          selectedDate = picked;
          ref.watch(selectdateProvider.notifier).state =
              formatter.format(picked);
        });
      } else {
        setState(() {
          selectedDate = picked;
          ref.watch(selectdateProvider.notifier).state =
              formatter.format(picked);
        });

        toast("You Are Not !8+");
      }
    }
  }
}
