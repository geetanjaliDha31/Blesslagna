import 'package:blesslagna/color.dart';
import 'package:blesslagna/provider/timefunction.dart';
import 'package:blesslagna/screen/basicinfoScreen/doucument_screen.dart';
import 'package:blesslagna/screen/profileScreen/basicdetails.dart';
import 'package:blesslagna/screen/profileScreen/educationdetails.dart';
import 'package:blesslagna/screen/profileScreen/familiydetails.dart';
import 'package:blesslagna/screen/profileScreen/lifestyledetails.dart';
import 'package:blesslagna/screen/profileScreen/locationdetails.dart';
import 'package:blesslagna/screen/profileScreen/religiousdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StepperScreen extends ConsumerStatefulWidget {
  const StepperScreen({super.key});

  @override
  ConsumerState<StepperScreen> createState() => _StepperScreenState();
}

StateProvider usernameProvider = StateProvider((ref) => '');
StateProvider hobbiesProvider = StateProvider((ref) => '');
StateProvider heighProvider = StateProvider((ref) => 'Height');
StateProvider weightProvider = StateProvider((ref) => '');
StateProvider brithplaceProvider = StateProvider((ref) => '');
StateProvider selectdateProvider = StateProvider((ref) => '');
StateProvider selecttimeProvider = StateProvider((ref) => '');
StateProvider mothertoungeProvider = StateProvider((ref) => 'Mother Tounge');
StateProvider languageknownProvider = StateProvider((ref) => '');
StateProvider martitalstatusProvider = StateProvider((ref) => 'Marital Status');

StateProvider religionProvider = StateProvider((ref) => 'Select Religon');
StateProvider castProvider = StateProvider((ref) => 'Select Cast');
StateProvider subcastProvider = StateProvider((ref) => '');
StateProvider horoscopeProvider = StateProvider((ref) => '');
StateProvider starProvider = StateProvider((ref) => '');
StateProvider gotraProvider = StateProvider((ref) => '');
StateProvider rnameProvider = StateProvider((ref) => '');
StateProvider manglikProvider = StateProvider((ref) => 'Are You Manglik');
StateProvider moonsignProvider = StateProvider((ref) => '');

StateProvider educationProvider = StateProvider((ref) => '');
StateProvider occupationProvider = StateProvider((ref) => '');
StateProvider employeeProvider = StateProvider((ref) => '');
StateProvider designnationProvider = StateProvider((ref) => '');
StateProvider incomeProvider = StateProvider((ref) => '');

StateProvider bodytypeProvider = StateProvider((ref) => 'Body Type');
StateProvider skintoneProvider = StateProvider((ref) => 'Skin Tone');
StateProvider bloodtypeProvider = StateProvider((ref) => 'Blood Type');
StateProvider eatProvider = StateProvider((ref) => 'Eating Habbits');
StateProvider smokeProvider = StateProvider((ref) => 'Smoking Habbits');
StateProvider drinkProvider = StateProvider((ref) => 'Drinking Habbits');

StateProvider countryProvider = StateProvider((ref) => 'India');
StateProvider cityProvider = StateProvider((ref) => 'City');
StateProvider stateProvider = StateProvider((ref) => 'Maharashtra');
StateProvider addressProvider = StateProvider((ref) => '');
// StateProvider mobilenoProvider = StateProvider((ref) => '');
StateProvider phonenoProvider = StateProvider((ref) => '');
StateProvider timetocallProvider = StateProvider((ref) => '');
StateProvider nriProvider = StateProvider((ref) => 'Select Residance');

StateProvider familytypeProvider = StateProvider((ref) => 'Joint');
StateProvider mothernameProvider = StateProvider((ref) => '');
StateProvider motherjobProvider = StateProvider((ref) => '');
StateProvider fathernameProvider = StateProvider((ref) => '');
StateProvider fatherjobProvider = StateProvider((ref) => '');
StateProvider nobroProvider = StateProvider((ref) => 'No. of Brother');
StateProvider nosisProvider = StateProvider((ref) => 'No. of Sister');
StateProvider nobromProvider = StateProvider((ref) => 'Married Brother');
StateProvider nosismProvider = StateProvider((ref) => 'Married Sister');
StateProvider aboutfamilyProvider = StateProvider((ref) => '');

