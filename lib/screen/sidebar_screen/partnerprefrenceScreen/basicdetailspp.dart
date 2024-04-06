import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateperefrence_api/basicpp.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/containermultiselect.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicDetailsPP extends ConsumerStatefulWidget {
  const BasicDetailsPP({super.key});

  @override
  ConsumerState<BasicDetailsPP> createState() => _BasicDetailsPPState();
}

class _BasicDetailsPPState extends ConsumerState<BasicDetailsPP> {
  StateProvider editablefbasicpp = StateProvider((ref) => false);

  StateProvider martitalstatusppProvider =
      StateProvider((ref) => 'Marital Status');

  StateProvider skintoneppProvider = StateProvider((ref) => 'Skin Tone');

  StateProvider mothertoungeppProvider =
      StateProvider((ref) => 'Mother Tounge');

  StateProvider ageProviders1 = StateProvider((ref) => 'Age');
  StateProvider ageProviders2 = StateProvider((ref) => 'Age');

  final List eatstatus = ["Eating Habbits", "Veg", "Non-Veg", "All"];
  final List drinkstatus = ["Drinking Habbits", "Yes", "No"];
  final List mariedstatus = [
    "Marital Status",
    "Never Married",
    "Divorced",
    "Window",
  ];

  StateProvider heighppProviders1 = StateProvider((ref) => 'Height');
  StateProvider heighppProviders2 = StateProvider((ref) => 'Height');

  TextEditingController agefrom = TextEditingController();
  TextEditingController ageto = TextEditingController();

  StateProvider eatppProvider = StateProvider((ref) => 'Eating Habbits');

  StateProvider drinkppProvider = StateProvider((ref) => 'Drinking Habbits');

