import 'package:blesslagna/API/login_api/login.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class ChangeEmail extends ConsumerStatefulWidget {
  const ChangeEmail({super.key});

  @override
  ConsumerState<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends ConsumerState<ChangeEmail> {
  final GlobalKey<FormState> _emailInputBoxKey = GlobalKey<FormState>();
  final TextEditingController _emailforgot = TextEditingController();
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Your Email',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w400, color: primary)),
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
            ElevatedButton(
                onPressed: () {
                  validateEmail(_emailforgot.text) == ''
                      ? Login()
                          .forgotpassword(email: _emailforgot.text)
                          .then((value) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => OTPpopup(
                                    email: _emailforgot.text,
                                  ));
                        })
                      : toast('Enter Valid Email');
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: primary,
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                child: const Text(
                  "Send OTP",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ))
          ],
        ),
      ),
    );
  }
}

class OTPpopup extends ConsumerStatefulWidget {
  final String email;
  const OTPpopup({super.key, required this.email});

  @override
  ConsumerState<OTPpopup> createState() => _OTPpopupState();
}

class _OTPpopupState extends ConsumerState<OTPpopup> {
  final TextEditingController _smscode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 55,
        height: 50,
        textStyle: TextStyle(fontSize: 14, color: primary),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey),
        ));

    final focusedPinTheme = defaultPinTheme.copyWith(
        textStyle: TextStyle(fontSize: 16, color: primary),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ));

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: TextStyle(fontSize: 14, color: primary),
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: primary),
      ),
    );
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Enter OTP",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              const Text("Verification Code",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'OTP has been sent to ${widget.email} ',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff030201)),
                    children: const <TextSpan>[],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Pinput(
                // senderPhoneNumber: phoneNum,
                autofocus: false,
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                length: 4,
                controller: _smscode,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Login()
                      .verifyotp(email: widget.email, otp: _smscode.text)
                      .then((value) {
                    ref.watch(otpverifyProvider.notifier).state = true;
                    Navigator.pop(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(width, 50),
                    backgroundColor: primary),
                child: const Text(
                  "Verify OTP ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
