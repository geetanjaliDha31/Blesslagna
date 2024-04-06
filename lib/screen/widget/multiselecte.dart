import 'package:blesslagna/screen/profileScreen/educationdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiSelect extends ConsumerStatefulWidget {
  final List items;
  final String type;

  const MultiSelect({
    Key? key,
    required this.items,
    required this.type,
  }) : super(key: key);

  @override
  ConsumerState<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends ConsumerState<MultiSelect> {
  // this variable holds the selected items
  final StateProvider<List<String>> selectedItemsProvider =
      StateProvider((ref) => []);

// This function is triggered when a checkbox is checked or unchecked
  Future _itemChange(String itemValue, bool isSelected) async {
    if (isSelected) {
      ref.watch(selectedItemsProvider).add(itemValue);
    } else {
      ref.watch(selectedItemsProvider).remove(itemValue);
    }
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    // if (_selectedItems.length > 1) {
    //   toast('only one cast allow');
    // } else {
    convertlisttostring(
        educationlist: ref.watch(selectedItemsProvider),
        ref: ref,
        type: widget.type);
    Navigator.pop(context, ref.watch(selectedItemsProvider));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                  value: ref
                      .watch(selectedItemsProvider)
                      .contains(widget.type == 'education'
                          ? item
                          : widget.type == 'country'
                              ? item.countryName.toString()
                              : widget.type == 'state'
                                  ? item.stateName.toString()
                                  : widget.type == 'city'
                                      ? item.cityName.toString()
                                      : widget.type == 'marital'
                                          ? item
                                          : item),
                  title: Text(widget.type == 'education'
                      ? item
                      : widget.type == 'education'
                          ? item
                          : widget.type == 'country'
                              ? item.countryName.toString()
                              : widget.type == 'state'
                                  ? item.stateName.toString()
                                  : widget.type == 'city'
                                      ? item.cityName.toString()
                                      : widget.type == 'marital'
                                          ? item
                                          : item),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isChecked) {
                    if (widget.type == 'education') {
                      _itemChange(item, isChecked!)
                          .whenComplete(() => setState(() {}));
                    }
                    if (widget.type == 'country') {
                      _itemChange(item.countryName.toString(), isChecked!)
                          .whenComplete(() => setState(() {}));
                    }
                    if (widget.type == 'state') {
                      _itemChange(item.stateName.toString(), isChecked!)
                          .whenComplete(() => setState(() {}));
                    }
                    if (widget.type == 'city') {
                      _itemChange(item.cityName.toString(), isChecked!)
                          .whenComplete(() => setState(() {}));
                    }
                    if (widget.type == 'marital') {
                      _itemChange(item.toString(), isChecked!)
                          .whenComplete(() => setState(() {}));
                    }
                    if (widget.type == 'mother') {
                      _itemChange(item.toString(), isChecked!)
                          .whenComplete(() => setState(() {}));
                    }
                  }))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
