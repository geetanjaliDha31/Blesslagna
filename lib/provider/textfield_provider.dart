import 'package:blesslagna/color.dart';
import 'package:flutter/material.dart';

Widget textfield(
    {required String label,
    required String hinttext,
    // required TextEditingController controller,
    required TextInputType type}) {
  return TextFormField(
    //border
    keyboardType: type,
    // controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff9A9A9A)),
          borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

      //label
      floatingLabelStyle: TextStyle(
          color: textcolor, fontSize: 14, fontWeight: FontWeight.w400),
      label: Text(
        "$label ",
        style: TextStyle(
          fontSize: 14,
          color: textcolor,
        ),
      ),
      //hint text
      hintText: hinttext,
      hintStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
      //suffix
    ),
  );
}

Widget multitextfield({required String label, required String hinttext}) {
  return TextFormField(
    maxLines: 3,
    //border
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff9A9A9A)),
          borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

      //label
      floatingLabelStyle: TextStyle(
          color: textcolor, fontSize: 14, fontWeight: FontWeight.w400),
      label: Text(
        "$label ",
        style: TextStyle(
          fontSize: 14,
          color: textcolor,
        ),
      ),
      //hint text
      hintText: hinttext,
      hintStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
      //suffix
    ),
  );
}
