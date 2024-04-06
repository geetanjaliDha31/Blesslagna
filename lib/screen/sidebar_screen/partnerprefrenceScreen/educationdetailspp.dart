import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateperefrence_api/educatiopp.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/containermultiselect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationDetailsPP extends ConsumerStatefulWidget {
  const EducationDetailsPP({super.key});

  @override
  ConsumerState<EducationDetailsPP> createState() => _EducationDetailsPPState();
}

class _EducationDetailsPPState extends ConsumerState<EducationDetailsPP> {
  StateProvider editablefeducationpp = StateProvider((ref) => false);
  TextEditingController occupationpp = TextEditingController();

  StateProvider educationppProvider =
      StateProvider((ref) => 'Select Education');

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;

    final edit = ref.watch(editablefeducationpp);

    final userdetails = ref.watch(userdetailProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                ref.watch(editablefeducationpp.notifier).state = !edit;
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
                        ? "Select Education"
                        : userdetails.preferenceArray![0].eduPreferenceArray![0]
                                    .education
                                    .toString() ==
                                ""
                            ? "Select Education"
                            : userdetails.preferenceArray![0]
                                .eduPreferenceArray![0].education
                                .toString())
                : containermultiselect(
                    comfrom: "Select Education",
                    ref: ref,
                    context: context,
                    items: jobitems,
                    providername: educationppProvider,
                  ),
            SizedBox(height: 20),
            !edit
                ? defaultcontainer(
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Select Occupation"
                        : userdetails.preferenceArray![0].eduPreferenceArray![0]
                                    .occupation
                                    .toString() ==
                                ""
                            ? "Select Occupation"
                            : userdetails.preferenceArray![0]
                                .eduPreferenceArray![0].occupation
                                .toString())
                : TextFormField(
                    //border
                    controller: occupationpp,
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
                    text: userdetails.preferenceArray!.isEmpty
                        ? "Select Occupation"
                        : userdetails.preferenceArray![0].eduPreferenceArray![0]
                                    .annualincome
                                    .toString() ==
                                ""
                            ? "Select Occupation"
                            : userdetails.preferenceArray![0]
                                .eduPreferenceArray![0].annualincome
                                .toString())
                : containermultiselect(
                    comfrom: "Select Income",
                    ref: ref,
                    context: context,
                    items: incomeitems,
                    providername: incomeProvider,
                  ),
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
                  eductionppupdate(
                          eduction: ref.watch(educationppProvider).toString(),
                          occupation: occupationpp.text,
                          annualincome: ref.watch(incomeProvider).toString())
                      .whenComplete(() {
                    setState(() {
                      getuserprofile(ref: ref, id: userid.toString());
                      ref.watch(editablefeducationpp.notifier).state = false;
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
