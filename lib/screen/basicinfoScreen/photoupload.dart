import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:blesslagna/API/login_api/createprofile.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/imagecropper.dart';
import 'package:blesslagna/provider/showloader.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:blesslagna/screen/sidebar_screen/packages_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoUpload extends ConsumerStatefulWidget {
  const PhotoUpload({super.key});

  @override
  ConsumerState<PhotoUpload> createState() => _PhotoUploadState();
}

class _PhotoUploadState extends ConsumerState<PhotoUpload> {
  File? selectedimage;
  String base64image = "";
  String imagepath = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
        child: Center(
          child: Column(children: [
            const Text(
              'Upload Photo',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            SvgPicture.asset('assets/uplode2.svg'),
            const Text(
              'Add your Photos to Complete your \n Profile',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                  onPressed: () async {
                    final galleryimage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    String cropFile =
                        await userImagecopper(pickedFile: galleryimage);
                    setState(() {
                      selectedimage = File(cropFile);
                      imagepath = cropFile;
                    });
                    Uint8List imagebytes = await selectedimage!.readAsBytes();

                    base64image = base64.encode(imagebytes);

                    ref.watch(userprofilepicProvider.notifier).state =
                        base64image;
                    toast('Photo Uploaded');
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
                          "Import from gallery",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                  onPressed: () async {
                    final cameraimage = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    setState(() {
                      if (cameraimage != null) {
                        selectedimage = File(cameraimage.path);
                        imagepath = cameraimage.path;
                        selectedimage = File(cameraimage.path);
                      } else {
                        toast('Image not Picked');
                      }
                    });
                    Uint8List imagebytes = await selectedimage!.readAsBytes();

                    base64image = base64.encode(imagebytes);

                    ref.watch(userprofilepicProvider.notifier).state =
                        base64image;
                    toast('Photo Uploaded');
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(color: primary),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.white,
                      minimumSize: Size(width, 50)),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.camera_fill,
                        color: primary,
                        size: 24,
                      ),
                      SizedBox(width: width / 6),
                      Center(
                        child: Text(
                          "Take photo camera",
                          style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            imagepath.isEmpty
                ? SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    width: width,
                    color: const Color(0xffF8F8F8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/pdf.svg'),
                            SizedBox(width: 20),
                            SizedBox(
                              width: width / 3,
                              child: Text(
                                imagepath,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                    ),
                  ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () => uplodbtnfun(),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: primary,
                      minimumSize: Size(width, 50)),
                  child: const Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  )),
            ),
            const SizedBox(height: 20)
          ]),
        ),
      ),
    );
  }

  uplodbtnfun() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final username = ref.watch(usernameProvider);
    final hobbies = ref.watch(hobbiesProvider);
    final height = ref.watch(heighProvider);
    final weight = ref.watch(weightProvider);
    final brithplace = ref.watch(brithplaceProvider);
    final dob = ref.watch(selectdateProvider);
    final timebrith = ref.watch(selecttimeProvider);
    final motherthounge = ref.watch(mothertoungeProvider);
    final languageknow = ref.watch(languageknownProvider);
    final martitalstat = ref.watch(martitalstatusProvider);

    final religion = ref.watch(religionProvider);
    final usercast = ref.watch(castProvider);
    final usersubcast = ref.watch(subcastProvider);
    final horoscope = ref.watch(horoscopeProvider);
    final star = ref.watch(starProvider);
    final gotra = ref.watch(gotraProvider);
    // final rname = ref.watch(rnameProvider);
    final manglik = ref.watch(manglikProvider);
    final moonsign = ref.watch(moonsignProvider);

    final eduction = ref.watch(educationProvider);
    final occupation = ref.watch(occupationProvider);
    final empolyee = ref.watch(employeeProvider);
    final designation = ref.watch(designnationProvider);
    final income = ref.watch(incomeProvider);

    final bodytype = ref.watch(bodytypeProvider);
    final skintone = ref.watch(skintoneProvider);
    final blood = ref.watch(bloodtypeProvider);
    final eathabit = ref.watch(eatProvider);
    final smokinhabit = ref.watch(smokeProvider);
    final drinkhabit = ref.watch(drinkProvider);

    final country = ref.watch(countryProvider);
    final city = ref.watch(cityProvider);
    final state = ref.watch(stateProvider);
    final address = ref.watch(addressProvider);
    // final moibileno = ref.watch(mobilenoProvider);
    final phoneno = ref.watch(phonenoProvider);
    final timetocall = ref.watch(timetocallProvider);
    final nri = ref.watch(nriProvider);

    final familytype = ref.watch(familytypeProvider);
    final mothername = ref.watch(mothernameProvider);
    final motherjob = ref.watch(motherjobProvider);
    final fathername = ref.watch(fathernameProvider);
    final fatherjob = ref.watch(fatherjobProvider);
    final nobro = ref.watch(nobroProvider);
    final nosis = ref.watch(nosisProvider);
    final nomabro = ref.watch(nobromProvider);
    final nomasis = ref.watch(nosismProvider);
    final aboutfamily = ref.watch(aboutfamilyProvider);
    final image = ref.watch(userprofilepicProvider);
    final userpickdocument = ref.watch(userdocumentpicProvider);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          processingPopup(context: context, msg: "Processing...."),
    );

    await createprofile(
            ref: ref,
            userid: userid.toString(),
            username: username,
            height: height,
            dob: dob,
            maritalstatus: martitalstat,
            hobbies: hobbies,
            weight: weight,
            birthtime: timebrith,
            //
            noofchildren: '0',
            //
            mothertounge: motherthounge,
            language: languageknow,
            brithplace: brithplace,
            //
            profilecreateby: 'self',
            //
            religion: religion,
            cast: usercast,
            subcast: usersubcast,
            manglikstatus: manglik,
            star: star,
            horoscope: horoscope,
            gotra: gotra,
            moonsign: moonsign,
            education: eduction,
            occupation: occupation,
            annualincome: income,
            employeein: empolyee,
            designation: designation,
            bodytype: bodytype,
            skintype: skintone,
            bloodgroup: blood,
            eatinghabit: eathabit,
            smokinghabit: smokinhabit,
            country: country,
            drinkinghabit: drinkhabit,
            state: state,
            city: city,
            address: address,
            mobile: phoneno,
            phone: phoneno,
            timetocall: timetocall,
            residence: nri,
            familytype: familytype,
            fathername: fathername,
            fatheroccupation: fatherjob,
            mothername: mothername,
            motheroccupation: motherjob,
            noofbrothers: nobro,
            noofsisters: nosis,
            nomarriedbrothers: nomabro,
            nomarriedsisters: nomasis,
            aboutfamily: aboutfamily,
            userimage: image,
            userdocument: userpickdocument)
        .then((value) {
      print(value);
      if (value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PackageScreen(
                      comefrom: 'photo',
                    )));
      } else {
        toast('something went Wrong');
      }
    });
  }
}
