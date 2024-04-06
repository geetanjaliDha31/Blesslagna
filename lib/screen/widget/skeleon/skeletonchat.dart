import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonChatScreen extends StatelessWidget {
  const SkeletonChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (c, index) => SkeletonAnimation(
              child: Container(
                height: 80,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 30, backgroundColor: Colors.grey[300]),
                    SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 10, width: 80, color: Colors.grey[300]),
                        SizedBox(height: 5),
                        Container(height: 5, width: 40, color: Colors.grey[300])
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
