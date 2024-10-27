import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:flutter/material.dart';

class AvailableproductDialog extends StatefulWidget {
  const AvailableproductDialog({super.key});

  @override
  State<AvailableproductDialog> createState() => _AvailableproductDialogState();
}

class _AvailableproductDialogState extends State<AvailableproductDialog> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(
                "Tell Me When Availble",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                type: TextFieldType.text,
                controller: TextEditingController(),
                hint: "Email",
                borderColor: Color(0xff979797),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isCheck = !isCheck;
                  });
                },
                child: Row(
                  children: [
                    new Container(
                      width: 20,
                      height: 20,
                      decoration: new BoxDecoration(
                        color: isCheck
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: isCheck
                              ? Theme.of(context).primaryColor
                              : Color(0xff979797),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    new Text(
                      "I agree to be contacted by store.",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ButtonWidget(
                type: ButtonType.primary,
                title: "Submit",
              )
            ],
          ),
        ),
      ),
    );
  }
}
