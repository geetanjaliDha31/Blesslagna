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

class LifestyleDetailsUpdate extends ConsumerStatefulWidget {
  const LifestyleDetailsUpdate({super.key});

  @override
  ConsumerState<LifestyleDetailsUpdate> createState() =>
      _LifestyleDetailsUpdateState();
}

class _LifestyleDetailsUpdateState
    extends ConsumerState<LifestyleDetailsUpdate> {
  final List booldstatu = ["Blood Type", "A+", "B+", "AB+", "o+"];

  final List eatstatus = ["Eating Habbits", "Veg", "Non-Veg", "All"];

  final List smokestatus = ["Smoking Habbits", "Yes", "No"];
  // StateProvider smokinghabbitProvider =
  //     StateProvider((ref) => "Smoking Habbits");
  final List drinkstatus = ["Drinking Habbits", "Yes", "No"];
  // StateProvider drinkinghabbitProvider =
  //     StateProvider((ref) => "Drinking Habbits");

  StateProvider editableflifedtyle = StateProvider((ref) => false);

  StateProvider editablebody = StateProvider((ref) => false);
  StateProvider editableskin = StateProvider((ref) => false);
  StateProvider editableblood = StateProvider((ref) => false);
  StateProvider editablehabbiteat = StateProvider((ref) => false);
  StateProvider editablehabbitsmoke = StateProvider((ref) => false);
  StateProvider editablehabbitdrink = StateProvider((ref) => false);
  @override
  Widget build(BuildContext context) {
    final edit = ref.watch(editableflifedtyle);
    final userdetails = ref.watch(userdetailProvider);
    double width = MediaQuery.of(context).size.width;
    final booldtype = ref.watch(bloodtypeProvider);
    final bodytype = ref.watch(bodytypeProvider);
    final skintype = ref.watch(skintoneProvider);
    final eattype = ref.watch(eatProvider);
    final smoketype = ref.watch(smokeProvider);
    final drinktype = ref.watch(drinkProvider);
    final editbody = ref.watch(editablebody);
    final editskin = ref.watch(editableskin);
    final editboold = ref.watch(editableblood);
    final editeat = ref.watch(editablehabbiteat);
    final editsmoke = ref.watch(editablehabbitsmoke);
    final editdrink = ref.watch(editablehabbitdrink);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ref.watch(editableflifedtyle.notifier).state = !edit;
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
                    text: userdetails.lifestyleDetailsArray![0].bodyType
                        .toString(),
                  )
                : DropdownButtonHideUnderline(
                    child: Container(
                      margin: EdgeInsets.only(left: 2),
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
                        items: bodytypeitems
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
                        value: !editbody
                            ? bodytypeitems.contains(userdetails
                                    .lifestyleDetailsArray![0].bodyType
                                    .toString())
                                ? userdetails.lifestyleDetailsArray![0].bodyType
                                    .toString()
                                : bodytype
                            : bodytype,
                        onChanged: (value) {
                          ref.watch(editablebody.notifier).state = true;
                          ref.watch(bodytypeProvider.notifier).state =
                              value as String;
                        },
                      ),
                    ),
                  ),

            const SizedBox(height: 20),
            //skintone dropdown
            !edit
                ? defaultcontainer(
                    text: userdetails.lifestyleDetailsArray![0].skinTone
                        .toString(),
                  )
                : DropdownButtonHideUnderline(
                    child: Container(
                      margin: EdgeInsets.only(left: 2),
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
                        items: skintoneitems
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
                        value: !editskin
                            ? skintoneitems.contains(userdetails
                                    .lifestyleDetailsArray![0].skinTone
                                    .toString())
                                ? userdetails.lifestyleDetailsArray![0].skinTone
                                    .toString()
                                : skintype
                            : skintype,
                        onChanged: (value) {
                          ref.watch(editableskin.notifier).state = true;
                          ref.watch(skintoneProvider.notifier).state =
                              value as String;
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            //blood grp dropown
            !edit
                ? defaultcontainer(
                    text: userdetails.lifestyleDetailsArray![0].bloodGroup
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
                        items: booldstatu
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
                        value: !editboold
                            ? booldstatu.contains(userdetails
                                    .lifestyleDetailsArray![0].bloodGroup
                                    .toString())
                                ? userdetails
                                    .lifestyleDetailsArray![0].bloodGroup
                                    .toString()
                                : booldtype
                            : booldtype,
                        onChanged: (value) {
                          ref.watch(editableblood.notifier).state = true;
                          ref.watch(bloodtypeProvider.notifier).state =
                              value as String;
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            //eating habbit dropdown
            !edit
                ? defaultcontainer(
                    text: userdetails.lifestyleDetailsArray![0].eatingHabbit
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
                        value: !editeat
                            ? eatstatus.contains(userdetails
                                    .lifestyleDetailsArray![0].eatingHabbit
                                    .toString())
                                ? userdetails
                                    .lifestyleDetailsArray![0].eatingHabbit
                                    .toString()
                                : eattype
                            : eattype,
                        onChanged: (value) {
                          ref.watch(editablehabbiteat.notifier).state = true;
                          ref.watch(eatProvider.notifier).state =
                              value as String;
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            //smoking habbit dropdown
            !edit
                ? defaultcontainer(
                    text: userdetails.lifestyleDetailsArray![0].smokingHabbit
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
                        items: smokestatus
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
                        value: !editsmoke
                            ? smokestatus.contains(userdetails
                                    .lifestyleDetailsArray![0].smokingHabbit
                                    .toString())
                                ? userdetails
                                    .lifestyleDetailsArray![0].smokingHabbit
                                    .toString()
                                : smoketype
                            : smoketype,
                        onChanged: (value) {
                          ref.watch(editablehabbitsmoke.notifier).state = true;
                          ref.watch(smokeProvider.notifier).state =
                              value as String;
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
            //drink status dropdown
            !edit
                ? defaultcontainer(
                    text: userdetails.lifestyleDetailsArray![0].drinkingHabbit
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
                        value: !editdrink
                            ? drinkstatus.contains(userdetails
                                    .lifestyleDetailsArray![0].drinkingHabbit
                                    .toString())
                                ? userdetails
                                    .lifestyleDetailsArray![0].drinkingHabbit
                                    .toString()
                                : drinktype
                            : drinktype,
                        onChanged: (value) {
                          ref.watch(editablehabbitdrink.notifier).state = true;
                          ref.watch(drinkProvider.notifier).state =
                              value as String;
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
              onPressed: () => lifestyledetailsupdatefuncationbtn(),
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

  lifestyledetailsupdatefuncationbtn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final userdetails = ref.watch(userdetailProvider);
    final booldtype = ref.watch(bloodtypeProvider);
    final bodytype = ref.watch(bodytypeProvider);
    final skintype = ref.watch(skintoneProvider);
    final eattype = ref.watch(eatProvider);
    final smoketype = ref.watch(drinkProvider);
    final drinktype = ref.watch(drinkProvider);
    UpdateUser()
        .updatelifestyle(
      bodytype: bodytype == ""
          ? userdetails.lifestyleDetailsArray![0].bodyType
          : bodytype,
      skintone: skintype == ""
          ? userdetails.lifestyleDetailsArray![0].skinTone
          : skintype,
      blood: booldtype == ""
          ? userdetails.lifestyleDetailsArray![0].bloodGroup
          : booldtype,
      eating: eattype == ""
          ? userdetails.lifestyleDetailsArray![0].eatingHabbit
          : eattype,
      smoking: smoketype == ""
          ? userdetails.lifestyleDetailsArray![0].smokingHabbit
          : smoketype,
      drink: drinktype == ""
          ? userdetails.lifestyleDetailsArray![0].drinkingHabbit
          : drinktype,
    )
        .whenComplete(() {
      ref.watch(editableflifedtyle.notifier).state = false;
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
      });
      ref.watch(editablebody.notifier).state = false;
      ref.watch(editableskin.notifier).state = false;
      ref.watch(editableblood.notifier).state = false;
      ref.watch(editablehabbiteat.notifier).state = false;
      ref.watch(editablehabbitsmoke.notifier).state = false;
      ref.watch(editablehabbitdrink.notifier).state = false;
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
