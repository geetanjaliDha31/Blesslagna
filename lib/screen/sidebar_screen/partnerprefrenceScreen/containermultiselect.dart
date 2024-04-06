import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/ppmultiselect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget containermultiselect(
    {required String comfrom,
    required WidgetRef ref,
    required BuildContext context,
    required List items,
    required final StateProvider<dynamic> providername}) {
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PPMultiselect(items: items, providername: providername);
        },
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          ref.watch(providername).toString() == ""
              ? comfrom
              : ref.watch(providername).toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    ),
  );
}
