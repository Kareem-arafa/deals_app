import 'package:dealz/translate/translations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<dynamic>? items;
  final String? hint;
  final void Function(dynamic)? onChange;
  final dynamic value;
  final String? Function(dynamic)? validator;
  final Color? borderColor;

  const CustomDropdownButton({
    Key? key,
    this.items,
    this.hint,
    this.onChange,
    this.value,
    this.validator,
    this.borderColor,
  }) : super(key: key);

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      value: widget.value,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.white,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.white,
          ),
        ),
      ),
      isExpanded: true,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      hint: Text(
        widget.hint!,
        style: TextStyle(
          color: Color(0xffbebebe),
          fontWeight: FontWeight.w600,
          fontSize: 14,
          fontFamily: 'Almarai',
        ),
      ),
      buttonStyleData: ButtonStyleData(
        height: 55,
      ),
      iconStyleData: IconStyleData(
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xff0f0f0f),
          ),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: widget.items!
          .map(
            (item) => DropdownMenuItem<dynamic>(
              value: item,
              child: Text(
                item.name(Translations.of(context).currentLanguage),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Almarai',
                ),
              ),
            ),
          )
          .toList(),
      onChanged: widget.onChange,
    );
  }
}
