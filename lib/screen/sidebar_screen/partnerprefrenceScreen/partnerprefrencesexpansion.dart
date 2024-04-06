import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/basicdetailspp.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/educationdetailspp.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/lifestyledetails.dart';
import 'package:blesslagna/screen/sidebar_screen/partnerprefrenceScreen/religiondetailspp.dart';
import 'package:flutter/material.dart';

class ExpansionPanelDemo extends StatefulWidget {
  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  List<ExpansionItem> _expansionItems = [
    ExpansionItem(
      headerText: 'Basic Preference',
      screen: BasicDetailsPP(),
    ),
    ExpansionItem(
      headerText: 'Religious Preference',
      screen: ReligionDetailsPP(),
    ),
    ExpansionItem(
      headerText: 'Location Preference',
      screen: LifestyleDetailsPP(),
    ),
    ExpansionItem(
      headerText: 'Education Preference',
      screen: EducationDetailsPP(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expansion Panel Demo'),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _expansionItems[index].isExpanded = !isExpanded;
            });
          },
          children: _expansionItems.map((item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerText),
                );
              },
              body: item.screen,
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ExpansionItem {
  final String headerText;
  final Widget screen;
  bool isExpanded;

  ExpansionItem(
      {required this.headerText,
      required this.screen,
      this.isExpanded = false});
}
