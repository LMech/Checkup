import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

@immutable
class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon(
      {Key? key,
      required this.controller,
      required this.iconPrefix,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.onTap,
      this.onChanged,
      this.onSaved,
      this.onEditdingComplete})
      : super(key: key);

  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  void Function()? onTap;
  void Function(String)? onChanged;
  void Function(String?)? onSaved;
  void Function()? onEditdingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(iconPrefix),
        labelText: labelText,
      ),
      controller: controller,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      onEditingComplete: onEditdingComplete,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
    );
  }
}
