import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String suffixText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.suffixText,
    required this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          suffixText: widget.suffixText,
          isDense: true,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
