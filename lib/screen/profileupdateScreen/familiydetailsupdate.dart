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

class FamiliyDetailUpdate extends ConsumerStatefulWidget {
  const FamiliyDetailUpdate({super.key});

  @override
  ConsumerState<FamiliyDetailUpdate> createState() =>
      _FamiliyDetailUpdateState();
}

class _FamiliyDetailUpdateState extends ConsumerState<FamiliyDetailUpdate> {
  TextEditingController mothername = TextEditingController();
  TextEditingController motherjob = TextEditingController();
  TextEditingController fathername = TextEditingController();
  TextEditingController fatherjob = TextEditingController();
  TextEditingController about = TextEditingController();
  StateProvider editablefaimily = StateProvider((ref) => false);

  final List familystatus = ["Joint", "Nuclear"];
  StateProvider editablefamily = StateProvider((ref) => false);

  final List nobrolist = [
    "No. of Brother",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  final List nosislist = [
    "No. of Sister",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  final List nombrolist = [
    "Married Brother",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  final List nomsislist = [
    'Married Sister',
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  StateProvider editablesis = StateProvider((ref) => false);
  StateProvider editablemsis = StateProvider((ref) => false);
  StateProvider editablebro = StateProvider((ref) => false);
  StateProvider editablembro = StateProvider((ref) => false);

  @override
  void initState() {
    final userdetails = ref.read(userdetailProvider);
    mothername.text = userdetails.familyDetailsArray![0].mothersName.toString();
    motherjob.text =
        userdetails.familyDetailsArray![0].mothersOccupation.toString();
    fathername.text = userdetails.familyDetailsArray![0].fathersName.toString();
    fatherjob.text =
        userdetails.familyDetailsArray![0].fathersOccupation.toString();
    about.text = userdetails.familyDetailsArray![0].aboutFamily.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final edit = ref.watch(editablefaimily);
    final familtytype = ref.watch(familytypeProvider);
    final nosistype = ref.watch(nosisProvider);
    final nomsistype = ref.watch(nosismProvider);
    final nobrotype = ref.watch(nobroProvider);
    final nombrotype = ref.watch(nobromProvider);
    final userdetails = ref.watch(userdetailProvider);
    final editsis = ref.watch(editablesis);
    final editmsis = ref.watch(editablemsis);
    final editbro = ref.watch(editablebro);
    final editmbro = ref.watch(editablembro);

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref.watch(editablefaimily.notifier).state = !edit;
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
                      text: userdetails.familyDetailsArray![0].familyType
                          .toString(),
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
                          value: familystatus.contains(userdetails
                                  .familyDetailsArray![0].familyType
                                  .toString())
                              ? userdetails.familyDetailsArray![0].familyType
                                  .toString()
                              : familtytype,
                          onChanged: (value) {
                            ref.watch(familytypeProvider.notifier).state =
                                value as String;
                          },
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              //mothername textfield
              !edit
                  ? defaultcontainer(
                      text: userdetails.familyDetailsArray![0].mothersName
                          .toString(),
                    )
                  : TextFormField(
                      //border

                      controller: mothername,
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
                          "Mother Name",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'Mother Name',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              const SizedBox(height: 20),
              //motherjob textfield
              !edit
                  ? defaultcontainer(
                      text: userdetails.familyDetailsArray![0].mothersOccupation
                          .toString(),
                    )
                  : TextFormField(
                      //border

                      controller: motherjob,
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
                          "Mother Occupation",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'Mother Occupation',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              const SizedBox(height: 24),
              //fathername textfield
              !edit
                  ? defaultcontainer(
                      text: userdetails.familyDetailsArray![0].fathersName
                          .toString(),
                    )
                  : TextFormField(
                      controller: fathername,
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
                          "Father Name",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'Father Name',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
              const SizedBox(height: 24),
              //fatherjob textfield
              !edit
                  ? defaultcontainer(
                      text: userdetails.familyDetailsArray![0].fathersOccupation
                          .toString(),
                    )
                  : TextFormField(
                      //border

                      controller: fatherjob,
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
                          "Father Occupation",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'Father Occupation',
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
                            text: userdetails.familyDetailsArray![0].noOfSisters
                                .toString()),
                        SizedBox(
                          width: 16,
                        ),
                        defaultcontainerwidth(
                            text: userdetails
                                .familyDetailsArray![0].noOfMarriedSisters
                                .toString())
                      ],
                    )
                  : Row(
                      children: [
                        //no of bro dropdown
                        DropdownButtonHideUnderline(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            width: width / 2.4,
                            height: 60,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff9A9A9A)),
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
                              value: !editsis
                                  ? nosislist.contains(userdetails
                                          .familyDetailsArray![0].noOfSisters
                                          .toString())
                                      ? userdetails
                                          .familyDetailsArray![0].noOfSisters
                                          .toString()
                                      : nosistype
                                  : nosistype,
                              onChanged: (value) {
                                ref.watch(editablesis.notifier).state = true;
                                setState(() {
                                  ref.watch(nosisProvider.notifier).state =
                                      value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        //no of sister dropdown
                        DropdownButtonHideUnderline(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            width: width / 2.4,
                            height: 60,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff9A9A9A)),
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
                              value: !editmsis
                                  ? nomsislist.contains(userdetails
                                          .familyDetailsArray![0]
                                          .noOfMarriedSisters
                                          .toString())
                                      ? userdetails.familyDetailsArray![0]
                                          .noOfMarriedSisters
                                          .toString()
                                      : nomsistype
                                  : nomsistype,
                              onChanged: (value) {
                                ref.watch(editablemsis.notifier).state = true;
                                setState(() {
                                  ref.watch(nosismProvider.notifier).state =
                                      value;
                                });
                              },
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
                            text: userdetails
                                .familyDetailsArray![0].noOfBrothers
                                .toString()),
                        SizedBox(
                          width: 16,
                        ),
                        defaultcontainerwidth(
                            text: userdetails
                                .familyDetailsArray![0].noOfMarriedBrothers
                                .toString())
                      ],
                    )
                  : Row(
                      children: [
                        //no of bro dropdown
                        DropdownButtonHideUnderline(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            width: width / 2.4,
                            height: 60,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff9A9A9A)),
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
                              value: !editbro
                                  ? nobrolist.contains(userdetails
                                          .familyDetailsArray![0].noOfBrothers
                                          .toString())
                                      ? userdetails
                                          .familyDetailsArray![0].noOfBrothers
                                          .toString()
                                      : nobrotype
                                  : nobrotype,
                              onChanged: (value) {
                                ref.watch(editablebro.notifier).state = true;
                                setState(() {
                                  ref.watch(nobroProvider.notifier).state =
                                      value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        //no of sister dropdown
                        DropdownButtonHideUnderline(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            width: width / 2.4,
                            height: 60,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff9A9A9A)),
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
                              value: !editmbro
                                  ? nombrolist.contains(userdetails
                                          .familyDetailsArray![0]
                                          .noOfMarriedBrothers
                                          .toString())
                                      ? userdetails.familyDetailsArray![0]
                                          .noOfMarriedBrothers
                                          .toString()
                                      : nombrotype
                                  : nombrotype,
                              onChanged: (value) {
                                ref.watch(editablembro.notifier).state = true;
                                setState(() {
                                  ref.watch(nobromProvider.notifier).state =
                                      value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
              !edit
                  ? defaultcontainer(
                      text: userdetails.familyDetailsArray![0].aboutFamily
                          .toString(),
                    )
                  : TextFormField(
                      controller: about,
                      maxLines: 3,
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
                          "About my family ",
                          style: TextStyle(
                            fontSize: 14,
                            color: textcolor,
                          ),
                        ),
                        //hint text
                        hintText: 'About my family',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: lighttext),
                        //suffix
                      ),
                    ),
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
            : SizedBox.shrink());
  }

  basicdetailsupdatefuncationbtn() async {
    log('come');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final familtytype = ref.watch(familytypeProvider);
    final userdetails = ref.watch(userdetailProvider);
    final nosistype = ref.watch(nosisProvider);
    final nomsistype = ref.watch(nosismProvider);
    final nobrotype = ref.watch(nobroProvider);
    final nombrotype = ref.watch(nobromProvider);
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
                ? userdetails.familyDetailsArray![0].noOfBrothers
                    .toString()
                : nobrotype.toString(),
            noofsister: nosistype == "No. of Sister"
                ? userdetails.familyDetailsArray![0].noOfSisters
                    .toString()
                : nosistype.toString(),
            noofmarriedbro: nombrotype == "Married Brother"
                ? userdetails.familyDetailsArray![0].noOfMarriedBrothers
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
      ref.watch(editablefaimily.notifier).state = false;
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
        // mothername.clear();
        // motherjob.clear();
        // fathername.clear();
        // fatherjob.clear();
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
