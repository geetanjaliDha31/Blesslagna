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

class LifeStyleDetails extends ConsumerStatefulWidget {
  final String comefrom;
  const LifeStyleDetails({super.key, required this.comefrom});

  @override
  ConsumerState<LifeStyleDetails> createState() => _LifeStyleDetailsState();
}

// TextEditingController bodytype = TextEditingController();
// TextEditingController skintone = TextEditingController();

class _LifeStyleDetailsState extends ConsumerState<LifeStyleDetails> {
  final List booldstatu = ["Blood Type", "A+", "B+", "AB+", "o+"];

  final List eatstatus = ["Eating Habbits", "Veg", "Non-Veg", "All"];

  final List smokestatus = ["Smoking Habbits", "Yes", "No"];

  final List drinkstatus = ["Drinking Habbits", "Yes", "No"];

  StateProvider editablelife = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context) {
    final booldtype = ref.watch(bloodtypeProvider);
    final bodytype = ref.watch(bodytypeProvider);
    final skintype = ref.watch(skintoneProvider);
    final eattype = ref.watch(eatProvider);
    final smoketype = ref.watch(smokeProvider);
    final drinktype = ref.watch(drinkProvider);
    final userdetails = ref.watch(userdetailProvider);
    double width = MediaQuery.of(context).size.width;
    final edit = ref.watch(editablelife);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.comefrom == ''
              ? GestureDetector(
                  onTap: () {
                    ref.watch(editablelife.notifier).state = !edit;
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
                    text: 'Lifestyle ',
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
          //body type dropdown
          !edit && widget.comefrom == ''
              ? defaultcontainer(
                  text:
                      userdetails.lifestyleDetailsArray![0].bodyType.toString(),
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
                      value: bodytype,
                      onChanged: (value) {
                        ref.watch(bodytypeProvider.notifier).state =
                            value as String;
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          //skintone dropdown
          !edit && widget.comefrom == ''
              ? defaultcontainer(
                  text:
                      userdetails.lifestyleDetailsArray![0].skinTone.toString(),
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
                      value: skintype,
                      onChanged: (value) {
                        ref.watch(skintoneProvider.notifier).state =
                            value as String;
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          //blood grp dropown
          !edit && widget.comefrom == ''
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
                      value: booldtype,
                      onChanged: (value) {
                        ref.watch(bloodtypeProvider.notifier).state =
                            value as String;
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          //eating habbit dropdown
          !edit && widget.comefrom == ''
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
                      value: eattype,
                      onChanged: (value) {
                        ref.watch(eatProvider.notifier).state = value as String;
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          //smoking habbit dropdown
          !edit && widget.comefrom == ''
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
                      value: smoketype,
                      onChanged: (value) {
                        ref.watch(smokeProvider.notifier).state =
                            value as String;
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          //drink status dropdown
          !edit && widget.comefrom == ''
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
                      value: drinktype,
                      onChanged: (value) {
                        ref.watch(drinkProvider.notifier).state =
                            value as String;
                      },
                    ),
                  ),
                ),
          const SizedBox(height: 24),
          widget.comefrom == '' && edit
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
              : const SizedBox.shrink()
        ],
      ),
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
    final smoketype = ref.watch(smokeProvider);
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
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
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
