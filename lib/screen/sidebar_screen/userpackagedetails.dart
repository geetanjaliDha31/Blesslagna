import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/bottomnavigationscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPackageDetails extends ConsumerWidget {
  const UserPackageDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userdetails = ref.watch(userdetailProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigationScreen()),
              (route) => false),
          child: Icon(
            Icons.arrow_back_ios,
            color: primary,
            size: 20,
          ),
        ),
        title: Text(
          'Your Package',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
              text: 'Package Name ',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xD9131313)),
              children: <TextSpan>[
                TextSpan(
                    text: userdetails.packageDetailsArray![0].packName,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'Total Interest ',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xD9131313)),
              children: <TextSpan>[
                TextSpan(
                    text: userdetails.packageDetailsArray![0].totalInterest,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'Total chat  ',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xD9131313)),
              children: <TextSpan>[
                TextSpan(
                    text: userdetails.packageDetailsArray![0].totalChat,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'Total Contact ',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xD9131313)),
              children: <TextSpan>[
                TextSpan(
                    text: userdetails.packageDetailsArray![0].totalContact,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'Package Expiry ',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xD9131313)),
              children: <TextSpan>[
                TextSpan(
                    text: userdetails.packageDetailsArray![0].packageExpiry,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