  TextEditingController genralexpect = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    final edit = ref.watch(editablefbasicpp);
    final height1 = ref.watch(heighppProviders1);
    final height2 = ref.watch(heighppProviders2);
    final eattype = ref.watch(eatppProvider);
    final drinktype = ref.watch(drinkppProvider);
    final userdetails = ref.watch(userdetailProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ref.watch(editablefbasicpp.notifier).state = !edit;
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
                        ? "Marital Status"
                        : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].lookingFor
                                    .toString() ==
                                ""
                            ? "Marital Status"
                            : userdetails.preferenceArray![0]
                                .basicPreferenceArray![0].lookingFor
                                .toString())
                : containermultiselect(
                    comfrom: "Marital Status",
                    ref: ref,
                    context: context,
                    items: mariedstatus,
                    providername: martitalstatusppProvider,
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Loking For"
                        : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].skintype
                                    .toString() ==
                                ""
                            ? "Loking For"
                            : userdetails.preferenceArray![0]
                                .basicPreferenceArray![0].skintype
                                .toString())
                : containermultiselect(
                    comfrom: "Skin Tone",
                    ref: ref,
                    context: context,
                    items: skintoneitems,
                    providername: skintoneppProvider,
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Mother Thounge"
                        : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].mothertounge
                                    .toString() ==
                                ""
                            ? "Mother Thounge"
                            : userdetails.preferenceArray![0]
                                .basicPreferenceArray![0].mothertounge
                                .toString())
                : containermultiselect(
                    comfrom: "Mother Thounge",
                    ref: ref,
                    context: context,
                    items: mothertoungeitems,
                    providername: mothertoungeppProvider,
                  ),
            const SizedBox(height: 20),
            Row(
              children: [
                !edit
                    ? halfdefaultcontainer(
                        text: userdetails.preferenceArray!.isEmpty
                            ? "Age From"
                            : userdetails.preferenceArray![0]
                                        .basicPreferenceArray![0].fromAge
                                        .toString() ==
                                    ""
                                ? "Age From"
                                : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].fromAge
                                    .toString())
                    : Container(
                        height: 70,
                        width: width / 2.3,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9A9A9A)),
                            borderRadius: BorderRadius.circular(8)),
                        child: SearchChoices.single(
                          items: ageitems
                              .map((item) => DropdownMenuItem(
                                  value: item, child: Text(item)))
                              .toList(),
                          value: ref.watch(ageProviders1),
                          hint: "Select Age From",
                          searchHint: "Search for Age From",
                          onChanged: (newValue) {
                            ref.watch(ageProviders1.notifier).state =
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
                const SizedBox(width: 11),
                !edit
                    ? halfdefaultcontainer(
                        text: userdetails.preferenceArray!.isEmpty
                            ? "Age To"
                            : userdetails.preferenceArray![0]
                                        .basicPreferenceArray![0].fromAge
                                        .toString() ==
                                    ""
                                ? "Age To"
                                : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].fromAge
                                    .toString())
                    : Container(
                        height: 70,
                        width: width / 2.3,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff9A9A9A)),
                            borderRadius: BorderRadius.circular(8)),
                        child: SearchChoices.single(
                          items: ageitems
                              .map((item) => DropdownMenuItem(
                                  value: item, child: Text(item)))
                              .toList(),
                          value: ref.watch(ageProviders2),
                          hint: "Select Age From",
                          searchHint: "Search for Age From",
                          onChanged: (newValue) {
                            ref.watch(ageProviders2.notifier).state =
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
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                !edit
                    ? halfdefaultcontainer(
                        text: userdetails.preferenceArray!.isEmpty
                            ? "Height To"
                            : userdetails.preferenceArray![0]
                                        .basicPreferenceArray![0].fromHeight
                                        .toString() ==
                                    ""
                                ? "Height To"
                                : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].fromHeight
                                    .toString())
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
                          value: height1,
                          hint: "Select Height From",
                          searchHint: "Search for Height From",
                          onChanged: (newValue) {
                            ref.watch(heighppProviders1.notifier).state =
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
                const SizedBox(width: 11),
                !edit
                    ? halfdefaultcontainer(
                        text: userdetails.preferenceArray!.isEmpty
                            ? "Height To"
                            : userdetails.preferenceArray![0]
                                        .basicPreferenceArray![0].toHeight
                                        .toString() ==
                                    ""
                                ? "Height To"
                                : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].toHeight
                                    .toString())
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
                          value: height2,
                          hint: "Select Height From",
                          searchHint: "Search for Height From",
                          onChanged: (newValue) {
                            ref.watch(heighppProviders2.notifier).state =
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
              ],
            ),
            const SizedBox(height: 20),
            // const SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Eating Habbits"
                        : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].eatingHabit
                                    .toString() ==
                                ""
                            ? "Eating Habbits"
                            : userdetails.preferenceArray![0]
                                .basicPreferenceArray![0].eatingHabit
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
                        items: eatstatus
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
                        value: eattype,
                        onChanged: (value) {
                          ref.watch(eatppProvider.notifier).state =
                              value as String;
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Drinking Habbits"
                        : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].drinkingHabit
                                    .toString() ==
                                ""
                            ? "Drinking Habbits"
                            : userdetails.preferenceArray![0]
                                .basicPreferenceArray![0].drinkingHabit
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
                        items: drinkstatus
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
                        value: drinktype,
                        onChanged: (value) {
                          ref.watch(drinkppProvider.notifier).state =
                              value as String;
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Genral Expectations"
                        : userdetails.preferenceArray![0]
                                    .basicPreferenceArray![0].generalExpt
                                    .toString() ==
                                ""
                            ? "Genral Expectations"
                            : userdetails.preferenceArray![0]
                                .basicPreferenceArray![0].generalExpt
                                .toString())
                : TextFormField(
                    //border
                    maxLines: 3,
                    controller: genralexpect,
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
                        "General Expectations ",
                        style: TextStyle(
                          fontSize: 14,
                          color: textcolor,
                        ),
                      ),
                      //hint text
                      hintText: '',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: lighttext),
                      //suffix
                    ),
                  ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: edit
          ? ElevatedButton(
              onPressed: () async {
                if (edit) {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var userid = prefs.getString('userid');
                  basicppupdate(
                    martitalstatus:
                        ref.read(martitalstatusppProvider).toString(),
                    skintype: ref.read(skintoneppProvider).toString(),
                    mothertounge: ref.read(mothertoungeppProvider).toString(),
                    agefrom: ref.watch(ageProviders1).toString(),
                    ageto: ref.watch(ageProviders2).toString(),
                    heightfrom: ref.watch(heighppProviders1).toString(),
                    heightto: ref.watch(heighppProviders2).toString(),
                    eattype: ref.watch(eatppProvider).toString(),
                    drinktype: ref.watch(drinkppProvider).toString(),
                    generalexpectations: genralexpect.text,
                  ).whenComplete(() {
                    setState(() {
                      getuserprofile(ref: ref, id: userid.toString());
                      ref.watch(editablefbasicpp.notifier).state = false;
                    });
                  });
                } else {
                  toast('Please on edit mode first');
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

  halfdefaultcontainer({required String text}) {
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
