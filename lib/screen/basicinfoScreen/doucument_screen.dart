import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/screen/basicinfoScreen/photoupload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:blesslagna/provider/showloader.dart';
// import 'package:image_picker/image_picker.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  const DocumentScreen({super.key});

  @override
  ConsumerState<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  File? selecteddocumet;
  String base64documet = "";
  String documetpath = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var documentpath = ref.watch(userdocumentpicProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Column(
            children: [],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: grident),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Upload a Identity Proof',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            SvgPicture.asset('assets/uplode2.svg'),
            const SizedBox(height: 20),
            const Text(
              'Eg. Aadhar Card, Passport, Pan Card,\n Election Card',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff606060)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      documentpicker(ref: ref, context: context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: primary,
                      minimumSize: Size(width, 50)),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.photo,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: width / 6),
                      const Center(
                        child: Text(
                          "Upload Document",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),

            documentpath == ""
                ? SizedBox.shrink()
                : Container(
                    width: width,
                    color: const Color(0xffF8F8F8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/pdf.svg'),
                            SizedBox(
                              width: width / 3,
                              child: Text(
                                documentpath,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                            const Icon(CupertinoIcons.xmark)
                          ]),
                    ),
                  ),
            const SizedBox(height: 30),
            // ElevatedButton(
            //     onPressed: () => documentpicker(ref: ref, context: context),
            //     child: Text('test')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhotoUpload()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: primary,
                    minimumSize: Size(width, 50)),
                child: const Text(
                  "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                )),
          ],
        ),
      ),
    );
  }

  documentpicker(
      {required WidgetRef ref, required BuildContext context}) async {
    final documetimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (documetimage != null) {
        selecteddocumet = File(documetimage.path);
        documetpath = documetimage.path;
        selecteddocumet = File(documetimage.path);
      } else {
        toast('Document not Picked');
      }
    });
    Uint8List imagebytes = await documetimage!.readAsBytes();

    base64documet = base64.encode(imagebytes);

    ref.watch(userdocumentpicProvider.notifier).state = base64documet;
    toast('Photo Uploaded');
    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(allowMultiple: true);
    // if (result != null) {
    //   PlatformFile file = result.files.first;
    //   log(file.path.toString());
    //   selectedimage = File(file.path)
    //   Uint8List imagebytes = await file.readAsBytes();

    //   base64documet = base64.encode(imagebytes);
    //   ref.watch(userdocumentpicProvider.notifier).state = file.path.toString();
    //   // Navigator.pop(context);
    // } else {
    //   toast('Please Select File');
    // }
    // log(result!.files[0].path.toString());
    // result.files[0].path;
    // if (result != null) {
    //   List<File> files = result.paths.map((path) => File(path!)).toList();
    //   log(files.toString());
    // } else {
    //   // User canceled the picker
    // }
  }
}
//  InkWell(
//               onTap = () async {
//                 final documetimage =
//                     await ImagePicker().pickImage(source: ImageSource.camera);
//                 setState(() {
//                   if (documetimage != null) {
//                     selecteddocumet = File(documetimage.path);
//                     documetpath = documetimage.path;
//                     selecteddocumet = File(documetimage.path);
//                   } else {
//                     toast('Document not Picked');
//                   }
//                 });
//                 Uint8List imagebytes = await documetimage!.readAsBytes();

//                 base64documet = base64.encode(imagebytes);

//                 ref.watch(userdocumentpicProvider.notifier).state =
//                     base64documet;
//                 toast('Photo Uploaded');
//               },
//               child = SizedBox(
//                   child: Column(
//                 children: [
//                   Center(child: SvgPicture.asset('assets/uplode1.svg')),
//                   const SizedBox(height: 60),
//                   Center(
//                     child: Text(
//                       'Tap to Upload',
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: primary),
//                     ),
//                   ),
//                 ],
//               )),
//             ),