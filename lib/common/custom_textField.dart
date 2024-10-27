import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldType { text, password, phone }

class TextFieldWidget extends StatefulWidget {
  final TextFieldType? type;
  final TextEditingController? controller;
  final String? hint;
  final bool? enabled;
  final String? Function(String?)? onSubmitted;
  final Function()? onTap;
  final String? label;
  final TextInputType? keyboardType;
  final bool? authCorrect;
  final String? Function(String?)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? optional;
  final Color? color;
  final String? Function(String?)? validator;
  final int? maxLength;
  final String? caption;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isMandatory;
  final TextDirection? textDirection;
  final int? maxLines;
  final Color? borderColor;
  final double? padding;
  const TextFieldWidget({
    Key? key,
    @required this.type,
    this.controller,
    this.authCorrect,
    this.hint,
    this.enabled,
    this.onSubmitted,
    this.label,
    this.keyboardType,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.optional,
    this.color,
    this.validator,
    this.maxLength,
    this.inputFormatters,
    this.isMandatory,
    this.caption,
    this.onTap,
    this.textDirection,
    this.maxLines,
    this.borderColor,
    this.padding,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisible = false;
  Widget getContent() {
    Widget widgetComponent;
    switch (widget.type!) {
      case TextFieldType.text:
        widgetComponent = TextFormField(
          key: widget.key,
          onTap: widget.onTap,
          autocorrect: widget.authCorrect ?? true,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          validator: widget.validator,
          onFieldSubmitted: widget.onSubmitted,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters ?? [],
          maxLength: widget.maxLength,
          enabled: widget.enabled ?? true,
          controller: widget.controller,
          textInputAction: TextInputAction.done,
          maxLines: widget.maxLines,
          textDirection:
              widget.textDirection != null ? widget.textDirection! : null,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.padding ?? 20, horizontal: 12),
            labelText: widget.label,
            hintText: widget.hint,
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
            isDense: true,
            hintStyle: TextStyle(
              color: Color(0xffbebebe),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            filled: true,
            fillColor: Colors.white,
          ),
          onTapOutside: (action){
            FocusManager.instance.primaryFocus?.unfocus();
          },
        );
        break;
      case TextFieldType.phone:
        widgetComponent = Directionality(
          textDirection: TextDirection.ltr,
          child: TextFormField(
            obscureText: isVisible,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters ?? [],
            textDirection: TextDirection.ltr,
            maxLength: widget.maxLength,
            enabled: widget.enabled ?? true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
           // textAlign: TextAlign.left,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              labelText: widget.label,
              hintText: widget.hint,
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
              isDense: true,
              hintStyle: TextStyle(
                color: Color(0xffbebebe),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Container(
                width: MediaQuery.of(context).size.width / 3.5,
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+965',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        VerticalDivider(
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            onTapOutside: (action){
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        );
        break;
      case TextFieldType.password:
        widgetComponent = TextFormField(
          obscureText: !isVisible,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters ?? [],
          textDirection:
              widget.textDirection != null ? widget.textDirection! : null,
          maxLength: widget.maxLength,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: "",
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            labelText: widget.label,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            isDense: true,
            hintStyle: TextStyle(
              color: Color(0xffbebebe),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Icon(
                isVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Color(0xffbebebe),
                size: 22,
              ),
            ),
          ),
          onTapOutside: (action){
            FocusManager.instance.primaryFocus?.unfocus();
          },
        );
        break;
    }
    return widgetComponent;
  }

  @override
  Widget build(BuildContext context) {
    return getContent();
  }
}