class _StepperScreenState extends ConsumerState<StepperScreen> {
  List<Step> stepList() => [
        Step(
            title: const Text(''),
            content: const BasicDetails(
              comefrom: 'stepper',
            ),
            isActive: currentStep >= 0),
        Step(
            title: const Text(''),
            content: const Religiousdetails(comefrom: 'stepper'),
            isActive: currentStep >= 1),
        Step(
            title: const Text(''),
            content: const EducationDetails(comefrom: 'stepper'),
            isActive: currentStep >= 2),
        Step(
            title: const Text(''),
            content: const LifeStyleDetails(comefrom: 'stepper'),
            isActive: currentStep >= 3),
        Step(
            title: const Text(''),
            content: const LocationDetails(comefrom: 'stepper'),
            isActive: currentStep >= 4),
        Step(
            title: const Text(''),
            content: const FamilyDetails(comefrom: 'stepper'),
            isActive: currentStep >= 5),
      ];
  int currentStep = 0;
  //next
  continueStep() {
    if (currentStep == 0) {
      final pickdate = ref.watch(selectdateProvider);
      Future.delayed(const Duration(milliseconds: 200)).whenComplete(() {
        ref.watch(hobbiesProvider.notifier).state = hobbiestext.text;
        ref.watch(weightProvider.notifier).state = weighttext.text;
        ref.watch(brithplaceProvider.notifier).state = brithplacetext.text;
        ref.watch(selectdateProvider.notifier).state = pickdate.toString();
        ref.watch(selecttimeProvider.notifier).state =
            formatTimeOfDay(timebrith!);
        ref.watch(languageknownProvider.notifier).state =
            languagekhowntext.text;
        // ref.watch(usernameProvider.notifier).state = username.text;
        // ref.watch(heighProvider.notifier).state = height.text;
        // ref.watch(mothertoungeProvider.notifier).state = mothertounge.text;
        // ref.watch(martitalstatusProvider.notifier).state = mariedtypeuser;
      });
    } else if (currentStep == 1) {
      Future.delayed(const Duration(milliseconds: 200)).whenComplete(() {
        ref.watch(subcastProvider.notifier).state = subcast2.text;
        ref.watch(horoscopeProvider.notifier).state = horoscope.text;
        ref.watch(starProvider.notifier).state = star.text;
        ref.watch(gotraProvider.notifier).state = gotra.text;
        ref.watch(rnameProvider.notifier).state = namereligious.text;
        ref.watch(moonsignProvider.notifier).state = moonsign.text;
        // ref.watch(castProvider.notifier).state = cast2.text;
        // ref.watch(manglikProvider.notifier).state = manglik.text;
        // ref.watch(religionProvider.notifier).state = religontype;
      });
    } else if (currentStep == 2) {
      // convertlisttostring();
      ref.watch(occupationProvider.notifier).state = occupation.text;
      ref.watch(employeeProvider.notifier).state = employee.text;
      ref.watch(designnationProvider.notifier).state = designation.text;
      // ref.watch(incomeProvider.notifier).state = icome.text;
      // ref.watch(educationProvider.notifier).state = education.text;
    } else if (currentStep == 3) {
      // ref.watch(bodytypeProvider.notifier).state = bodytype.text;
      // ref.watch(skintoneProvider.notifier).state = skintone.text;
      // ref.watch(bloodtypeProvider.notifier).state = booldtype;
      // ref.watch(eatProvider.notifier).state = eattype;
      // ref.watch(smokeProvider.notifier).state = smoketype;
      // ref.watch(drinkProvider.notifier).state = drinktype;
    } else if (currentStep == 4) {
      ref.watch(addressProvider.notifier).state = address.text;
      ref.watch(timetocallProvider.notifier).state = formatTimeOfDay(timecall!);
      // ref.watch(countryProvider.notifier).state = countrytype;
      // ref.watch(cityProvider.notifier).state = city;
      // ref.watch(phonenoProvider.notifier).state = phone.text;
      // ref.watch(mobilenoProvider.notifier).state = mobileno.text;
      // ref.watch(nriProvider.notifier).state = nri.text;
    } else if (currentStep == 5) {
      ref.watch(mothernameProvider.notifier).state = mothername.text;
      ref.watch(motherjobProvider.notifier).state = motherjob.text;
      ref.watch(fathernameProvider.notifier).state = fathername.text;
      ref.watch(fatherjobProvider.notifier).state = fatherjob.text;
      ref.watch(aboutfamilyProvider.notifier).state = about.text;
      // ref.watch(familytypeProvider.notifier).state = familtytype;
      // ref.watch(nobroProvider.notifier).state = nobro.text;
      // ref.watch(nosisProvider.notifier).state = nosis.text;
      // ref.watch(nobromProvider.notifier).state = nombro.text;
      // ref.watch(nosismProvider.notifier).state = nomsis.text;
    }
    if (currentStep < 5) {
      setState(() {
        currentStep = currentStep + 1;
      });
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DocumentScreen()));
    }
  }

  //cancel
  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  //tap
  onStepTapped(int value) {
    setState(() {
      print('me3');
      currentStep = value;
    });
  }

  //nextbutton Widget
  Widget controlsBuilder(context, details) {
    return Row(
      children: [
        InkWell(
            onTap: () => cancelStep(),
            child: SvgPicture.asset('assets/backward.svg')),
        const Spacer(),
        InkWell(
            onTap: () => continueStep(),
            child: SvgPicture.asset('assets/forward.svg')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const SizedBox.shrink(),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: grident),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'assets/logo.png',
                height: 100,
                width: 100,
              ),
            ),
          ),
        ),
      ),
      body: Theme(
        data: ThemeData(
            canvasColor: Colors.white,
            colorScheme: ColorScheme.light(primary: primary)),
        child: Stepper(
            elevation: 0,
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: cancelStep,
            onStepContinue: continueStep,
            onStepTapped: onStepTapped,
            controlsBuilder: controlsBuilder,
            steps: stepList()),
      ),
    );
  }
}

// /Stepper(currentStep: currentStep, steps: stepList()),
