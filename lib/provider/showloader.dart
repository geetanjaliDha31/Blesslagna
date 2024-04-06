import 'package:blesslagna/color.dart';
import 'package:flutter/material.dart';

showloader({required BuildContext context}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          Center(child: CircularProgressIndicator()));
}

Widget processingPopup({required context, required msg}) => AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(msg,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500, color: primary)),
          ],
        ),
      ),
    );
