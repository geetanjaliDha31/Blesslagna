import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateuserdata/updateuser.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:blesslagna/screen/profileScreen/educationdetails.dart';
import 'package:blesslagna/screen/widget/multiselecte.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationDetailsUpdate extends ConsumerStatefulWidget {
  const EducationDetailsUpdate({super.key});

  @override
  ConsumerState<EducationDetailsUpdate> createState() =>
      _EducationDetailsUpdateState();
}

class _EducationDetailsUpdateState
    extends ConsumerState<EducationDetailsUpdate> {
  TextEditingController occupation = TextEditingController();
  TextEditingController employee = TextEditingController();
  TextEditingController designation = TextEditingController();
  StateProvider editablefeduction = StateProvider((ref) => false);
  StateProvider editableincome = StateProvider((ref) => false);

  @override
  void initState() {
    final userdetails = ref.read(userdetailProvider);
    occupation.text = userdetails.eduOccupationArray![0].occupation.toString();
    employee.text = userdetails.eduOccupationArray![0].employeeIn.toString();
    designation.text =
        userdetails.eduOccupationArray![0].designation.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    final userdetails = ref.watch(userdetailProvider);
    final edit = ref.watch(editablefeduction);
    final education = ref.watch(educationProvider);
    final editincome = ref.watch(editableincome);

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref.watch(editablefeduction.notifier).state = !edit;
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
                      text: userdetails.eduOccupationArray![0].education
                          .toString(),
                    )
                  : InkWell(
                      onTap: _showMultiSelect,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 18),
                          child: Text(
                            education == ""
                                ? userdetails.eduOccupationArray![0].education
                                            .toString() ==
                                        ""
                                    ? "Select Education"
                                    : userdetails
                                        .eduOccupationArray![0].education
                                        .toString()
                                : education,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.eduOccupationArray![0].occupation
                                  .toString() ==
                              ""
                          ? "Occupation"
                          : userdetails.eduOccupationArray![0].occupation
                              .toString(),
                    )
                  : TextFormField(
                      //border
                      controller: occupation,
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
                          "Occupation ",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'Occupation',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.eduOccupationArray![0].employeeIn
                                  .toString() ==
                              ""
                          ? "Employee In"
                          : userdetails.eduOccupationArray![0].employeeIn
                              .toString(),
                    )
                  : TextFormField(
                      //border

                      controller: employee,
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
                          "Employee in ",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'Employee in',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              const SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.eduOccupationArray![0].designation
                                  .toString() ==
                              ""
                          ? "Designation"
                          : userdetails.eduOccupationArray![0].designation
                              .toString(),
                    )
                  : TextFormField(
                      //border
                      controller: designation,
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
                          "Designation ",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'Designation',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              SizedBox(height: 20),
              !edit
                  ? defaultcontainer(
                      text: userdetails.eduOccupationArray![0].annualIncome
                                  .toString() ==
                              ""
                          ? "Annual Income"
                          : userdetails.eduOccupationArray![0].annualIncome
                              .toString(),
                    )
                  : Container(
                      height: 70,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff9A9A9A)),
                          borderRadius: BorderRadius.circular(8)),
                      child: SearchChoices.single(
                        items: incomeitems
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        value: !editincome
                            ? incomeitems.contains(userdetails
                                    .eduOccupationArray![0].annualIncome
                                    .toString())
                                ? userdetails
                                    .eduOccupationArray![0].annualIncome
                                    .toString()
                                : incometype
                            : incometype,
                        hint: "Select Gender",
                        searchHint: "Search for Gender",
                        onChanged: (newValue) {
                          ref.watch(editableincome.notifier).state = true;
                          setState(() {
                            incometype = newValue as String;
                            ref.watch(incomeProvider.notifier).state = newValue;
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
              //     height: 60,
              //     width: width,
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
              //       items: incomeitems
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
              //       value: !editincome
              //           ? incomeitems.contains(userdetails
              //                   .eduOccupationArray![0].annualIncome
              //                   .toString())
              //               ? userdetails.eduOccupationArray![0].annualIncome
              //                   .toString()
              //               : incometype
              //           : incometype,
              //       onChanged: (value) {
              //         ref.watch(editableincome.notifier).state = true;
              //         setState(() {
              //           incometype = value as String;
              //           ref.watch(incomeProvider.notifier).state = value;
              //         });
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: edit
            ? ElevatedButton(
                onPressed: () => educationdetailsupdatefuncationbtn(),
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

  educationdetailsupdatefuncationbtn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final education = ref.watch(educationProvider);
    final annualicome = ref.watch(incomeProvider);
    final userdetails = ref.watch(userdetailProvider);
    UpdateUser()
        .updateeducation(
            education: education == ""
                ? userdetails.eduOccupationArray![0].education.toString()
                : education,
            occupation: occupation.text == ""
                ? userdetails.eduOccupationArray![0].occupation.toString()
                : occupation.text,
            employeein: employee.text == ""
                ? userdetails.eduOccupationArray![0].employeeIn.toString()
                : employee.text,
            designation: designation.text == ""
                ? userdetails.eduOccupationArray![0].designation.toString()
                : designation.text,
            annualincome: annualicome == ""
                ? userdetails.eduOccupationArray![0].annualIncome.toString()
                : annualicome)
        .whenComplete(() async {
      ref.watch(editablefeduction.notifier).state = false;
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
        // occupation.clear();
        // employee.clear();
        // designation.clear();
      });
    });
  }

  List<String> selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List items = jobitems;

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items,type: 'education',);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        print(results);
        selectedItems = results;
      });
    }
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
