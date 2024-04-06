import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateperefrence_api/religionpp.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/containermultiselect.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReligionDetailsPP extends ConsumerStatefulWidget {
  const ReligionDetailsPP({super.key});

  @override
  ConsumerState<ReligionDetailsPP> createState() => _ReligionDetailsPPState();
}

class _ReligionDetailsPPState extends ConsumerState<ReligionDetailsPP> {
  StateProvider editablefreligionpp = StateProvider((ref) => false);
  final List mangliklist = ["Are You Manglik", "Yes", "No"];
  String? mangliktype = "Are You Manglik";
  TextEditingController star = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final edit = ref.watch(editablefreligionpp);
    final userdetails = ref.watch(userdetailProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ref.watch(editablefreligionpp.notifier).state = !edit;
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
                        ? "Select Religion"
                        : userdetails.preferenceArray![0]
                                    .religiousPreferenceArray![0].religon
                                    .toString() ==
                                ""
                            ? "Select Religion"
                            : userdetails.preferenceArray![0]
                                .religiousPreferenceArray![0].religon
                                .toString())
                : containermultiselect(
                    comfrom: "Select Religion",
                    ref: ref,
                    context: context,
                    items: religioitems,
                    providername: religionProvider,
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Are You Manglik"
                        : userdetails.preferenceArray![0]
                                    .religiousPreferenceArray![0].manglik
                                    .toString() ==
                                ""
                            ? "Are You Manglik"
                            : userdetails.preferenceArray![0]
                                .religiousPreferenceArray![0].manglik
                                .toString())
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
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Select Cast"
                        : userdetails.preferenceArray![0]
                                    .religiousPreferenceArray![0].caste
                                    .toString() ==
                                ""
                            ? "Select Cast"
                            : userdetails.preferenceArray![0]
                                .religiousPreferenceArray![0].caste
                                .toString())
                : containermultiselect(
                    comfrom: "Select Cast",
                    ref: ref,
                    context: context,
                    items: castitems,
                    providername: castProvider,
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Star"
                        : userdetails.preferenceArray![0]
                                    .religiousPreferenceArray![0].star
                                    .toString() ==
                                ""
                            ? "Star"
                            : userdetails.preferenceArray![0]
                                .religiousPreferenceArray![0].star
                                .toString())
                : SizedBox(
                    width: width,
                    child: TextFormField(
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
                          "Star ",
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
          ],
        ),
      ),
      bottomNavigationBar: edit
          ? ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                var userid = prefs.getString('userid');
                if (edit) {
                  religioppudate(
                          religion: ref.watch(religionProvider).toString(),
                          cast: ref.watch(castProvider).toString(),
                          mangik: ref.watch(manglikProvider).toString(),
                          star: star.text)
                      .whenComplete(() {
                    setState(() {
                      getuserprofile(ref: ref, id: userid.toString());
                      ref.watch(editablefreligionpp.notifier).state = false;
                    });
                  });
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
}
