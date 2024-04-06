// import 'package:blesslagna/color.dart';
import 'package:blesslagna/API/profile_api/contactviewapi.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:accordion/accordion.dart';

class BasicDetails extends ConsumerStatefulWidget {
  final String id;
  const BasicDetails({super.key, required this.id});

  @override
  ConsumerState<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends ConsumerState<BasicDetails> {
  String showphone = '';
  @override
  void initState() {
    setState(() {
      showphone = '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final data = ref.watch(recipteuSerProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: Color(
                0x3f000000,
              ), //New
              blurRadius: 1.0,
              offset: Offset(0, 0))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Phone No.',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                contactview(recipientid: widget.id).then((value) {
                  setState(() {
                    showphone = value;
                  });
                });
              },
              child: SizedBox(
                width: SizeConfig.screenWidth! / 2.9,
                child: Text(
                  showphone == ''
                      ? data.basicDetailsArray![0].phoneno.toString()
                      : showphone,
                  style: TextStyle(
                      height: 2,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Height',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].height.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Weight',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].weight.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Age',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].age.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Hobbies',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].hobbies.toString()}',
                style: TextStyle(
                    overflow: TextOverflow.clip,
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Martial Status',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].maritalStatus.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Birth Place',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].birthplace.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Birth Time',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].birthtime.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Mother Tongue',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].motherTongue.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Language Known',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.basicDetailsArray![0].language.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class Religion extends ConsumerWidget {
  const Religion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(recipteuSerProvider);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  color: Color(
                    0x3f000000,
                  ), //New
                  blurRadius: 1.0,
                  offset: Offset(0, 0))
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Religion',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.religiousArray![0].religion.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Cast',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.religiousArray![0].caste.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Subcast',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.religiousArray![0].subcaste.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Manglik ',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.religiousArray![0].manglik.toString()}',
                    style: TextStyle(
                        overflow: TextOverflow.clip,
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'MoonSign',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.religiousArray![0].moonsign.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Star ',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.religiousArray![0].star.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'HoroScope ',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.religiousArray![0].horoscope.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Gotra ',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.religiousArray![0].gotra.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}

class Education extends ConsumerWidget {
  const Education({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(recipteuSerProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: Color(
                0x3f000000,
              ), //New
              blurRadius: 1.0,
              offset: Offset(0, 0))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Education',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.eduOccupationArray![0].education.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Employee on',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.eduOccupationArray![0].employeeIn.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Annual Income',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.eduOccupationArray![0].annualIncome.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Occupation',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.eduOccupationArray![0].occupation.toString()}',
                style: TextStyle(
                    overflow: TextOverflow.clip,
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Designation',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.eduOccupationArray![0].designation.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class LifeStyle extends ConsumerWidget {
  const LifeStyle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(recipteuSerProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: Color(
                0x3f000000,
              ), //New
              blurRadius: 1.0,
              offset: Offset(0, 0))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Body Type',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.lifestyleDetailsArray![0].bodyType.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Skin Tone',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.lifestyleDetailsArray![0].skinTone.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Blood Group',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.lifestyleDetailsArray![0].bloodGroup.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Eating Habbit',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.lifestyleDetailsArray![0].eatingHabbit.toString()}',
                style: TextStyle(
                    overflow: TextOverflow.clip,
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Smoking Habbit',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.lifestyleDetailsArray![0].smokingHabbit.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Drinking Habbit',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.lifestyleDetailsArray![0].drinkingHabbit.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class Location extends ConsumerWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(recipteuSerProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: Color(
                0x3f000000,
              ), //New
              blurRadius: 1.0,
              offset: Offset(0, 0))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Country',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.locationDetailsArray![0].country.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'State',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.locationDetailsArray![0].state.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'City',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.locationDetailsArray![0].city.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Address',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.locationDetailsArray![0].address.toString()}',
                style: TextStyle(
                    overflow: TextOverflow.clip,
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Phone',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.locationDetailsArray![0].phone.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Time To Call',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.locationDetailsArray![0].timeToCall.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                'Residence',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            ),
            Spacer(),
            SizedBox(
              width: SizeConfig.screenWidth! / 2.9,
              child: Text(
                ': ${data.locationDetailsArray![0].residence.toString()}',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class Familyexpansion extends ConsumerWidget {
  const Familyexpansion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(recipteuSerProvider);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  color: Color(
                    0x3f000000,
                  ), //New
                  blurRadius: 1.0,
                  offset: Offset(0, 0))
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Familty Type',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].familyType.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Father Name',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].fathersName.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Father Occupation',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].fathersOccupation.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Mother Name ',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].mothersName.toString()}',
                    style: TextStyle(
                        overflow: TextOverflow.clip,
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'Mother Occupation',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].mothersOccupation.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'No of Brother',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].noOfBrothers.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'No of Sister',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].noOfSisters.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'No of Married Brother',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].noOfMarriedBrothers.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'No of Married Sister',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].noOfMarriedSisters.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    'About Family',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: SizeConfig.screenWidth! / 2.9,
                  child: Text(
                    ': ${data.familyDetailsArray![0].aboutFamily.toString()}',
                    style: TextStyle(
                        height: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
              ],
            ),
          ]),
        )
      ],
    );
  }
}

