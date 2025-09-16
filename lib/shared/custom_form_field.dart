import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
  });

  final String label, hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return (value != '') ? null : 'Please enter $label';
      },
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}
