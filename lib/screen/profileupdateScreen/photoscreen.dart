import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateuserdata/updateuser.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/showloader.dart';
import 'package:blesslagna/provider/sizedconflig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoScreen extends ConsumerStatefulWidget {
  const PhotoScreen({super.key});

  @override
  ConsumerState<PhotoScreen> createState() => _PhotoScreenState();
}

final imageListProvider1 = StateProvider((ref) => '');
final imageListProvider2 = StateProvider((ref) => '');
final imageListProvider3 = StateProvider((ref) => '');
final imageListProvider4 = StateProvider((ref) => '');
String base64image = "";

StateProvider editablephoto = StateProvider((ref) => false);
Future<dynamic> takeImages(
    {required WidgetRef ref,
    required int index,
    required ImageSource sourceofpick}) async {
  try {
    final XFile? image = await ImagePicker().pickImage(
      source: sourceofpick,
      imageQuality: 40,
    );
    Uint8List imagebytes = await image!.readAsBytes();
    log(index.toString());
    base64image = base64.encode(imagebytes);
    if (index == 1) {
      log('come1');
      ref.watch(imageListProvider1.notifier).state = base64image;
    } else if (index == 2) {
      log('come2');
      ref.watch(imageListProvider2.notifier).state = base64image;
    } else if (index == 3) {
      log('come3');
      ref.watch(imageListProvider3.notifier).state = base64image;
    } else {
      log('come4');
      ref.watch(imageListProvider4.notifier).state = base64image;
    }
  } catch (e) {
    log(e.toString());
  }
}

