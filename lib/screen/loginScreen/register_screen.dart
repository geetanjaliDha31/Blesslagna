import 'dart:developer';
import 'package:blesslagna/API/login_api/login.dart';
import 'package:blesslagna/Firebase_service/firebase_service.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/showloader.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:blesslagna/screen/loginScreen/login_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

final List category = ["Select Gender", "Male", "Female", "TransGender"];
String? categorytype = "Select Gender";

final List mariedstatus = [
  "Marital Status",
  "Never Married",
  "Divorced",
  "Window",
];

StateProvider useremailProvider = StateProvider((ref) => '');
StateProvider userphonenoProvider = StateProvider((ref) => '');
StateProvider obsureProvider2 = StateProvider((ref) => true);
StateProvider obsureProvider3 = StateProvider((ref) => true);

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey<FormState> _emailInputBoxKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _location = TextEditingController();

  StateProvider check = StateProvider((ref) => false);

  String validateEmail(String? value) {
    // const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
    //     r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
    //     r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
    //     r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
    //     r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
    //     r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
    //     r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    const pattern = r'\S+@\S+\.\S+';
    final regex = RegExp(pattern);
    if (value!.isEmpty) {
      return "Please Enter Email";
    } else if (value.isNotEmpty && !regex.hasMatch(value)) {
      return "Please Enter a Valid Email";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final casttype = ref.watch(castProvider);
    final religontype = ref.watch(religionProvider);
    final mariedtype = ref.watch(martitalstatusProvider);
    final obsure2 = ref.watch(obsureProvider2);
    final obsure3 = ref.watch(obsureProvider3);
    final dob = ref.watch(selectdateProvider);

    return Scaffold(
      // drawer: sidebar(context: context,ref: ref),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Column(
              children: [
                Text(
                  "Let’s  Get Started",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Text(
                  "Create your Account",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: grident),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Register',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff222222)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              //border
              keyboardType: TextInputType.text,
              controller: _name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

                //label
                floatingLabelStyle: TextStyle(
                    color: textcolor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                label: Text(
                  "Name ",
                  style: TextStyle(
                    fontSize: 14,
                    color: textcolor,
                  ),
                ),
                //hint text
                hintText: 'Var / Vadhu Name',
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: lighttext),
                //suffix
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                DropdownButtonHideUnderline(
                  child: Container(
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
                      items: category
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
                      value: categorytype,
                      onChanged: (value) {
                        setState(() {
                          categorytype = value as String;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                DropdownButtonHideUnderline(
                  child: Container(
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
                      value: mariedtype,
                      onChanged: (value) {
                        ref.watch(martitalstatusProvider.notifier).state =
                            value;
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              //border
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              keyboardType: TextInputType.number,
              controller: _mobile,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

                //label
                floatingLabelStyle: TextStyle(
                    color: textcolor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                label: Text(
                  "Phone No. ",
                  style: TextStyle(
                    fontSize: 14,
                    color: textcolor,
                  ),
                ),
                //hint text
                hintText: 'Phone no.',
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: lighttext),
                //suffix
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _emailInputBoxKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                //border
                onChanged: (value) {
                  _emailInputBoxKey.currentState?.validate();
                  if (value.isNotEmpty) {
                    ref.watch(check.notifier).state = true;
                  } else {
                    ref.watch(check.notifier).state = false;
                  }
                },
                validator: validateEmail,
                keyboardType: TextInputType.text,
                controller: _email,
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
                    "Email ",
                    style: TextStyle(
                      fontSize: 14,
                      color: textcolor,
                    ),
                  ),
                  //hint text
                  hintText: 'Email Address',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: lighttext),
                  //suffix
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              //border
              obscureText: obsure2,
              controller: _password,
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
                    "Password  ",
                    style: TextStyle(
                      fontSize: 14,
                      color: textcolor,
                    ),
                  ),
                  //hint text
                  hintText: 'Enter Your Password',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: lighttext),
                  //suffix
                  suffixIcon: InkWell(
                      onTap: () => ref.watch(obsureProvider2.notifier).state =
                          obsure2 ? false : true,
                      child: obsure2
                          ? const Icon(CupertinoIcons.eye)
                          : const Icon(CupertinoIcons.eye_slash_fill))),
            ),
            const SizedBox(height: 20),
            TextFormField(
              //border
              obscureText: obsure3,
              controller: _confirmpassword,
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
                    "Confirm Password  ",
                    style: TextStyle(
                      fontSize: 14,
                      color: textcolor,
                    ),
                  ),
                  //hint text
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: lighttext),
                  //suffix
                  suffixIcon: InkWell(
                      onTap: () => ref.watch(obsureProvider3.notifier).state =
                          obsure3 ? false : true,
                      child: obsure3
                          ? const Icon(CupertinoIcons.eye)
                          : const Icon(CupertinoIcons.eye_slash_fill))),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 70,
                  width: width / 2.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff9A9A9A)),
                      borderRadius: BorderRadius.circular(8)),
                  child: SearchChoices.single(
                    items: religioitems
                        .map((item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    value: religontype,
                    hint: "Select Religion",

                    searchHint: "Search for Religion",
                    onChanged: (newValue) {
                      ref.watch(religionProvider.notifier).state = newValue;
                    },
                    isExpanded: true,
                    displayClearIcon: false, // Whether to display a clear icon
                    underline: Container(), // To remove underline
                    searchInputDecoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                // DropdownButtonHideUnderline(
                //   child: Container(
                //     width: width / 2.3,
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
                //       items: religioitems
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
                //       value: religontype,
                //       onChanged: (value) {
                //         ref.watch(religionProvider.notifier).state = value;
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(width: 18),
                Container(
                  height: 70,
                  width: width / 2.4,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff9A9A9A)),
                      borderRadius: BorderRadius.circular(8)),
                  child: SearchChoices.single(
                    items: castitems
                        .map((item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    value: casttype,
                    hint: "Select Cast",
                    searchHint: "Search for Cast",
                    onChanged: (newValue) {
                      setState(() {
                        log(newValue as String);
                        ref.watch(castProvider.notifier).state = newValue;
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
                //   child: Container(
                //     width: width / 2.3,
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
                //       items: castitems
                //           .map((item) => DropdownMenuItem(
                //                 value: item,
                //                 child: Text(
                //                   item.toString(),
                //                   style: const TextStyle(
                //                     color: Colors.black,
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w400,
                //                   ),
                //                 ),
                //               ))
                //           .toList(),

                //       value: casttype,

                //       onChanged: (value) {
                //         setState(() {
                //           log(value as String);
                //           ref.watch(castProvider.notifier).state = value;
                //         });
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                await _selectDate(context, ref).whenComplete(() {
                  setState(() {});
                });
              },
              child: Container(
                width: width,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        dob != "" ? dob.toString() : "Date of Birth",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.calendar_month,
                        color: Color(0xff9A9A9A),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              //border
              keyboardType: TextInputType.text,
              controller: _location,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

                //label
                floatingLabelStyle: TextStyle(
                    color: textcolor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                label: Text(
                  "Location ",
                  style: TextStyle(
                    fontSize: 14,
                    color: textcolor,
                  ),
                ),
                //hint text
                hintText: 'Mumbai',
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: lighttext),
                //suffix
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                  onPressed: () {
                    registerbutoonfun(
                        ref: ref,
                        name: _name.text,
                        email: _email.text,
                        gender: categorytype.toString(),
                        mstatus: mariedtype.toString(),
                        location: _location.text,
                        religion: religontype.toString(),
                        cast: casttype.toString(),
                        dob: dob,
                        password: _password.text,
                        confirmpassword: _confirmpassword.text,
                        mobile: _mobile.text);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: primary,
                      minimumSize: Size(width, 50)),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  )),
            ),
          ],
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
          ref.watch(selectdateProvider.notifier).state = '';
        });

        toast("You Are Not !8+");
      }
    }
  }

  registerbutoonfun(
      {required String name,
      required String email,
      required String gender,
      required String mstatus,
      required String location,
      required String religion,
      required String cast,
      required String dob,
      required String password,
      required String confirmpassword,
      required String mobile,
      required WidgetRef ref}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          processingPopup(context: context, msg: "Creating...."),
    );
    if (validateEmail(email) == "") {
      ref.watch(useremailProvider.notifier).state = email;
      ref.watch(userphonenoProvider.notifier).state = mobile;
      if (ref.watch(selectdateProvider).toString() != '') {
        if (mobile.length == 10) {
          if (name.isNotEmpty && location.isNotEmpty) {
            if (password.isNotEmpty && confirmpassword.isNotEmpty) {
              if (password == confirmpassword) {
                if (password.length >= 6) {
                  FirbaseService()
                      .singUpWithEmailAndPassword(
                          email: email,
                          password: password,
                          userid: "",
                          context: context)
                      .then((value) async {
                    log(value.toString());
                    if (value!.isNotEmpty) {
                      ref.watch(usernameProvider.notifier).state = name;
                      ref.watch(selectdateProvider.notifier).state = dob;
                      ref.watch(religionProvider.notifier).state = religion;
                      ref.watch(castProvider.notifier).state = cast;
                      ref.watch(phonenoProvider.notifier).state = mobile;
                      await Login()
                          .registration(
                              username: name,
                              gender: gender,
                              useremail: email,
                              maritalstatus: mstatus,
                              userlocation: location,
                              usereligion: religion,
                              userdob: dob,
                              cast: cast,
                              password: password,
                              confirmpassword: confirmpassword,
                              firbaseid: value.toString(),
                              usermobile: mobile)
                          .then((value) {
                        Navigator.pop(context);
                        if (!value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StepperScreen()));
                        }
                      });
                    } else {
                      Navigator.pop(context);
                      toast('Your Email Id Already Use');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => true);
                    }
                  });
                } else {
                  toast('Password Must Be atleast 6 Carcter');
                  Navigator.pop(context);
                }
              } else {
                toast('Password Not Match');
                Navigator.pop(context);
              }
            } else {
              toast('Please Enter Password');
              Navigator.pop(context);
            }
          } else {
            toast('Name & Location Are Requried');
            Navigator.pop(context);
          }
        } else {
          print(mobile.length);
          toast('Enter 10 Digit Mobile No.');
          Navigator.pop(context);
        }
      } else {
        toast("You Are Not !8+");
        Navigator.pop(context);
      }
    } else {
      toast('Enter Valid Email');
      Navigator.pop(context);
    }
  }
}
