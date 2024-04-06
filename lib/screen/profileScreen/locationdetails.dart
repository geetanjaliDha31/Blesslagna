import 'package:blesslagna/API/paramerter_api/cityparameter.dart';
import 'package:blesslagna/API/paramerter_api/stateparameter.dart';
import 'package:blesslagna/API/profile_api/userprofile.dart';
import 'package:blesslagna/API/updateuserdata/updateuser.dart';
import 'package:blesslagna/color.dart';
import 'package:blesslagna/constant.dart';
import 'package:blesslagna/provider/findid.dart';
import 'package:blesslagna/provider/showloader.dart';
import 'package:blesslagna/provider/timefunction.dart';
import 'package:blesslagna/screen/basicinfoScreen/stepper_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationDetails extends ConsumerStatefulWidget {
  final String comefrom;
  const LocationDetails({super.key, required this.comefrom});

  @override
  ConsumerState<LocationDetails> createState() => _LocationDetailsState();
}

TextEditingController address = TextEditingController();
// TextEditingController mobileno = TextEditingController();
// TextEditingController phone = TextEditingController();
// TextEditingController nri = TextEditingController();

TimeOfDay? timecall;

class _LocationDetailsState extends ConsumerState<LocationDetails> {
  StateProvider editablelocation = StateProvider((ref) => false);

  final List residancelist = ["Select Residance", "NRI", "INDIAN"];
  String? residancetype = "Select Residance";

