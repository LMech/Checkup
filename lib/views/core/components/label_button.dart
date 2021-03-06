import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  const LabelButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
  }) : super(key: key);

  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        labelText,
      ),
    );
  }
}
