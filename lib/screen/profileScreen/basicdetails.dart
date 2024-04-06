import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/provider/timefunction.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';

class BasicDetails extends ConsumerStatefulWidget {
  final String comefrom;
  const BasicDetails({super.key, required this.comefrom});

  @override
  ConsumerState<BasicDetails> createState() => _BasicDetailsState();
}

// TextEditingController height = TextEditingController();

TextEditingController usernametext = TextEditingController();
TextEditingController hobbiestext = TextEditingController();
TextEditingController weighttext = TextEditingController();
TextEditingController brithplacetext = TextEditingController();
TextEditingController languagekhowntext = TextEditingController();
TimeOfDay? timebrith;

class _BasicDetailsState extends ConsumerState<BasicDetails> {
  final List mariedstatus = [
    "Marital Status",
    "Never Married",
    "Divorced",
    "Window",
  ];
  StateProvider editablefbasic = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    final mariedtypeuser = ref.watch(martitalstatusProvider);
    final mothertounge = ref.watch(mothertoungeProvider);
    final height = ref.watch(heighProvider);
    final userdetails = ref.watch(userdetailProvider);
    final username = ref.read(usernameProvider);
    final edit = ref.watch(editablefbasic);
    final prefielddate = ref.read(selectdateProvider);
    final pickdate = ref.watch(selectdateProvider);

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          widget.comefrom == ''
              ? GestureDetector(
                  onTap: () {
                    ref.watch(editablefbasic.notifier).state = !edit;
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
                    text: 'Basic ',
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
          //username textfield
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
            keyboardType: TextInputType.text,
            controller: usernametext,
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
                    ? edit
                        ? "Name"
                        : userdetails.basicDetailsArray![0].name.toString()
                    : username,
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: widget.comefrom == '' ? "Name" : username,
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          //hobbies textfield
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

            keyboardType: TextInputType.text,
            controller: hobbiestext,
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
                    ? userdetails.basicDetailsArray![0].hobbies.toString()
                    : "Hobbies ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: "Hobbies",
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              //height dropdown with condition
              !edit && widget.comefrom == ''
                  ? defaultcontainer(
                      text: userdetails.basicDetailsArray![0].height.toString(),
                    )
                  : Container(
                      height: 70,
                      width: width / 2.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff9A9A9A)),
                          borderRadius: BorderRadius.circular(8)),
                      child: SearchChoices.single(
                        items: heightitems
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        value: height,
                        hint: "Select Height",
                        searchHint: "Search for Height",
                        onChanged: (newValue) {
                          ref.watch(heighProvider.notifier).state =
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

              //  DropdownButtonHideUnderline(
              //     child: Container(
              //       margin: EdgeInsets.only(left: 2),
              //       width: width / 2.4,
              //       height: 60,
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
              //         items: heightitems
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
              //         value: height,
              //         onChanged: (value) {
              //           ref.watch(heighProvider.notifier).state =
              //               value as String;
              //         },
              //       ),
              //     ),
              //   ),
              const SizedBox(width: 16),
              //weight textfield
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
                  keyboardType: TextInputType.number,
                  controller: weighttext,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff9A9A9A)),
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
                          ? userdetails.basicDetailsArray![0].height.toString()
                          : "Weight ",
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
                        color: lighttext),
                    //suffix
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          //brith place textfield
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
            keyboardType: TextInputType.text,
            controller: brithplacetext,
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
                    ? userdetails.basicDetailsArray![0].birthplace.toString()
                    : "Birth Place ",
                style: TextStyle(
                  fontSize: 14,
                  color: textcolor,
                ),
              ),
              //hint text
              hintText: "Birth Place ",
              hintStyle: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
              //suffix
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              //brithdate datepicker with condition
              !edit && widget.comefrom == ''
                  ? Container(
                      margin: EdgeInsets.only(left: 2),
                      width: width / 2.4,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Text(
                          userdetails.basicDetailsArray![0].age.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    )
                  : Container(
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
                                      ? "Date of Birth"
                                      : pickdate,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () async {
                                await _selectDate(context, ref)
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
                  if (edit || widget.comefrom == 'stepper') {
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
                  decoration: !edit && widget.comefrom == ''
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
                          border: Border.all(color: const Color(0xff9A9A9A)),
                          borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          timebrith == null
                              ? "Select Time"
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
          const SizedBox(height: 24),
          Row(
            children: [
              //mothertounge dropdown with condition
              !edit && widget.comefrom == ''
                  ? defaultcontainer(
                      text: userdetails.basicDetailsArray![0].motherTongue
                          .toString(),
                    )
                  : Container(
                      height: 70,
                      width: width / 2.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff9A9A9A)),
                          borderRadius: BorderRadius.circular(8)),
                      child: SearchChoices.single(
                        items: mothertoungeitems
                            .map((item) => DropdownMenuItem(
                                value: item, child: Text(item)))
                            .toList(),
                        value: mothertounge,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        hint: "Select Mother Tounge",
                        searchHint: "Search for Mother Tounge",
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
              //       value: mothertounge,
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
                  keyboardType: TextInputType.text,
                  controller: languagekhowntext,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff9A9A9A)),
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
                          ? userdetails.basicDetailsArray![0].language
                              .toString()
                          : "Languages Known ",
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
                        color: lighttext),
                    //suffix
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          //married status with condition
          !edit && widget.comefrom == ''
              ? defaultcontainer(
                  text: userdetails.basicDetailsArray![0].maritalStatus
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
                      value: mariedtypeuser,
                      onChanged: (value) {
                        ref.watch(martitalstatusProvider.notifier).state =
                            value as String;
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          // widget.comefrom == '' && edit
          //     ? ElevatedButton(
          //         onPressed: () => basicdetailsupdatefuncationbtn(),
          //         style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(8)),
          //             backgroundColor: primary,
          //             minimumSize: Size(width, 50)),
          //         child: const Text(
          //           "Update",
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontWeight: FontWeight.w400,
          //               fontSize: 14),
          //         ))
          //     : const SizedBox.shrink()
        ],
      ),
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

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
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
