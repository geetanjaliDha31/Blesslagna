import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PPMultiselect extends ConsumerStatefulWidget {
  final List items;
  final StateProvider<dynamic> providername;
  const PPMultiselect(
      {super.key, required this.items, required this.providername});

  @override
  ConsumerState<PPMultiselect> createState() => _PPMultiselectState();
}

class _PPMultiselectState extends ConsumerState<PPMultiselect> {
  final List<String> _selectedItems = [];

  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    convertlisttostring(educationlist: _selectedItems, ref: ref);
    Navigator.pop(context, _selectedItems);
  }

  convertlisttostring(
      {required List<String> educationlist, required WidgetRef ref}) {
    String temp = '';

    for (int i = 0; i < educationlist.length; i++) {
      if (i == educationlist.length - 1) {
        temp += educationlist[i];
      } else {
        temp += '${educationlist[i]},';
      }
    }
    ref.watch(widget.providername.notifier).state = temp;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
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