class _PhotoScreenState extends ConsumerState<PhotoScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final userdetails = ref.watch(userdetailProvider);
    final image1 = ref.watch(imageListProvider1);
    final image2 = ref.watch(imageListProvider2);
    final image3 = ref.watch(imageListProvider3);
    final image4 = ref.watch(imageListProvider4);
    double width = MediaQuery.of(context).size.width;
    final edit = ref.watch(editablephoto);

    // log("image1:${userdetails.basicDetailsArray![0].image1.toString()}");
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref.watch(editablephoto.notifier).state = !edit;
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, top: 14),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: edit
                          ? SvgPicture.asset('assets/cross.svg')
                          : SvgPicture.asset('assets/edit.svg')),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.count(crossAxisCount: 2, children: [
                    InkWell(
                      onTap: () {
                        if (userdetails.basicDetailsArray![0].image == "") {
                          toast('Photo not uploaded');
                        } else {
                          ref.watch(editablephoto.notifier).state = !edit;
                          setState(() {});

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.width *
                                      0.8, // Square popup
                                  child: Image.network(
                                    userdetails.basicDetailsArray![0].image
                                        .toString(),
                                    fit: BoxFit
                                        .contain, // Fit the image inside the square popup
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical! * 2,
                        width: SizeConfig.blockSizeHorizontal! * 2,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            image: image1 == ""
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      userdetails.basicDetailsArray![0].image
                                          .toString(),
                                    ))
                                : DecorationImage(
                                    image: MemoryImage(
                                      base64Decode(image1),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (userdetails.basicDetailsArray![0].photo2 == "") {
                          toast('Photo not uploaded');
                        } else {
                          ref.watch(editablephoto.notifier).state = !edit;
                          setState(() {});

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.width *
                                      0.8, // Square popup
                                  child: Image.network(
                                    userdetails.basicDetailsArray![0].photo2
                                        .toString(),
                                    fit: BoxFit
                                        .contain, // Fit the image inside the square popup
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical! * 2,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            image: image2 != ""
                                ? DecorationImage(
                                    image: MemoryImage(
                                      base64Decode(image2),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : userdetails.basicDetailsArray![0].photo2
                                            .toString() !=
                                        ""
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          userdetails
                                              .basicDetailsArray![0].photo2
                                              .toString(),
                                        ))
                                    : null,
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12)),
                        child: image2 != ""
                            ? Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        UpdateUser()
                                            .deletephoto(index: "1", ref: ref);
                                        ref
                                            .watch(imageListProvider2.notifier)
                                            .state = "";
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 24,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : userdetails.basicDetailsArray![0].photo2 == ""
                                ? IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_library),
                                                title:
                                                    Text('Upload from Gallery'),
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        processingPopup(
                                                            context: context,
                                                            msg:
                                                                "Uploading..."),
                                                  );
                                                  takeImages(
                                                          ref: ref,
                                                          index: 2,
                                                          sourceofpick:
                                                              ImageSource
                                                                  .gallery)
                                                      .whenComplete(
                                                          () => setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.camera_alt),
                                                title:
                                                    Text('Upload from Camera'),
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        processingPopup(
                                                            context: context,
                                                            msg:
                                                                "Uploading..."),
                                                  );
                                                  takeImages(
                                                          ref: ref,
                                                          index: 2,
                                                          sourceofpick:
                                                              ImageSource
                                                                  .camera)
                                                      .whenComplete(
                                                          () => setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            UpdateUser().deletephoto(
                                                index: "1", ref: ref);
                                          });
                                        }),
                                  ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (userdetails.basicDetailsArray![0].photo3 == "") {
                          toast('Photo not uploaded');
                        } else {
                          ref.watch(editablephoto.notifier).state = !edit;
                          setState(() {});

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.width *
                                      0.8, // Square popup
                                  child: Image.network(
                                    userdetails.basicDetailsArray![0].photo3
                                        .toString(),
                                    fit: BoxFit
                                        .contain, // Fit the image inside the square popup
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical! * 2,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            image: image3 != ""
                                ? DecorationImage(
                                    image: MemoryImage(
                                      base64Decode(image3),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : userdetails.basicDetailsArray![0].photo3
                                            .toString() !=
                                        ""
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          userdetails
                                              .basicDetailsArray![0].photo3
                                              .toString(),
                                        ))
                                    : null,
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12)),
                        child: image3 != ""
                            ? Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          UpdateUser().deletephoto(
                                              index: "2", ref: ref);
                                        });
                                        ref
                                            .watch(imageListProvider3.notifier)
                                            .state = "";
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 24,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                  // userdetails.basicDetailsArray![0].image3 != ""
                                  //     ? Positioned(
                                  //         top: 5,
                                  //         left: 5,
                                  //         child: IconButton(
                                  //             icon: Icon(
                                  //               Icons.delete,
                                  //               color: Colors.red,
                                  //             ),
                                  //             onPressed: () {
                                  //               setState(() {
                                  //                 UpdateUser().deletephoto(
                                  //                     index: "2", ref: ref);
                                  //               });
                                  //             }),
                                  //       )
                                  //     : SizedBox.shrink()
                                ],
                              )
                            : userdetails.basicDetailsArray![0].photo3 == ""
                                ? IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_library),
                                                title:
                                                    Text('Upload from Gallery'),
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        processingPopup(
                                                            context: context,
                                                            msg:
                                                                "Uploading..."),
                                                  );
                                                  takeImages(
                                                          ref: ref,
                                                          index: 3,
                                                          sourceofpick:
                                                              ImageSource
                                                                  .gallery)
                                                      .whenComplete(
                                                          () => setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.camera_alt),
                                                title:
                                                    Text('Upload from Camera'),
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        processingPopup(
                                                            context: context,
                                                            msg:
                                                                "Uploading..."),
                                                  );
                                                  takeImages(
                                                          ref: ref,
                                                          index: 3,
                                                          sourceofpick:
                                                              ImageSource
                                                                  .camera)
                                                      .whenComplete(
                                                          () => setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            UpdateUser().deletephoto(
                                                index: "2", ref: ref);
                                          });
                                        }),
                                  ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (userdetails.basicDetailsArray![0].photo4 == "") {
                          toast('Photo not uploaded');
                        } else {
                          ref.watch(editablephoto.notifier).state = !edit;
                          setState(() {});

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.width *
                                      0.8, // Square popup
                                  child: Image.network(
                                    userdetails.basicDetailsArray![0].photo4
                                        .toString(),
                                    fit: BoxFit
                                        .contain, // Fit the image inside the square popup
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical! * 2,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            image: image4 != ""
                                ? DecorationImage(
                                    image: MemoryImage(
                                      base64Decode(image4),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : userdetails.basicDetailsArray![0].photo4
                                            .toString() !=
                                        ""
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          userdetails
                                              .basicDetailsArray![0].photo4
                                              .toString(),
                                        ))
                                    : null,
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12)),
                        child: image4 != ""
                            ? Stack(
                                children: [
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          UpdateUser().deletephoto(
                                              index: "3", ref: ref);
                                        });
                                        ref
                                            .watch(imageListProvider4.notifier)
                                            .state = "";
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 24,
                                        color: primary,
                                      ),
                                    ),
                                  ),
                                  // userdetails.basicDetailsArray![0].image3 != ""
                                  //     ? Positioned(
                                  //         top: 5,
                                  //         left: 5,
                                  //         child: IconButton(
                                  //             icon: Icon(
                                  //               Icons.delete,
                                  //               color: Colors.red,
                                  //             ),
                                  //             onPressed: () {
                                  //               setState(() {
                                  //                 UpdateUser().deletephoto(
                                  //                     index: "3", ref: ref);
                                  //               });
                                  //             }),
                                  //       )
                                  //     : SizedBox.shrink()
                                ],
                              )
                            : userdetails.basicDetailsArray![0].photo4 == ""
                                ? IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                leading:
                                                    Icon(Icons.photo_library),
                                                title:
                                                    Text('Upload from Gallery'),
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        processingPopup(
                                                            context: context,
                                                            msg:
                                                                "Uploading..."),
                                                  );
                                                  takeImages(
                                                          ref: ref,
                                                          index: 4,
                                                          sourceofpick:
                                                              ImageSource
                                                                  .gallery)
                                                      .whenComplete(
                                                          () => setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.camera_alt),
                                                title:
                                                    Text('Upload from Camera'),
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        processingPopup(
                                                            context: context,
                                                            msg:
                                                                "Uploading..."),
                                                  );
                                                  takeImages(
                                                          ref: ref,
                                                          index: 4,
                                                          sourceofpick:
                                                              ImageSource
                                                                  .camera)
                                                      .whenComplete(
                                                          () => setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            UpdateUser().deletephoto(
                                                index: "3", ref: ref);
                                          });
                                        }),
                                  ),
                      ),
                    ),
                  ])),
            ],
          ),
        ),
        bottomNavigationBar: ElevatedButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              var userid = prefs.getString('userid');
              log(image1.toString().isEmpty.toString());
              log(image2.toString().isEmpty.toString());
              log(image3.toString().isEmpty.toString());
              log(image4.toString().isEmpty.toString());
              UpdateUser()
                  .updateuserphoto(
                      photo0: image1 == "" ? "" : image1.toString(),
                      photo1: image2 == "" ? "" : image2.toString(),
                      photo2: image3 == "" ? "" : image3.toString(),
                      photo3: image4 == "" ? "" : image4.toString())
                  .whenComplete(() async {
                await getuserprofile(id: userid.toString(), ref: ref);
                ref.watch(imageListProvider1.notifier).state = "";
                ref.watch(imageListProvider2.notifier).state = "";
                ref.watch(imageListProvider3.notifier).state = "";
                ref.watch(imageListProvider4.notifier).state = "";
              });
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: primary,
                minimumSize: Size(width, 50)),
            child: Text(
              "Upload Image",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            )));
  }
}
