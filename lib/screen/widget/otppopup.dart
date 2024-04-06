import 'package:blesslagna/API/login_api/login.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

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

                //     Navigator.push(
                // context,
                // PageTransition(
                //     duration: const Duration(milliseconds: 200),
                //     type: PageTransitionType.fade,
                //     child: const DetailsScreen(comfrom: "home",)))

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
