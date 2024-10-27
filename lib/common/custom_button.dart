import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class ButtonWidget extends StatefulWidget {
  final Function()? onTap;
  final ButtonType? type;
  final String? title;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final double? borderWidth;
  final double? borderRaduis;
  final double? height;
  const ButtonWidget({
    Key? key,
    this.onTap,
    required this.type,
    this.title,
    this.width,
    this.bgColor,
    this.textColor,
    this.borderWidth,
    this.borderRaduis,
    this.height,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  Widget getWidget() {
    InkWell widgetComponent;
    switch (widget.type!) {
      case ButtonType.primary:
        widgetComponent = InkWell(
          onTap: widget.onTap,
          child: Container(
            height: widget.height ?? 60,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.bgColor ?? Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(widget.borderRaduis ?? 10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case ButtonType.secondary:
        widgetComponent = InkWell(
          onTap: widget.onTap,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.transparent,
              border: Border.all(
                color: widget.bgColor ?? Color(0x7f000000),
                width: widget.borderWidth ?? 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title!,
                  style: TextStyle(
                    color: widget.textColor ?? Colors.black.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
        break;
    }

    return widgetComponent;
  }

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
}
