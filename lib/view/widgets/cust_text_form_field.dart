import 'package:flutter/material.dart';

class CustTextFormField extends StatelessWidget {
  const CustTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.name,
    this.validator,
    this.obscureText,
    this.suffix,
  });
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        textCapitalization: TextCapitalization.words,
        validator: validator,

        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          label: Text(label),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          suffix: suffix ?? SizedBox(),
          focusColor: Colors.brown[700],
          hoverColor: Colors.brown[700],
          fillColor: Colors.brown[700],
        ),
      ),
    );
  }
}