class Partnerprefrenceexpansion extends ConsumerWidget {
  const Partnerprefrenceexpansion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(recipteuSerProvider);
    return Column(
      children: [
        Accordion(
          headerBackgroundColor: Colors.white,
          headerPadding: EdgeInsets.symmetric(
            vertical: 6,
          ),
          headerBorderColorOpened: primary,
          headerBorderColor: primary,
          paddingListHorizontal: 0,
          contentHorizontalPadding: 1,
          contentBorderColor: Colors.transparent,
          headerBorderRadius: 5,
          rightIcon: SizedBox(),
          children: [
            AccordionSection(
              header: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(
                          0x3f000000,
                        ), //New
                        blurRadius: 1.0,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Basic Preference',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: primary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(
                          0x3f000000,
                        ), //New
                        blurRadius: 1.0,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Looking For',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].lookingFor.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'From Age',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].fromAge.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'To Age',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].toAge.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'From Height',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].fromHeight.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'To Height',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].toheight.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Skin Type',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].skintype.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.5,
                          child: Text(
                            'General Expection',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].generalExpt.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Mother Tounge',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].mothertounge.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Eating Habbit',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].eatingHabit.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Drinking Habbit',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].basicPreferenceArray![0].drinkingHabit.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AccordionSection(
              header: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(
                          0x3f000000,
                        ), //New
                        blurRadius: 1.0,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Religious Preference',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: primary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(
                          0x3f000000,
                        ), //New
                        blurRadius: 1.0,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Religon',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].religiousPreferenceArray![0].religon.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Cast',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].religiousPreferenceArray![0].caste.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Manglik',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].religiousPreferenceArray![0].manglik.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Star',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].religiousPreferenceArray![0].star.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AccordionSection(
              header: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(
                          0x3f000000,
                        ), //New
                        blurRadius: 1.0,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Education Preference',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: primary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(
                        0x3f000000,
                      ), //New
                      blurRadius: 1.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Education',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].eduPreferenceArray![0].education.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Occupation',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].eduPreferenceArray![0].occupation.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Income',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].eduPreferenceArray![0].income.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AccordionSection(
              header: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(
                          0x3f000000,
                        ), //New
                        blurRadius: 1.0,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Location Preference',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: primary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              content: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(
                        0x3f000000,
                      ), //New
                      blurRadius: 1.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Country',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].locationPreferenceArray![0].country.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'State',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].locationPreferenceArray![0].state.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'City',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].locationPreferenceArray![0].city.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            'Residence',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: SizeConfig.screenWidth! / 2.9,
                          child: Text(
                            ': ${data.preferenceArray![0].locationPreferenceArray![0].residence.toString()}',
                            style: TextStyle(
                                height: 2,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height:20),
      ],
    );
  }
}
