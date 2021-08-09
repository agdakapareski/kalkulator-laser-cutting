import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String selectedItem;
  final List<String> listItem;
  final String title;
  const CustomDropDown({
    Key key,
    this.selectedItem,
    this.listItem,
    this.title,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    String selected = widget.selectedItem;
    List<String> item = widget.listItem;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(widget.title),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: 'kerumitan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                isEmpty: selected == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selected,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        selected = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: item.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String suffixText;
  final TextInputType keyboardType;
  const CustomTextField({
    Key key,
    this.hintText,
    this.controller,
    this.suffixText,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          suffixText: suffixText,
          isDense: true,
        ),
      ),
    );
  }
}
