import 'package:dealz/common/custom_button.dart';
import 'package:dealz/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class PlaceAddConfirmDialog extends StatelessWidget {
  const PlaceAddConfirmDialog({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.store.path,
                height: 80,
              ),
              SizedBox(
                height: 15,
              ),
              new Text(
                "Do you want to add your account data to the Store or add other data?",
                style: TextStyle(
                  color: Color(0xff110c23),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      height: 50,
                      type: ButtonType.primary,
                      bgColor: Color(0xffd1d1d1),
                      borderRaduis: 50,
                      title: "Cancel",
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: ButtonWidget(
                      height: 50,
                      type: ButtonType.primary,
                      borderRaduis: 50,
                      title: "Confirm",
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
