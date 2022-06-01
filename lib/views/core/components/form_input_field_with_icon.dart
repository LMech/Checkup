import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  const FormInputFieldWithIcon({
    Key? key,
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
    this.onEditdingComplete,
    this.edgeInsets,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onEditdingComplete;
  final TextEditingController controller;
  final IconData iconPrefix;
  final TextInputType keyboardType;
  final String labelText;
  final int? maxLines;
  final int minLines;
  final bool obscureText;
  final EdgeInsets? edgeInsets;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(iconPrefix),
          labelText: labelText,
          contentPadding: edgeInsets,
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
      ),
    );
  }
}
