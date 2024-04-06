import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateuserdata/updateuser.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:blesslagna/screen/widget/multiselecte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationDetails extends ConsumerStatefulWidget {
  final String comefrom;
  const EducationDetails({super.key, required this.comefrom});

  @override
  ConsumerState<EducationDetails> createState() => _EducationDetailsState();
}

// final MultiSelectController _controller = MultiSelectController();

// final List<ValueItem> _selectedOptions = [];
TextEditingController occupation = TextEditingController();
TextEditingController employee = TextEditingController();
TextEditingController designation = TextEditingController();
// TextEditingController education = TextEditingController();
// TextEditingController icome = TextEditingController();
List<String> selectedItems = [];

String? educationtype = "Select Education";
String? incometype = "Select Income";

class _EducationDetailsState extends ConsumerState<EducationDetails> {
  StateProvider editableeducation = StateProvider((ref) => false);

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List items = jobitems;

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items, type: 'education');
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    final userdetails = ref.watch(userdetailProvider);
    final education = ref.watch(educationProvider);

    final edit = ref.watch(editableeducation);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.comefrom == ''
              ? GestureDetector(
                  onTap: () {
                    ref.watch(editableeducation.notifier).state = !edit;
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
                    text: 'Education ',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xD9131313)),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: primary)),
                    ],
                  ),
                ),
          const SizedBox(height: 24),
          //education dropdown
          !edit && widget.comefrom == ''
              ? defaultcontainer(
                  text: userdetails.eduOccupationArray![0].education.toString(),
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
                      // boxShadow: const [
                      //   BoxShadow(
                      //       color: Color(
                      //         0x3f000000,
                      //       ), //New
                      //       blurRadius: 1.0,
                      //       offset: Offset(0, 0))
                      // ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
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
          const SizedBox(height: 24),
          //occupation textfield
          TextFormField(
            //border
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
            controller: occupation,
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
                    ? userdetails.eduOccupationArray![0].occupation.toString()
                    : "Occupation ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'Occupation',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          //employee in textfield
          TextFormField(
            //border
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
            controller: employee,
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
                    ? userdetails.eduOccupationArray![0].employeeIn.toString()
                    : "Employee in ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'Employee in',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          //designation textfield
          TextFormField(
            //border
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
            controller: designation,
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
                    ? userdetails.eduOccupationArray![0].designation.toString()
                    : "Designation ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'Designation',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          //annual income with condition
          !edit && widget.comefrom == ''
              ? defaultcontainer(
                  text: userdetails.eduOccupationArray![0].annualIncome
                      .toString(),
                )
              : Container(
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff9A9A9A)),
                      borderRadius: BorderRadius.circular(8)),
                  child: SearchChoices.single(
                    items: incomeitems
                        .map((item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    value: incometype,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    hint: "Select Income",
                    searchHint: "Search for Income",
                    onChanged: (newValue) {
                      setState(() {
                        incometype = newValue as String;
                        ref.watch(incomeProvider.notifier).state = newValue;
                      });
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
          //     child: Container(
          //       height: 60,
          //       width: width,
          //       decoration: BoxDecoration(
          //           border: Border.all(color: const Color(0xff9A9A9A)),
          //           borderRadius: BorderRadius.circular(8)),
          //       child: DropdownButton2(
          //         // buttonDecoration: shadowdecoration,
          //         isExpanded: true,
          //         buttonStyleData: const ButtonStyleData(
          //           padding: EdgeInsets.symmetric(horizontal: 16),
          //           height: 40,
          //           width: 140,
          //         ),
          //         items: incomeitems
          //             .map((item) => DropdownMenuItem(
          //                   value: item,
          //                   child: Text(
          //                     item,
          //                     style: const TextStyle(
          //                       color: Colors.black,
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w400,
          //                     ),
          //                   ),
          //                 ))
          //             .toList(),
          //         value: incometype,
          //         onChanged: (value) {
          //           setState(() {
          //             incometype = value as String;
          //             ref.watch(incomeProvider.notifier).state = value;
          //           });
          //         },
          //       ),
          //     ),
          //   ),

          const SizedBox(height: 24),
          widget.comefrom == '' && edit
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
              : const SizedBox.shrink()
        ],
      ),
    );
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
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
        occupation.clear();
        employee.clear();
        designation.clear();
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

convertlisttostring(
    {required List<String> educationlist,
    required WidgetRef ref,
    required String type}) {
  String education = '';

  //eduction
  if (type == 'education') {
    for (int i = 0; i < educationlist.length; i++) {
      if (i == educationlist.length - 1) {
        education += educationlist[i];
      } else {
        education += '${educationlist[i]},';
      }
    }
    ref.watch(educationProvider.notifier).state = education;
  }

  //country
  if (type == 'country') {
    for (int i = 0; i < educationlist.length; i++) {
      if (i == educationlist.length - 1) {
        education += educationlist[i];
      } else {
        education += '${educationlist[i]},';
      }
    }
    ref.watch(countrysearchProvider.notifier).state = education;
  }

  //state
  if (type == 'state') {
    for (int i = 0; i < educationlist.length; i++) {
      if (i == educationlist.length - 1) {
        education += educationlist[i];
      } else {
        education += '${educationlist[i]},';
      }
    }
    ref.watch(statesearchProvider.notifier).state = education;
  }

  //city
  if (type == 'city') {
    for (int i = 0; i < educationlist.length; i++) {
      if (i == educationlist.length - 1) {
        education += educationlist[i];
      } else {
        education += '${educationlist[i]},';
      }
    }
    ref.watch(citysearchProvider.notifier).state = education;
  }
  //marital
  if (type == 'marital') {
    for (int i = 0; i < educationlist.length; i++) {
      if (i == educationlist.length - 1) {
        education += educationlist[i];
      } else {
        education += '${educationlist[i]},';
      }
    }
    ref.watch(maritalstatussearchProvider.notifier).state = education;
  }
  //mother
  if (type == 'mother') {
    for (int i = 0; i < educationlist.length; i++) {
      if (i == educationlist.length - 1) {
        education += educationlist[i];
      } else {
        education += '${educationlist[i]},';
      }
    }
    ref.watch(mothertoungesearchProvider.notifier).state = education;
  }
}
