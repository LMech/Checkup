import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    required this.onChanged,
    required this.onSaved,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final int minLines;
  final bool obscureText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        filled: true,
        fillColor: Colors.black45,
        labelText: labelText,
      ),
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: null,
      minLines: minLines,
      validator: validator,
    );
  }
}
