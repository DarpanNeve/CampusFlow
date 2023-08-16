import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final int maxContentLines;
  final TextEditingController fieldController;

  BorderedTextField(
      {required this.hintText,
      required this.labelText,
      required this.fieldController,
      required this.maxContentLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: TextField(
          maxLines: maxContentLines,
          controller: fieldController,
          decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: hintText,
              labelText: labelText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ));
  }
}
