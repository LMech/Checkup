import 'package:flutter/material.dart';
import 'package:get/get.dart';
/*
DropdownPicker(
                menuOptions: list of dropdown options in key value pairs,
                selectedOption: menu option string value,
                onChanged: (value) => print('changed'),
              ),
*/

class DropdownPickerWithIcon extends StatelessWidget {
  const DropdownPickerWithIcon({
    required this.menuOptions,
    required this.selectedOption,
    required this.onChanged,
    required this.icon,
  });

  final List<DropdownMenuItem<String>> menuOptions;
  final String selectedOption;
  final void Function(String?) onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Get.theme.toggleableActiveColor)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        icon: Icon(icon),
        items: menuOptions,
        value: selectedOption,
        onChanged: onChanged,
      ),
    );
  }
}