  @override
  Widget build(BuildContext context) {
    final countrytype = ref.watch(countryProvider);
    final country = ref.watch(onlycountryProvider);

    final statetype = ref.watch(stateProvider);
    final state = ref.watch(onlystateProvider);

    final citytype = ref.watch(cityProvider);
    final city = ref.watch(onlycityProvider);
    final userdetails = ref.watch(userdetailProvider);
    final phoneno = ref.watch(phonenoProvider);
    final edit = ref.watch(editablelocation);

    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        widget.comefrom == ''
            ? GestureDetector(
                onTap: () {
                  ref.watch(editablelocation.notifier).state = !edit;
                  setState(() {});
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: edit
                          ? SvgPicture.asset('assets/cross.svg')
                          : SvgPicture.asset('assets/edit.svg')),
                ),
              )
            : SizedBox.shrink(),
        widget.comefrom == ''
            ? const SizedBox.shrink()
            : RichText(
                text: TextSpan(
                  text: 'Location ',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xD9131313)),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: primary)),
                  ],
                ),
              ),
        const SizedBox(height: 24),
        //country dropdown
        !edit && widget.comefrom == ''
            ? defaultcontainer(
                text: userdetails.locationDetailsArray![0].country.toString())
            : DropdownButtonHideUnderline(
                child: Container(
                  width: width,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff9A9A9A)),
                      borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton2(
                    // buttonDecoration: shadowdecoration,
                    isExpanded: true,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    items: country.countriesArray!
                        .map((item) => DropdownMenuItem(
                              value: item.countryName,
                              child: Text(
                                item.countryName.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ))
                        .toList(),

                    value: countrytype,

                    onChanged: (value) {
                      showloader(context: context);
                      ref.watch(countryProvider.notifier).state =
                          value as String;
                      String id = findIdByName(
                          name: value.toString(),
                          list: country.countriesArray!,
                          type: "1");
                      getState(countryid: id.toString(), ref: ref).whenComplete(
                        () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ),
        const SizedBox(height: 20),
        //state dropdown
        !edit && widget.comefrom == ''
            ? defaultcontainer(
                text: userdetails.locationDetailsArray![0].state.toString())
            :
            //  Container(
            //     height: 70,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: const Color(0xff9A9A9A)),
            //         borderRadius: BorderRadius.circular(8)),
            //     child: SearchChoices.single(
            //       items: state.statesArray!
            //           .map((item) => DropdownMenuItem(
            //               value: item,
            //               child: Text(
            //                 item.stateName!,
            //               )))
            //           .toList(),
            //       value: statetype,
            //       style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           color: Colors.black),
            //       hint: "Select State",
            //       searchHint: "Search for State",
            //       onChanged: (newValue) {
            //         showloader(context: context);
            //         ref.watch(stateProvider.notifier).state =
            //             newValue as String;
            //         print(newValue);
            //         String id = findIdByName(
            //             name: newValue.toString(),
            //             list: state.statesArray!,
            //             type: "2");
            //         print('location$id');
            //         getcity(stateid: id.toString(), ref: ref).whenComplete(() {
            //           Navigator.pop(context);
            //           setState(() {});
            //         });
            //       },
            //       isExpanded: true,
            //       displayClearIcon: false, // Whether to display a clear icon
            //       underline: Container(), // To remove underline
            //       searchInputDecoration: InputDecoration(
            //         hintText: "Search...",
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //       ),
            //     ),
            //   ),
            DropdownButtonHideUnderline(
                child: Container(
                  width: width,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff9A9A9A)),
                      borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton2(
                    // buttonDecoration: shadowdecoration,
                    isExpanded: true,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    items: state.statesArray!
                        .map((item) => DropdownMenuItem(
                              value: item.stateName,
                              child: Text(
                                item.stateName.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ))
                        .toList(),
                    value: statetype,
                    onChanged: (value) {
                      showloader(context: context);
                      ref.watch(stateProvider.notifier).state = value as String;
                      print(value);
                      String id = findIdByName(
                          name: value.toString(),
                          list: state.statesArray!,
                          type: "2");
                      print('location$id');
                      getcity(stateid: id.toString(), ref: ref)
                          .whenComplete(() {
                        Navigator.pop(context);
                        setState(() {});
                      });
                    },
                  ),
                ),
              ),
        const SizedBox(height: 24),
        //city dropdown
        !edit && widget.comefrom == ''
            ? defaultcontainer(
                text: userdetails.locationDetailsArray![0].city.toString())
            : DropdownButtonHideUnderline(
                child: Container(
                  width: width,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff9A9A9A)),
                      borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton2(
                    // buttonDecoration: shadowdecoration,
                    isExpanded: true,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    items: city.citiesArray!
                        .map((item) => DropdownMenuItem(
                              value: item.cityName,
                              child: Text(
                                item.cityName.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ))
                        .toList(),
                    value: citytype,
                    onChanged: (value) {
                      ref.watch(cityProvider.notifier).state = value as String;
                    },
                  ),
                ),
              ),
        const SizedBox(height: 24),
        //address textfield
        TextFormField(
          controller: address,
          maxLines: 3,
          //border
          enabled: widget.comefrom == ""
              ? edit
                  ? true
                  : false
              : true,
          readOnly: widget.comefrom == ""
              ? edit
                  ? false
                  : true
              : false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

            //label
            floatingLabelStyle: TextStyle(
                color: textcolor, fontSize: 14, fontWeight: FontWeight.w400),
            label: Text(
              widget.comefrom == ''
                  ? userdetails.locationDetailsArray![0].address.toString()
                  : "Addresss ",
              style: TextStyle(
                fontSize: 14,
                color: textcolor,
              ),
            ),
            //hint text
            hintText: 'Shiv nagar....',
            hintStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
            //suffix
          ),
        ),
        const SizedBox(height: 24),
        TextFormField(
          //border
          keyboardType: TextInputType.number,
          // controller: phone,
          readOnly: true,
          enabled: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff9A9A9A)),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

            //label
            floatingLabelStyle: TextStyle(
                color: textcolor, fontSize: 14, fontWeight: FontWeight.w400),
            label: Text(
              widget.comefrom == ''
                  ? userdetails.locationDetailsArray![0].phone.toString()
                  : phoneno,
              style: TextStyle(
                fontSize: 14,
                color: textcolor,
              ),
            ),
            //hint text
            hintText: phoneno,
            hintStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: lighttext),
            //suffix
          ),
        ),
        const SizedBox(height: 24),
        //time to call time picker
        InkWell(
          onTap: () async {
            timecall = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context, //context of current state
            ).whenComplete(() {
              setState(() {});
            });
          },
          child: Container(
            width: width,
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: !edit && widget.comefrom == ''
                ? BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(
                            0x3f000000,
                          ), //New
                          blurRadius: 1.0,
                          offset: Offset(0, 0))
                    ],
                  )
                : BoxDecoration(
                    border: Border.all(color: const Color(0xff9A9A9A)),
                    borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Text(
                    widget.comefrom == ''
                        ? userdetails.locationDetailsArray![0].timeToCall
                            .toString()
                        : timecall == null
                            ? "Time to call"
                            : formatTimeOfDay(timecall!),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    CupertinoIcons.clock,
                    size: 20,
                    color: Color(0xff9A9A9A),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        //residence dropdown
        !edit && widget.comefrom == ''
            ? defaultcontainer(
                text: userdetails.locationDetailsArray![0].residence.toString())
            : DropdownButtonHideUnderline(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: width,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff9A9A9A)),
                      borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton2(
                    // buttonDecoration: shadowdecoration,
                    isExpanded: true,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    items: residancelist
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ))
                        .toList(),
                    value: residancetype,
                    onChanged: (value) {
                      setState(() {
                        residancetype = value as String;
                        ref.watch(nriProvider.notifier).state = value;
                      });
                    },
                  ),
                ),
              ),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(height: 24),
        widget.comefrom == '' && edit
            ? ElevatedButton(
                onPressed: () => locationdetailsupdatefuncationbtn(),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: primary,
                    minimumSize: Size(width, 50)),
                child: const Text(
                  "Update",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ))
            : const SizedBox.shrink()
      ]),
    );
  }

  locationdetailsupdatefuncationbtn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');
    final countrytype = ref.watch(countryProvider);
    final userdetails = ref.watch(userdetailProvider);
    final statetype = ref.watch(stateProvider);
    final citytype = ref.watch(cityProvider);
    final nriornot = ref.watch(nriProvider);
    UpdateUser()
        .updatelocation(
            country: countrytype == ""
                ? userdetails.locationDetailsArray![0].country.toString()
                : countrytype,
            state: statetype == ""
                ? userdetails.locationDetailsArray![0].state.toString()
                : statetype,
            city: citytype == ""
                ? userdetails.locationDetailsArray![0].city.toString()
                : citytype,
            address: address.text == ""
                ? userdetails.locationDetailsArray![0].address.toString()
                : address.text,
            timetocall: timecall == 'null'
                ? userdetails.locationDetailsArray![0].timeToCall.toString()
                : timecall.toString(),
            residence: nriornot == ""
                ? userdetails.locationDetailsArray![0].residence.toString()
                : nriornot,
            mobile: userdetails.locationDetailsArray![0].phone.toString())
        .whenComplete(() {
      setState(() async {
        await getuserprofile(id: userid.toString(), ref: ref);
        address.clear();
      });
    });
  }

  defaultcontainer({required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
              color: Color(
                0x3f000000,
              ), //New
              blurRadius: 1.0,
              offset: Offset(0, 0))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
