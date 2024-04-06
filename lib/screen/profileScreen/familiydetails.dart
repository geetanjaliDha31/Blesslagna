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
import 'package:shared_preferences/shared_preferences.dart';

class FamilyDetails extends ConsumerStatefulWidget {
  final String comefrom;
  const FamilyDetails({super.key, required this.comefrom});

  @override
  ConsumerState<FamilyDetails> createState() => _FamilyDetailsState();
}

TextEditingController mothername = TextEditingController();
TextEditingController motherjob = TextEditingController();
TextEditingController fathername = TextEditingController();
TextEditingController fatherjob = TextEditingController();
// TextEditingController nobro = TextEditingController();
// TextEditingController nosis = TextEditingController();
// TextEditingController nombro = TextEditingController();
// TextEditingController nomsis = TextEditingController();
TextEditingController about = TextEditingController();

class _FamilyDetailsState extends ConsumerState<FamilyDetails> {
  final List familystatus = ["Joint", "Nuclear"];
  StateProvider editablefamily = StateProvider((ref) => false);

  final List nobrolist = ["No. of Brother", "0", "1", "2", "3", "4", "5"];
  String? nobrotype = "No. of Brother";

  final List nosislist = ["No. of Sister", "0", "1", "2", "3", "4", "5"];
  String? nosistype = "No. of Sister";

  final List nombrolist = ["Married Brother", "0", "1", "2", "3", "4", "5"];
  String? nombrotype = "Married Brother";

  final List nomsislist = ['Married Sister', "0", "1", "2", "3", "4", "5"];
  String? nomsistype = 'Married Sister';

  @override
  Widget build(BuildContext context) {
    final familtytype = ref.watch(familytypeProvider);
    final userdetails = ref.watch(userdetailProvider);
    final edit = ref.watch(editablefamily);
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          widget.comefrom == ''
              ? GestureDetector(
                  onTap: () {
                    ref.watch(editablefamily.notifier).state = !edit;
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
                    text: 'Family ',
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
          //family type dropdown
          !edit && widget.comefrom == ''
              ? defaultcontainer(
                  text:
                      userdetails.familyDetailsArray![0].familyType.toString(),
                )
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
                      items: familystatus
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
                      value: familtytype,
                      onChanged: (value) {
                        ref.watch(familytypeProvider.notifier).state =
                            value as String;
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          //mothername textfield
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
            controller: mothername,
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
                    ? userdetails.familyDetailsArray![0].mothersName.toString()
                    : "Mother Name",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'Mother Name',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          //motherjob textfield
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
            controller: motherjob,
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
                    ? userdetails.familyDetailsArray![0].mothersOccupation
                        .toString()
                    : "Mother Occupation",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'Mother Occupation',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          //fathername textfield
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
            controller: fathername,
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
                    ? userdetails.familyDetailsArray![0].fathersName.toString()
                    : "Father Name",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'Father Name',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          //fatherjob textfield
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
            controller: fatherjob,
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
                    ? userdetails.familyDetailsArray![0].fathersOccupation
                        .toString()
                    : "Father Occupation",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'Father Occupation',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              //no of bro dropdown
              !edit && widget.comefrom == ''
                  ? defaultcontainer(
                      text: userdetails.familyDetailsArray![0].noOfBrothers
                          .toString(),
                    )
                  : DropdownButtonHideUnderline(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        width: width / 2.4,
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
                          items: nobrolist
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
                          value: nobrotype,
                          onChanged: (value) {
                            setState(() {
                              nobrotype = value as String;
                              ref.watch(nobroProvider.notifier).state = value;
                            });
                          },
                        ),
                      ),
                    ),
              const SizedBox(width: 8),
              //no of sister dropdown
              !edit && widget.comefrom == ''
                  ? defaultcontainer(
                      text: userdetails.familyDetailsArray![0].noOfSisters
                          .toString(),
                    )
                  : DropdownButtonHideUnderline(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        width: width / 2.4,
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
                          items: nosislist
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
                          value: nosistype,
                          onChanged: (value) {
                            setState(() {
                              nosistype = value as String;
                              ref.watch(nosisProvider.notifier).state = value;
                            });
                          },
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              //noofmarriedbro dropdown
              !edit && widget.comefrom == ''
                  ? defaultcontainer(
                      text: userdetails
                          .familyDetailsArray![0].noOfMarriedBrothers
                          .toString(),
                    )
                  : DropdownButtonHideUnderline(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        width: width / 2.4,
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
                          items: nombrolist
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
                          value: nombrotype,
                          onChanged: (value) {
                            setState(() {
                              nombrotype = value as String;
                              ref.watch(nobromProvider.notifier).state = value;
                            });
                          },
                        ),
                      ),
                    ),
              const SizedBox(width: 8),
              //noofmarriedsis dropdown
              !edit && widget.comefrom == ''
                  ? defaultcontainer(
                      text: userdetails
                          .familyDetailsArray![0].noOfMarriedSisters
                          .toString(),
                    )
                  : DropdownButtonHideUnderline(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        width: width / 2.4,
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
                          items: nomsislist
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
                          value: nomsistype,
                          onChanged: (value) {
                            setState(() {
                              nomsistype = value as String;
                              ref.watch(nosismProvider.notifier).state = value;
                            });
                          },
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 24),
          //about family textfield
          TextFormField(
            controller: about,
            maxLines: 3,
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
            //border
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
                    ? userdetails.familyDetailsArray![0].aboutFamily.toString()
                    : "About my family ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: 'About my family',
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          widget.comefrom == '' && edit
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
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  basicdetailsupdatefuncationbtn() async {
    log('come');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final familtytype = ref.watch(familytypeProvider);
    final userdetails = ref.watch(userdetailProvider);
    UpdateUser()
        .updatefamiliy(
            familytype: familtytype,
            mothername: mothername.text == ""
                ? userdetails.familyDetailsArray![0].mothersName.toString()
                : mothername.text,
            motherjob: motherjob.text == ""
                ? userdetails.familyDetailsArray![0].mothersOccupation
                    .toString()
                : motherjob.text,
            fathername: fathername.text == ""
                ? userdetails.familyDetailsArray![0].fathersName.toString()
                : fathername.text,
            fatherjob: fatherjob.text == ""
                ? userdetails.familyDetailsArray![0].fathersOccupation
                    .toString()
                : fatherjob.text,
            noofbro: nobrotype == "No. of Brother"
                ? userdetails.familyDetailsArray![0].noOfMarriedSisters
                    .toString()
                : nobrotype.toString(),
            noofsister: nosistype == "No. of Sister"
                ? userdetails.familyDetailsArray![0].noOfMarriedSisters
                    .toString()
                : nosistype.toString(),
            noofmarriedbro: nombrotype == "Married Brother"
                ? userdetails.familyDetailsArray![0].noOfMarriedSisters
                    .toString()
                : nombrotype.toString(),
            noofmarriedsis: nomsistype == "Married Sister"
                ? userdetails.familyDetailsArray![0].noOfMarriedSisters
                    .toString()
                : nomsistype.toString(),
            aboutfamily: about.text == ""
                ? userdetails.familyDetailsArray![0].aboutFamily.toString()
                : about.text)
        .whenComplete(() {
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
        mothername.clear();
        motherjob.clear();
        fathername.clear();
        fatherjob.clear();
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
