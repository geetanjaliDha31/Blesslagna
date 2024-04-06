import 'package:blesslagna/API/login_api/login.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/loginScreen/login_screen.dart';
import 'package:blesslagna/screen/widget/otppopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

StateProvider obsureProvider4 = StateProvider((ref) => true);
StateProvider obsureProvider5 = StateProvider((ref) => true);

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final TextEditingController _emailforgot = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final GlobalKey<FormState> _emailInputBoxKey = GlobalKey<FormState>();
  StateProvider check2 = StateProvider((ref) => false);
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
    final obsure4 = ref.watch(obsureProvider4);
    final obsure5 = ref.watch(obsureProvider5);
    final verifyotp = ref.watch(otpverifyProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter Your Email',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: primary)),
              SizedBox(height: 20),
              Form(
                key: _emailInputBoxKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  //border

                  onChanged: (value) {
                    _emailInputBoxKey.currentState?.validate();
                    if (value.isNotEmpty) {
                      ref.watch(check2.notifier).state = true;
                    } else {
                      ref.watch(check2.notifier).state = false;
                    }
                  },
                  validator: validateEmail,
                  keyboardType: TextInputType.text,
                  controller: _emailforgot,
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
              SizedBox(height: 20),
              !verifyotp
                  ? ElevatedButton(
                      onPressed: () {
                        validateEmail(_emailforgot.text) == ''
                            ? Login()
                                .forgotpassword(email: _emailforgot.text)
                                .then((value) {
                                if (!value) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          OTPpopup(
                                            email: _emailforgot.text,
                                          ));
                                }
                              })
                            : toast('Enter Valid Email');
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: primary,
                          minimumSize: Size(width, 50)),
                      child: const Text(
                        "Send OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ))
                  : Divider(
                      thickness: 0.5,
                    ),
              verifyotp
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          //border
                          obscureText: obsure4,
                          controller: _password,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff9A9A9A)),
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
                                  onTap: () => ref
                                      .watch(obsureProvider4.notifier)
                                      .state = obsure4 ? false : true,
                                  child: obsure4
                                      ? const Icon(CupertinoIcons.eye)
                                      : const Icon(
                                          CupertinoIcons.eye_slash_fill))),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          //border
                          obscureText: obsure5,
                          controller: _confirmpassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xff9A9A9A)),
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
                                  onTap: () => ref
                                      .watch(obsureProvider5.notifier)
                                      .state = obsure5 ? false : true,
                                  child: obsure5
                                      ? const Icon(CupertinoIcons.eye)
                                      : const Icon(
                                          CupertinoIcons.eye_slash_fill))),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              if (_password.text.isNotEmpty &&
                                  _confirmpassword.text.isNotEmpty) {
                                if (_password.text == _confirmpassword.text) {
                                  Login()
                                      .mainforgotpassword(
                                          email: _emailforgot.text,
                                          pass: _password.text,
                                          confirmpass: _confirmpassword.text)
                                      .then((value) =>
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()),
                                              (route) => false));
                                } else {
                                  toast(
                                      'Password and Confirm Password Not Match');
                                }
                              } else {
                                toast('Enter Password');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: primary,
                                minimumSize: Size(width, 50)),
                            child: const Text(
                              "Change Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ))
                      ],
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
