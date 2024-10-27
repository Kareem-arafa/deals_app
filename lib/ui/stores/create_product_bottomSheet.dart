import 'package:dealz/common/custom_button.dart';
import 'package:dealz/common/custom_button_sheet.dart';
import 'package:dealz/common/custom_textField.dart';
import 'package:dealz/common/custom_upload_pictures.dart';
import 'package:flutter/material.dart';

class CreateProductBottomSheet extends StatefulWidget {
  const CreateProductBottomSheet({
    super.key,
  });

  @override
  State<CreateProductBottomSheet> createState() => _CreateProductBottomSheetState();
}

class _CreateProductBottomSheetState extends State<CreateProductBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      height: MediaQuery.of(context).size.height - 100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            new Text(
              "Create Product",
              style: TextStyle(
                color: Color(0xff110c23),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: new Text(
                "Name",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              type: TextFieldType.text,
              hint: "Example",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: new Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              type: TextFieldType.text,
              hint: "087 018837599040",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 25,
            ),
            CustomUploadPictures(
              title: "Add Photos ",
              onImageSelected: (file) {},
              onImageRemoved: (File) {},
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: new Text(
                "Price",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              type: TextFieldType.text,
              hint: "087 018837599040",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: new Text(
                "Description",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              type: TextFieldType.text,
              hint: "087 018837599040",
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 25,
            ),
            ButtonWidget(
              type: ButtonType.primary,
              title: "Create",
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
