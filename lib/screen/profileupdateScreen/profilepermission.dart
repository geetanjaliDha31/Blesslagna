import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateuserdata/updateuser.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ProfilPermission extends ConsumerStatefulWidget {
  const ProfilPermission({super.key});

  @override
  ConsumerState<ProfilPermission> createState() => _ProfilPermissionState();
}

class _ProfilPermissionState extends ConsumerState<ProfilPermission> {
  bool photopermission = false;
  bool phonepermission = false;
  bool emailpermission = false;

  @override
  Widget build(BuildContext context) {
    final userdetails = ref.read(userdetailProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Give Photo Permission",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              FlutterSwitch(
                value: userdetails.basicDetailsArray![0].picVisibilibity!,
                padding: 0,
                height: 24,
                width: 40,
                activeColor: Color(
                  0x996a8caf,
                ),
                activeToggleColor: primary,
                inactiveColor: Colors.grey,
                onToggle: ((value) {
                  if (value) {
                    setState(() {
                      photopermission = value;
                    });
                  } else {
                    setState(() {
                      photopermission =
                          userdetails.basicDetailsArray![0].picVisibilibity!;
                    });
                  }
                  UpdateUser()
                      .givepermission(
                          photopermission: value.toString(),
                          phonepermission: userdetails
                              .basicDetailsArray![0].contactVisibilibity!
                              .toString(),
                          emailpermission: userdetails
                              .basicDetailsArray![0].emailVisibilibity!
                              .toString())
                      .whenComplete(() async {
                    setState(
                      () async {
                        await getuserprofile(
                            ref: ref,
                            id: userdetails.basicDetailsArray![0].matrimonialId
                                .toString());
                      },
                    );
                  });
                }),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Give Mobile Number Permission",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              FlutterSwitch(
                value: userdetails.basicDetailsArray![0].contactVisibilibity!,
                padding: 0,
                height: 24,
                width: 40,
                activeColor: Color(
                  0x996a8caf,
                ),
                activeToggleColor: primary,
                inactiveColor: Colors.grey,
                onToggle: ((value) {
                  if (value) {
                    setState(() {
                      phonepermission = value;
                    });
                  } else {
                    setState(() {
                      phonepermission = value;
                    });
                  }
                  UpdateUser()
                      .givepermission(
                          photopermission: userdetails
                              .basicDetailsArray![0].contactVisibilibity!
                              .toString(),
                          phonepermission: value.toString(),
                          emailpermission: userdetails
                              .basicDetailsArray![0].emailVisibilibity!
                              .toString())
                      .whenComplete(() async {
                    setState(
                      () async {
                        await getuserprofile(
                            ref: ref,
                            id: userdetails.basicDetailsArray![0].matrimonialId
                                .toString());
                      },
                    );
                  });
                }),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Give Email Permission",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              FlutterSwitch(
                value: userdetails.basicDetailsArray![0].emailVisibilibity!,
                padding: 0,
                height: 24,
                width: 40,
                activeColor: Color(
                  0x996a8caf,
                ),
                activeToggleColor: primary,
                inactiveColor: Colors.grey,
                onToggle: ((value) {
                  if (value) {
                    setState(() {
                      emailpermission = value;
                    });
                  } else {
                    setState(() {
                      emailpermission = value;
                    });
                  }
                  UpdateUser()
                      .givepermission(
                          photopermission: userdetails
                              .basicDetailsArray![0].picVisibilibity!
                              .toString(),
                          phonepermission: userdetails
                              .basicDetailsArray![0].contactVisibilibity!
                              .toString(),
                          emailpermission: value.toString())
                      .whenComplete(() async {
                    setState(
                      () async {
                        await getuserprofile(
                            ref: ref,
                            id: userdetails.basicDetailsArray![0].matrimonialId
                                .toString());
                      },
                    );
                  });
                }),
              )
            ],
          ),
        ]),
      ),
      // bottomNavigationBar: ElevatedButton(
      //     onPressed: () {
      //       final userdetail = ref.watch(userdetailProvider);
      //       UpdateUser()
      //           .givepermission(
      //               photopermission: phonepermission.toString(),
      //               phonepermission: phonepermission.toString(),
      //               emailpermission: emailpermission.toString())
      //           .whenComplete(() async {
      //         setState(
      //           () async {
      //             await getuserprofile(
      //                 ref: ref,
      //                 id: userdetail.basicDetailsArray![0].matrimonialId
      //                     .toString());
      //           },
      //         );
      //       });
      //     },
      //     style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(8)),
      //         backgroundColor: primary,
      //         minimumSize: Size(MediaQuery.of(context).size.width, 50)),
      //     child: Text(
      //       "Submit",
      //       style: TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.w400,
      //           fontSize: 14),
      //     ))
    );
  }
}
