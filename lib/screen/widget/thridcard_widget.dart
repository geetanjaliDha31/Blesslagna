import 'package:blesslagna/API/home_api/gethome.dart';
import 'package:flutter/material.dart';

class ThridCard extends StatelessWidget {
  final SuccessStories data;
  const ThridCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: width,
        height: 200,
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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.title.toString(),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SizedBox(
                    width: width / 2.06,
                    child: Text(
                      data.description.toString(),
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.1,
                        color: Color(0xcc000000),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/intro.jpg'),
              backgroundColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
