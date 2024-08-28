import 'package:flutter/material.dart';

import '../../theme.dart';

class CustomForm extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  final bool isPassword;

  const CustomForm({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.isPassword = false, // Tambahkan parameter ini
  });

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.isPassword ? _isObscure : false, // Atur obscureText
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cPrimary),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cPrimary),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: cPrimary,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
        contentPadding: const EdgeInsets.only(left: 10, top: 10),
      ),
    );
  }
}